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
#define kRadarScanTag 2
#define kRadarScanAnimation @"rotationAnimation"
#define degreesToRadians(x) (M_PI * x / 180.0)

@interface MainViewController ()
{
    Receiver* receiver;
    BOOL searching;
}

@property (nonatomic, strong) NetworkReachability *netReacher;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MainViewController

- (id)init {
    if (self = [super init]) {
        self.netReacher = [[NetworkReachability alloc] init];
        self.netReacher.delegate = self;
    }
    return self;
}

#pragma mark - view lifecycle

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
    
    radarBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-scan"]];
    radarBg.tag = kRadarScanTag;
    radarBg.center = CGPointMake(160, 136);
    radarBg.layer.anchorPoint = CGPointMake(.5, .5);
//    radarBg.transform = CGAffineTransformMakeRotation(degreesToRadians(240));
    [self.view addSubview:radarBg];
    
    radarBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-point"]];
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
    
    UIImage *shareImage = [UIImage imageNamed:@"icon-share"];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, shareImage.size.width, shareImage.size.height);
    [shareBtn setImage:shareImage forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon-share-selected"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.tabBarController = [[YHTabBarController alloc] init];
    self.tabBarController.delegate = self;
    UIView *tabView = self.tabBarController.view;
    tabView.frame = CGRectMake(0, CGRectGetHeight(r) - CGRectGetHeight(tabView.bounds) - 44, CGRectGetWidth(tabView.bounds), CGRectGetHeight(tabView.bounds));
    tabView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tabView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [self startSearching];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion) {
        NSLog(@"shake detected");
        if (!searching) {
            
            [self startWiggling];
            [self performSelector:@selector(stopWiggling) withObject:nil afterDelay:2];
            
            [self startSearching];
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - actions & handlers

- (void)startSearching {
    [self stopSearching];
    searching = YES;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    UIView *view = [self.view viewWithTag:kRadarScanTag];
    [view.layer addAnimation:rotationAnimation forKey:kRadarScanAnimation];
    
#if TARGET_IPHONE_SIMULATOR
#else
    receiver = new Receiver();
    receiver->start();
#endif
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    [self performSelector:@selector(searchTimeout:) withObject:nil afterDelay:30.0];
}

- (void)stopSearching {
    searching = NO;
    UIView *view = [self.view viewWithTag:kRadarScanTag];
    [view.layer removeAnimationForKey:kRadarScanAnimation];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchTimeout:) object:nil];
    [self.timer invalidate];
    self.timer = nil;
    
#if TARGET_IPHONE_SIMULATOR
#else
    if (receiver != NULL) {
        receiver->stop();
        delete receiver;
        receiver = NULL;
    }
#endif
}

- (void)shareAction {
}

- (void)timerHandler:(NSTimer *)timer
{
#if TARGET_IPHONE_SIMULATOR
#else
    if (receiver->isRunning())
    {
        string str = receiver->getData();
        self.token = [NSString stringWithUTF8String:str.c_str()];
        
        if (self.token.length > 0)
        {
            NSLog(@"token:%@", self.token);
            [self stopSearching];
            if ([self.token isEqualToString:@"-1"]) {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"搜索约惠信号失败！"
                                                                message:@"重新搜索约惠信号?"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
                alert.tag = 0;
                [alert show];
            }
            else
            {
                if (self.netReacher.reachable == NO) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络不可用!"
                                                                     message:@"请检查网络"
                                                                    delegate:self
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                    alert.tag = 3;
                    [alert show];
                }
                else
                {
                    // TODO: open shop view
                    NSLog(@"open shop view");
                }
            }
        }
    }
    else
    {
        receiver->start();
    }
#endif
}

-(void)searchTimeout:(id)obj
{
    [self stopSearching];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"搜索约惠信号超时！"
                                                    message:@"继续搜索约惠信号?"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)startWiggling
{
    UIView *control = [self.view viewWithTag:kShakePhoneTag];
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


- (void)stopWiggling
{
    UIView *control = [self.view viewWithTag:kShakePhoneTag];
    [control.layer removeAnimationForKey:@"wiggleRotation"];
    [control.layer removeAnimationForKey:@"wiggleTranslationY"];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3) {
        if (self.netReacher.reachable == NO) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络不可用!" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
        }
        else if (self.token.length > 0)
        {
            // TODO: open shop view
            NSLog(@"open shop view");
        }
        else {
            [self startSearching];
        }
    }
    else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchTimeout:) object:nil];
        if (buttonIndex == 1)
        {
            [self startSearching];
        }
        else if (buttonIndex == 0)
        {
            NSLog(@"cancel clicked");
        }
    }
}

#pragma mark - NetworkReachabilityDelegate
- (void)networkReachabilityDidUpdate:(NetworkReachability *)reachability {
    NSLog(@"net reachable: %d", self.netReacher.reachable);
}

#pragma mark - YHTabBarControllerDelegate
- (void)gotoCouponPage {
    NSLog(@"goto coupon");
}

- (void)gotoHomePage {
    NSLog(@"goto homepage");
}

- (void)gotoShopPage {
    NSLog(@"goto shop");
}

@end