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
#import <QuartzCore/QuartzCore.h>

#define kShakePhoneTag 1

@interface MainViewController ()

@end

@implementation MainViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect r = self.view.bounds;

    // app background
    self.view.backgroundColor = [UIColor colorWithHex:0xedeae1];
    UIImage *appBg = [[UIImage imageNamed:@"app-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *appBgView = [[UIImageView alloc] initWithImage:appBg];
    appBgView.frame = CGRectMake(0, 0, CGRectGetWidth(r), appBg.size.height);
    [self.view addSubview:appBgView];
    
    // radar
    UIImageView *radarBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-bg"]];
    radarBg.center = CGPointMake(160, 150);
    [self.view addSubview:radarBg];
    
    // shake phone
    UIImageView *shakePhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake-phone"]];
    shakePhone.tag = kShakePhoneTag;
    shakePhone.center = CGPointMake(160, 300);
    [self.view addSubview:shakePhone];
    
    
    UIImage *bg = [[UIImage imageNamed:@"top-bar-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:2];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:0xedeae1]];
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
    UIView *shake = [self.view viewWithTag:kShakePhoneTag];
    if (shaking)
        [self stopWiggling:shake];
    else
        [self startWiggling:shake];
}

static BOOL shaking;

- (void)startWiggling:(UIView *)control
{
    shaking = YES;
    
    // rotation
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-0.05f],
                   [NSNumber numberWithFloat:0.05f],
                   nil];
    anim.duration = 0.15f;
    anim.autoreverses = YES;
    anim.repeatCount = HUGE_VALF;
    [control.layer addAnimation:anim forKey:@"wiggleRotation"];
    
    // translation
    anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    anim.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-.7f],
                   [NSNumber numberWithFloat:.7f],
                   nil];
    anim.duration = 0.09f;
    anim.autoreverses = YES;
    anim.repeatCount = HUGE_VALF;
    anim.additive = YES;
    [control.layer addAnimation:anim forKey:@"wiggleTranslationY"];
}


- (void)stopWiggling:(UIView *)control
{
    shaking = NO;
    [control.layer removeAnimationForKey:@"wiggleRotation"];
    [control.layer removeAnimationForKey:@"wiggleTranslationY"];
}

@end