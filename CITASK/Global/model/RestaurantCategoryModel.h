//
//  RestaurantCategoryModel.h
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantCategoryModel : NSObject

@property(nonatomic)int OfflineCategoryID;
@property(copy, nonatomic) NSString *Name;
@property(nonatomic)int ParentCategoryID;
@property(copy, nonatomic) NSString *CategoryType;


@end
