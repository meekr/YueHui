//
//  MainViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Ext.h"
#import "UINavigationBar+Ext.h"
#import <QuartzCore/QuartzCore.h>
#import "ShopViewController.h"

#define kShakePhoneTag 1
#define kRadarScanTag 2
#define kRadarScanAnimation @"rotationAnimation"
#define degreesToRadians(x) (M_PI * x / 180.0)

@interface HomeViewController ()
{
    Receiver* receiver;
    BOOL searching;
}

@property (nonatomic, strong) NetworkReachability *netReacher;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HomeViewController
@synthesize token;
@synthesize uuid;

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
    self.navigationItem.hidesBackButton = YES;
    CGRect r = self.view.bounds;

    // app background
    self.view.backgroundColor = [UIColor colorWithHex:0xedeae1];
    UIImage *appBg = [[UIImage imageNamed:@"app-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *appBgView = [[UIImageView alloc] initWithImage:appBg];
    appBgView.frame = CGRectMake(0, 0, CGRectGetWidth(r), appBg.size.height);
    [self.view addSubview:appBgView];
    
    // radar
    UIImageView *radar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-bg"]];
    radar.center = CGPointMake(160, 150);
    [self.view addSubview:radar];
    
    radar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-scan"]];
    radar.tag = kRadarScanTag;
    radar.center = CGPointMake(160, 148);
    radar.layer.anchorPoint = CGPointMake(.5, .5);
    [self.view addSubview:radar];
    
    radar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar-point"]];
    radar.center = CGPointMake(160, 148);
    [self.view addSubview:radar];
    
    // shake phone
    UIImageView *shakePhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake-phone"]];
    shakePhone.tag = kShakePhoneTag;
    shakePhone.center = CGPointMake(160, 300);
    [self.view addSubview:shakePhone];
    
    UIImage *shareImage = [UIImage imageNamed:@"icon-share"];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, shareImage.size.width, shareImage.size.height);
    [shareBtn setImage:shareImage forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon-share-selected"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    
    UIImage *userImage = [UIImage imageNamed:@"tab-icon-person"];
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame = CGRectMake(0, 0, userImage.size.width, userImage.size.height);
    NSLog(@"user w %f",userBtn.frame.size.width);
    [userBtn setImage:userImage forState:UIControlStateNormal];
    [userBtn setImage:[UIImage imageNamed:@"tab-icon-person-selected"] forState:UIControlStateHighlighted];
    [userBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userBtn];
    
    receiver = NULL;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"约惠商户"];
    [self becomeFirstResponder];
    [self startSearching];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopSearching];
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(timerHandler:)
                                                userInfo:nil
                                                 repeats:YES];
    [self performSelector:@selector(searchTimeout:)
               withObject:nil
               afterDelay:30.0];
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

-(void)loginAction{
    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}


- (void)timerHandler:(NSTimer *)timer
{
#if TARGET_IPHONE_SIMULATOR
#else
    if (receiver->isRunning())
    {
        string str = receiver->getData();
        self.token = [NSString stringWithUTF8String:str.c_str()];
        NSLog(@"token:%s", str.c_str());
        
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
                    ShopViewController *controller = [[ShopViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
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
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络不可用!"
                                                             message:@"请检查网络"
                                                            delegate:self
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
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

@end