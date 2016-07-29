//
//  RestaurantParser.h
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RestaurantParserDelegate <NSObject>

-(void) restaurantDidReceivedData:(NSArray *)receivedData;


@end

@interface RestaurantParser : NSObject

@property(weak,nonatomic)id<RestaurantParserDelegate> delegate;
-(void) restaurantDidReceivedData;


@end
