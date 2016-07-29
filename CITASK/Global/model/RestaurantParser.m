//
//  RestaurantParser.m
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

//class name is RestaurantParser but we are not downloading data from web #hence,Connection error methods are not implemented. We are fetching data locally and parsing it.

#import "RestaurantParser.h"
#import "RestaurantModel.h"
#import "RestaurantCategoryModel.h"

@interface RestaurantParser ()

@property(strong, nonatomic)NSMutableArray *arrayOfReceivedData;

@end

@implementation RestaurantParser


#pragma mark main

-(id)init
{
    if (self) {
        self = [super init];
        
    }
    
    return self;
}


#pragma mark didReveivedDatafromParser

-(void) restaurantDidReceivedData
{
    
    //Json response is stored locally, so fetching it
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"];
    
    //Converting local data in bytes
    NSData *receivedData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    
    //Using NSJSONSerialization class for converting JSON to Foundation objects
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error: &error];
    
    // Array initilazation were copies of model class will be stored
    _arrayOfReceivedData = [NSMutableArray new];
    
    //storing all data in dictionary
    NSDictionary *dicData = [json objectForKey:@"data"];
    
    
    for (NSString *key in dicData) {
        
        //Fetcing dictinary and getting model ready
        
        if ([[dicData objectForKey:key] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = [dicData objectForKey:key];
            
            //Main Model
            RestaurantModel *restaurantModel = [RestaurantModel new];
            
            restaurantModel.SubFranchiseID =[[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"SubFranchiseID"]]intValue];
            
            restaurantModel.OutletID   =      [[NSString stringWithFormat:@"%@",
                                                [dictionary objectForKey:@"OutletID"]]intValue];
            
            restaurantModel.OutletName =    [NSString stringWithFormat:@"%@",
                                             [dictionary objectForKey:@"OutletName"]];
            
            restaurantModel.BrandID    =       [[NSString stringWithFormat:@"%@",
                                                 [dictionary objectForKey:@"BrandID"]]intValue];
            
            restaurantModel.Address    =[NSString stringWithFormat:@"%@",
                                         [dictionary objectForKey:@"Address"]];
            
            restaurantModel.NeighbourhoodID =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"NeighbourhoodID"]]intValue];
            
            restaurantModel.CityID          =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"CityID"]]intValue];
            
            restaurantModel.Email           =[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"Email"]];
            
            restaurantModel.Timings         =[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"Timings"]];
            
            restaurantModel.CityRank        =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"CityRank"]]intValue];
            
            restaurantModel.Latitude        =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"Latitude"]]floatValue];
            
            restaurantModel.Longitude       =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"Longitude"]]floatValue];
            
            restaurantModel.Pincode         =[[NSString stringWithFormat:@"%@",
                                               [dictionary objectForKey:@"Pincode"]]intValue];
            
            restaurantModel.Landmark        =[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"Landmark"]];
            
            restaurantModel.Streetname      =[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"Streetname"]];
            
            restaurantModel.BrandName       =[NSString stringWithFormat:@"%@",
                                              [dictionary objectForKey:@"BrandName"]];
            
            restaurantModel.OutletURL      =[NSString stringWithFormat:@"%@",
                                             [dictionary objectForKey:@"OutletURL"]];
            
            restaurantModel.NumCoupons     =[NSString stringWithFormat:@"%@",
                                             [dictionary objectForKey:@"NumCoupons"]];
            
            restaurantModel.NeighbourhoodName =[NSString stringWithFormat:@"%@",
                                                [dictionary objectForKey:@"NeighbourhoodName"]];
            
            restaurantModel.PhoneNumber       =[[NSString stringWithFormat:@"%@",
                                                 [dictionary objectForKey:@"PhoneNumber"]]intValue];
            
            restaurantModel.CityName          =[NSString stringWithFormat:@"%@",
                                                [dictionary objectForKey:@"CityName"]];
            
            restaurantModel.Distance          =[[NSString stringWithFormat:@"%@",
                                                 [dictionary objectForKey:@"Distance"]]intValue];
            
            restaurantModel.LogoURL           =[NSString stringWithFormat:@"%@",
                                                [dictionary objectForKey:@"LogoURL"]];
            
            restaurantModel.CoverURL          =[NSString stringWithFormat:@"%@",
                                                [dictionary objectForKey:@"CoverURL"]];
            
            
            /*Categories key in our Json is array of dictinary, we create other model for this array objects and refrence it in main model*/
            
            NSArray *categoryData             = [dictionary objectForKey:@"Categories"];
            
            restaurantModel.categories        = [NSMutableArray new];
            
            for (NSDictionary *categoryDictonary in categoryData)
            {
                // this if - else , appends categoryType of restaurant is our Main model so the work in cellForRow gets down and increase the effiency, these also helps in working less on frames for different category type
                if (restaurantModel.categoryTypeToShow == nil || [restaurantModel.categoryTypeToShow isEqualToString:@""])
                {
                    if (![[categoryDictonary objectForKey:@"CategoryType"] isEqualToString:@""])
                    {
                        
                        restaurantModel.categoryTypeToShow = [categoryDictonary objectForKey:@"CategoryType"];
                        
                    }
                }
                else{
                    if (![[categoryDictonary objectForKey:@"CategoryType"] isEqualToString:@""]) {
                        
                        restaurantModel.categoryTypeToShow = [NSString stringWithFormat:@"%@ • %@",restaurantModel.categoryTypeToShow,[categoryDictonary objectForKey:@"CategoryType"]];
                    }
                }
                
                //sub model of our Main model array categories
                RestaurantCategoryModel *categoryModel = [RestaurantCategoryModel new];
                
                categoryModel.OfflineCategoryID         = [[NSString stringWithFormat:@"%@",
                                                            [categoryDictonary objectForKey:@"OfflineCategoryID"]]intValue];
                
                categoryModel.Name                      = [NSString stringWithFormat:@"%@",
                                                           [categoryDictonary objectForKey:@"Name"]];
                categoryModel.ParentCategoryID          = [[NSString stringWithFormat:@"%@",
                                                            [categoryDictonary objectForKey:@"ParentCategoryID"]]intValue];
                categoryModel.CategoryType              = [NSString stringWithFormat:@"%@",
                                                           [categoryDictonary objectForKey:@"CategoryType"]];
                
                [restaurantModel.categories addObject:categoryModel];
                categoryModel = nil;
                
                
            }
            
            //adding each model in array
            
            [_arrayOfReceivedData addObject:restaurantModel];
            restaurantModel = nil;
            
        }
        
        
    }
    
    //sending data to the class who implemented delegate
    if (self.delegate != nil) {
        
        [self.delegate restaurantDidReceivedData:_arrayOfReceivedData];
    }

}

@end
