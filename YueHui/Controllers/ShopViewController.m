//
//  MainViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Ext.h"
#import "UINavigationBar+Ext.h"
#import "ShopViewController.h"

@interface ShopViewController ()
{
    //    BOOL searching;
}

//@property (nonatomic, strong) NetworkReachability *netReacher;
//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ShopViewController


- (id)init {
    if (self = [super init]) {
        //        self.netReacher = [[NetworkReachability alloc] init];
        //        self.netReacher.delegate = self;
    }
    
    passwordInput=nil;
    tickBoxImageView=nil;
    tickImageView=nil;
    tickImage=nil;
    tickChecked=NO;
    
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
    
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:appBgView.frame];
    [self.view addSubview: scrollView];
    
    //
    UIImage *image = [UIImage imageNamed:@"KFC_small"];
    UIImageView *imageView  = [[UIImageView alloc]initWithImage:image];
    imageView.center        =  CGPointMake(70,50);
    imageView.layer.masksToBounds       = NO;
    imageView.layer.shadowRadius        = 2.0;
    imageView.layer.shadowColor         = [UIColor blackColor].CGColor;
    imageView.layer.shadowOffset        = CGSizeMake(.5, .5);
    imageView.layer.shadowOpacity       = .7f;
    imageView.layer.borderWidth        = 5;
    imageView.layer.borderColor        = [[UIColor whiteColor] CGColor];
    imageView.layer.shouldRasterize     =YES;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageView.bounds];
    imageView.layer.shadowPath = path.CGPath;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //change width of frame
//    CGRect frame = imageView.frame;
//    frame.size.width = 100;
//    imageView.frame = frame;
//    imageView.layer.frame=frame;
    

    [scrollView addSubview:imageView];
    
    //
    
    UILabel* label = [[UILabel alloc]init];
    [self initLabel:label];
    label.text = @"及先生 签到成功";
    label.center = CGPointMake(180,30);
    [scrollView addSubview:label];
    
    label = [[UILabel alloc]init];
    [self initLabel:label];
    label.text = @"您现在的积分是：500";
    label.center = CGPointMake(196,50);
    [scrollView addSubview:label];
    
}
BOOL keyboardIsShown;


- (void)viewDidUnload {
    
}

- (void)dealloc {
    
}



//


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"西单肯德基"];
    [self becomeFirstResponder];
    
    //
    UIImage *backImage = [UIImage imageNamed:@"tab-icon-back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    NSLog(@"back w %fx ,%f",backBtn.frame.size.width,backBtn.frame.origin.x);
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"tab-icon-back-selected"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
}

-( void)initLabel:(UILabel*)label{
    label.frame=CGRectMake(0, 0, 200, 30);
    label.backgroundColor=UIColor.clearColor;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor colorWithHex:0x4282ae];
    label.textAlignment = UITextAlignmentCenter;
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
}

-( void)initCommetLabel:(UILabel*)label{
    label.frame=CGRectMake(0, 0, 50,10);
    label.backgroundColor=UIColor.clearColor;
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor grayColor];
    label.textAlignment = UITextAlignmentCenter;
    label.shadowColor = [UIColor whiteColor];
}
#pragma mark - actions & handlers

-(void)backAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerAction{
    [self.navigationController popViewControllerAnimated:NO];
}

@end