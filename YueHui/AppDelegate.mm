//
//  AppDelegate.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "YHTabBarController.h"
#import "UINavigationBar+Ext.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    HomeViewController *vc = [[HomeViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    UIImage *bg = [[UIImage imageNamed:@"top-bar-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:2];
    [self.navigationController.navigationBar setBackgroundImage:bg];
    self.window.rootViewController = self.navigationController;
    
    CGRect r = self.window.bounds;
    self.tabBarController = [[YHTabBarController alloc] init];
    self.tabBarController.delegate = self;
    UIView *tabView = self.tabBarController.view;
    tabView.frame = CGRectMake(0, CGRectGetHeight(r) - CGRectGetHeight(tabView.bounds), CGRectGetWidth(tabView.bounds), CGRectGetHeight(tabView.bounds));
    tabView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.window addSubview:tabView];

    
    return YES;
}

#pragma mark - YHTabBarControllerDelegate
- (void)gotoCouponPage {
    if (![self.navigationController.topViewController isKindOfClass:[CouponCollectionViewController class]]) {
        CouponCollectionViewController *controller = [[CouponCollectionViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)gotoHomePage {
    if (![self.navigationController.topViewController isKindOfClass:[HomeViewController class]]) {
        HomeViewController *controller = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)gotoShopPage {
    if (![self.navigationController.topViewController isKindOfClass:[StoreCollectionViewController class]]) {
        StoreCollectionViewController *controller = [[StoreCollectionViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    }
}


@end