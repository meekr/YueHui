//
//  AppDelegate.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//
#import "YHTabBarController.h"
#import "CouponCollectionViewController.h"
#import "StoreCollectionViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, YHTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) YHTabBarController *tabBarController;

@end