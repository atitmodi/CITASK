//
//  RestaurantModel.h
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantModel : NSObject

@property(nonatomic)int SubFranchiseID;
@property(nonatomic)int OutletID;
@property(copy, nonatomic)NSString *OutletName;
@property(nonatomic)int BrandID;
@property(copy, nonatomic) NSString *Address;
@property(nonatomic) int NeighbourhoodID;
@property(nonatomic) int CityID;
@property(copy, nonatomic) NSString *Email;
@property(nonatomic)int CityRank;
@property(copy, nonatomic) NSString *Timings;
@property(nonatomic)float Latitude;
@property(nonatomic)float Longitude;
@property(nonatomic)int Pincode;
@property(copy, nonatomic) NSString *Landmark;
@property(copy, nonatomic) NSString *Streetname;
@property(copy, nonatomic) NSString *BrandName;
@property(copy, nonatomic) NSString *OutletURL;
@property(copy, nonatomic) NSString *NumCoupons;
@property(copy, nonatomic) NSString *NeighbourhoodName;
@property( nonatomic) NSMutableArray *categories;
@property(nonatomic)int PhoneNumber;
@property(copy, nonatomic) NSString *CityName;
@property(nonatomic)float Distance;
@property(copy, nonatomic) NSString *LogoURL;
@property(copy, nonatomic) NSString *CoverURL;
@property(copy, nonatomic) NSString *categoryTypeToShow;
@property(nonatomic) double modelDistace;

@end
