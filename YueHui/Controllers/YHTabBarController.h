//
//  YHTabBarController.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

@protocol YHTabBarControllerDelegate <NSObject>

- (void)gotoCouponPage;
- (void)gotoHomePage;
- (void)gotoShopPage;

@end

@interface YHTabBarController : UIViewController

@property (nonatomic, assign) id<YHTabBarControllerDelegate> delegate;

@end