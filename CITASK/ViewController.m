//
//  ViewController.m
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import "ViewController.h"
#import "RestaurantParser.h"
#import "MainScreenTableViewCell.h"
#import "RestaurantModel.h"
#import "RestaurantCategoryModel.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImageView+WebCache.h"


#define PI  3.141592653589793
#define EARTH_RADIUS_IN_KM 6371
#define EARTH_RADIUS_IN_METERS 3959

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,RestaurantParserDelegate,CLLocationManagerDelegate>
{
    BOOL locationBool;
}
@property(strong, nonatomic) UITableView *tableOfRestaurant;
@property(strong, nonatomic) RestaurantParser *parser;
@property(strong, nonatomic) NSArray *dataReceived;

//

@property(strong, nonatomic)CLLocationManager *locationManager;
@property(nonatomic) float latitude;
@property(nonatomic) float longitude;
@property(nonatomic)CLLocationCoordinate2D myLocation2D;

@property(nonatomic)CLLocationCoordinate2D restaurantLocation2D;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Nearby Restaurants";
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    } else {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
        
        self.navigationController.navigationBar.translucent = NO;
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // This function will fetch users current location, every time when this screen gets loaded
    [self getCurrentLocation];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Getting Current Location

-(void) getCurrentLocation{
    
    if (self.locationManager == nil)
    {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        //Asking for permission to user for fetching current location
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        //this will start updating users location and will give call backs as it changes
        [self.locationManager startUpdatingLocation];
        
        
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    locationBool = TRUE;
    CLLocation *newLocation = [locations lastObject];
    
    if (newLocation.horizontalAccuracy < 0)
    {
        return;
    }
    
    NSTimeInterval interval = [newLocation.timestamp timeIntervalSinceNow];
    
    if (abs(interval) < 30)
    {
        self.latitude = newLocation.coordinate.latitude;
        self.longitude = newLocation.coordinate.longitude;
        
        
        //this is our location cordinates which will be used to calculate the distance between nearby restaurants
        self.myLocation2D =  CLLocationCoordinate2DMake(self.latitude, self.longitude);
        
        
    }
    
    //this will stop fetching users location
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    self.locationManager.delegate = nil;
    
    [self loadResturantParser];
    
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    /*If user doesnt allows permission for fetching location, we can give dummy location and load the content*/
    
    [self loadResturantParser];
    
    locationBool = FALSE;
}

#pragma mark - loading data from parser
-(void)loadResturantParser
{
    if (!_parser) {
        
        _parser = [[RestaurantParser alloc]init];
        _parser.delegate = self;
        
        //as we are not connecting to internet, directly fetcing data
        [_parser restaurantDidReceivedData];
    }
    
    
}



#pragma mark ParserDelegateMethods

-(void)restaurantDidReceivedData:(NSArray *)receivedData
{
    if (receivedData != nil) {
        
        
        _dataReceived = receivedData;
        
        //checking if user allowed location permission, yoou can sohw alert here to turn on location permission for the app
        if (locationBool == FALSE)
        {
            [self loadTableOfRestaurant];
            NSLog(@"please enable your location");
            
        }
        else
        {
            
            for (RestaurantModel *model in _dataReceived){
                
                float restaurantLatitude = model.Latitude;
                float restaurantLongitude = model.Longitude;
                
                self.restaurantLocation2D =   CLLocationCoordinate2DMake(restaurantLatitude, restaurantLongitude);
                
                //model distance peoperty stores the distance of all restaurants in double, this property will be used to sort the distance in ascending order in sortedDistance function
                
                model.modelDistace =  [self kilometresBetweenPlace1:self.myLocation2D andPlace2:self.restaurantLocation2D];
                
                
            }
            
            [self sortedDistance];
            
        }
    }
    
    
    
}

#pragma Sorting Distance

-(void) sortedDistance
{
    //using modelDistace preperty in our Main model we sort the restaurants ascending order
    
    _dataReceived = [NSArray arrayWithArray:[_dataReceived sortedArrayUsingComparator:^NSComparisonResult(RestaurantModel *object1, RestaurantModel *object2) {
        
        if (object1.modelDistace > object2.modelDistace)
        {
            return (NSComparisonResult)NSOrderedDescending;
        } else if (object1.modelDistace< object2.modelDistace)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
        
    }]];
    
    //after sorting finally load the table
    [self loadTableOfRestaurant];
    
    
}


-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2
{
    /*converting lat long to double and calculating nearby resutarnt is best good approach*/
    
    double dlon = [self convertToRadians:(place2.longitude - place1.longitude)];
    double dlat = [self convertToRadians:(place2.latitude - place1.latitude)];
    
    double a =  pow(sin(dlat / 2), 2) + cos([self convertToRadians:(place1.latitude)]) * cos([self convertToRadians:(place2.latitude)]) * pow(sin(dlon / 2), 2);
    double angle = 2 * asin(sqrt(a));
    
    return (angle * EARTH_RADIUS_IN_KM);
}

-(double) convertToRadians:(double) val
{
    return (val * (PI / 180));
}


#pragma loading Table

-(void) loadTableOfRestaurant
{
    
    self.tableOfRestaurant = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    
    _tableOfRestaurant.delegate = self;
    _tableOfRestaurant.dataSource = self;
    [self.tableOfRestaurant setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin];
    
    [self.view addSubview:_tableOfRestaurant];
}


#pragma mark TableDelegateMethods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataReceived.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainScreenTableViewCell *mycell;
    
    mycell  = [_tableOfRestaurant dequeueReusableCellWithIdentifier:@"apps"];
    
    if (mycell == nil)
    {
        mycell = [[MainScreenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"apps"];
    }
    //fetching each model and assigning values accordingly
    RestaurantModel *model = [_dataReceived objectAtIndex:indexPath.row];
    mycell.labelOutletName.text = model.OutletName;
    
    [mycell.imageForLogo sd_setImageWithURL:[NSURL URLWithString:model.LogoURL] placeholderImage:[UIImage imageNamed:@"default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error)
        {
          //  NSLog(@"url error: can't download image");
            
            
        }
        
    }];
    
    mycell.labelOffers.text = [NSString stringWithFormat:@"%@ Offers",model.NumCoupons];
    mycell.labelCategoryNameOne.text = [NSString stringWithFormat:@"• %@",model.categoryTypeToShow];
    mycell.labelDistance.text = [NSString stringWithFormat:@"%0.02f km",model.modelDistace];
    mycell.labelNeighbourhoodName.text = model.NeighbourhoodName;
    
    
    return mycell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
}



@end
