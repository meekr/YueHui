//
//  MainViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "MainViewController.h"
#import "UIColor+Ext.h"
#import "UINavigationBar+Ext.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect r = self.view.bounds;

    self.view.backgroundColor = [UIColor colorWithHex:0xedeae1];
    UIImage *appBg = [[UIImage imageNamed:@"app-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *appBgView = [[UIImageView alloc] initWithImage:appBg];
    appBgView.frame = CGRectMake(0, 0, CGRectGetWidth(r), appBg.size.height);
    [self.view addSubview:appBgView];
    
    
    UIImage *bg = [[UIImage imageNamed:@"top-bar-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:2];
    [self.navigationController.navigationBar setBackgroundImage:bg];
    [self.navigationController.navigationBar setNeedsDisplay];
    self.title = @"约惠商户";
    
    UIImageView *shareImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-share"]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction)];
    [shareImageView addGestureRecognizer:tapGesture];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareImageView];
    
    self.tabBarController = [[YHTabBarController alloc] init];
    UIView *tabView = self.tabBarController.view;
    tabView.frame = CGRectMake(0, CGRectGetHeight(r) - CGRectGetHeight(tabView.bounds) - 44, CGRectGetWidth(tabView.bounds), CGRectGetHeight(tabView.bounds));
    tabView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tabView];
}

- (void)shareAction {
    NSLog(@"share");
}

@end