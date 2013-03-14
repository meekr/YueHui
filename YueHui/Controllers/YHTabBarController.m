//
//  YHTabBarController.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "YHTabBarController.h"

@interface YHTabBarController ()

@end

@implementation YHTabBarController

- (void)loadView {
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom-bar-bg"]];
    self.view = bg;
    
    UIImage *btnImage = [UIImage imageNamed:@"tab-icon-coupon"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.center = CGPointMake(50, 45);
    [btn addTarget:self action:@selector(handleCouponClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btnImage = [UIImage imageNamed:@"tab-icon-shop"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.center = CGPointMake(272, 46);
    [btn addTarget:self action:@selector(handleShopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btnImage = [UIImage imageNamed:@"tab-icon-home"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.center = CGPointMake(160, 40);
    [btn addTarget:self action:@selector(handleHomeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)handleCouponClick {
    if ([self.delegate respondsToSelector:@selector(gotoCouponPage)])
    {
        [self.delegate gotoCouponPage];
    }
}

- (void)handleHomeClick {
    if ([self.delegate respondsToSelector:@selector(gotoHomePage)])
    {
        [self.delegate gotoHomePage];
    }
}

- (void)handleShopClick {
    if ([self.delegate respondsToSelector:@selector(gotoShopPage)])
    {
        [self.delegate gotoShopPage];
    }
}

@end