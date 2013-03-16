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
    bg.userInteractionEnabled = YES;
    self.view = bg;
    
    UIImage *btnImage = [UIImage imageNamed:@"tab-icon-coupon"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 1;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tab-icon-coupon-selected"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"tab-icon-coupon-selected"] forState:UIControlStateSelected];
    btn.center = CGPointMake(50, 45);
    [btn addTarget:self action:@selector(handleCouponClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btnImage = [UIImage imageNamed:@"tab-icon-shop"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 2;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tab-icon-shop-selected"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"tab-icon-shop-selected"] forState:UIControlStateSelected];
    btn.center = CGPointMake(272, 46);
    [btn addTarget:self action:@selector(handleShopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btnImage = [UIImage imageNamed:@"tab-icon-home"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 3;
    btn.frame = CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tab-icon-home-selected"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"tab-icon-home-selected"] forState:UIControlStateSelected];
    btn.center = CGPointMake(160, 40);
    [btn addTarget:self action:@selector(handleHomeClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = YES;
    btn.userInteractionEnabled = NO;
    [self.view addSubview:btn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)deselectAllButtonsExcept:(UIButton *)button {
    if (button) {
        button.selected = YES;
        button.userInteractionEnabled = NO;
    }
    
    for (int i=1; i<=3; i++) {
        if (button && i == button.tag)
            continue;
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
    }
}

- (void)handleCouponClick:(UIButton *)button {
    [self deselectAllButtonsExcept:button];
    if ([self.delegate respondsToSelector:@selector(gotoCouponPage)])
    {
        [self.delegate gotoCouponPage];
    }
}

- (void)handleHomeClick:(UIButton *)button {
    [self deselectAllButtonsExcept:button];
    if ([self.delegate respondsToSelector:@selector(gotoHomePage)])
    {
        [self.delegate gotoHomePage];
    }
}

- (void)handleShopClick:(UIButton *)button {
    [self deselectAllButtonsExcept:button];
    if ([self.delegate respondsToSelector:@selector(gotoShopPage)])
    {
        [self.delegate gotoShopPage];
    }
}

@end