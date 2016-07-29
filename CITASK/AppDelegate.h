//
//  AppDelegate.h
//  CITASK
//
//  Created by Atit Modi on 17/11/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *baseController;
@property (strong, nonatomic) UINavigationController *baseNavigationController;

@end

