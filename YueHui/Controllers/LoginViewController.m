//
//  MainViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Ext.h"
#import "UINavigationBar+Ext.h"
#import <math.h>
#import "RegisterViewController.h"

#define kShakePhoneTag 1
#define kRadarScanTag 2
#define kRadarScanAnimation @"rotationAnimation"
#define degreesToRadians(x) (M_PI * x / 180.0)

@interface LoginViewController ()
{
    //    BOOL searching;
}

//@property (nonatomic, strong) NetworkReachability *netReacher;
//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LoginViewController

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
    
    
    //
    float formX=160;
    float formY=50;
    //
    UIImage *inputImage = [UIImage imageNamed:@"msg-user"];
    UIImageView* view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX-70,formY);
    [self.view addSubview:view];
    
    //
    inputImage = [UIImage imageNamed:@"input-content"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX,formY+30);
    [self.view addSubview:view];
    NSLog(@"%f",view.frame.size.height);
    
    UITextField* field = [[UITextField alloc]
                          initWithFrame:CGRectMake(view.frame.origin.x+3,
                                                   view.frame.origin.y+6,
                                                   view.frame.size.width-6, view.frame.size.height-6)];
    field.autocorrectionType = UITextAutocorrectionTypeYes;
    field.placeholder = @"在此处填写用户名";
    field.returnKeyType = UIReturnKeyNext;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.delegate = self;
    [self.view addSubview:field];
    
    //
    inputImage = [UIImage imageNamed:@"msg-register"];
//    view=[[UIImageView alloc] initWithImage:inputImage ];
//    view.frame=CGRectMake(0, 0, inputImage.size.width,
//                          inputImage.size.height);
//    view.center=CGPointMake(formX+120,formY+30);
//    [self.view addSubview:view];
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height);
    registerBtn.center=CGPointMake(formX+120,formY+30);
    [registerBtn setImage:inputImage forState:UIControlStateNormal];
    [registerBtn setImage:[UIImage imageNamed:@"msg-register"]
                 forState:UIControlStateHighlighted];
    [registerBtn addTarget:self action:@selector(registerAction)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];

    
    //
    inputImage = [UIImage imageNamed:@"passwords"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX-70,formY+80);
    [self.view addSubview:view];
    
    //
    inputImage = [UIImage imageNamed:@"input-content"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX,formY+110);
    [self.view addSubview:view];
    
    field = [[UITextField alloc]
             initWithFrame:CGRectMake(view.frame.origin.x+3,
                                      view.frame.origin.y+6,
                                      view.frame.size.width-6, view.frame.size.height-6)];
    field.autocorrectionType = UITextAutocorrectionTypeYes;
    field.secureTextEntry = YES;
    field.placeholder = @"在此处填写密码";
    field.returnKeyType = UIReturnKeyDone;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.delegate = self;
    [self.view addSubview:field];
    passwordInput=field;
    
    
    //
    inputImage = [UIImage imageNamed:@"input-Tick"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX-80,formY+155);
    [self.view addSubview:view];
    tickBoxImageView=view;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleTapTickBox:)] ;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
    
    //
    inputImage = [UIImage imageNamed:@"Tick"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX-80,formY+155);
    [self.view addSubview:view];
    tickImageView=view;
    tickImage = inputImage;
    
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self action:@selector(handleTapTick:)] ;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
    
    //
    inputImage = [UIImage imageNamed:@"remember"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX-25,formY+155);
    [self.view addSubview:view];
    
    //
    //    //
    //    inputImage = [UIImage imageNamed:@"btn-register"];
    //    view=[[UIImageView alloc] initWithImage:inputImage ];
    //    view.frame=CGRectMake(0, 0, inputImage.size.width,
    //                          inputImage.size.height);
    //    view.center=CGPointMake(formX+50,formY+155);
    //    [self.view addSubview:view];
    //
    //
    inputImage = [UIImage imageNamed:@"btn-login"];
//    view=[[UIImageView alloc] initWithImage:inputImage ];
//    view.frame=CGRectMake(0, 0, inputImage.size.width,
//                          inputImage.size.height);
    //
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height);
    loginBtn.center=CGPointMake(formX,formY+220);
    [loginBtn setImage:inputImage forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"btn-login-selected"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"用户登录"];
    [self becomeFirstResponder];
    
    //
    UIImage *backImage = [UIImage imageNamed:@"tab-icon-back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    NSLog(@"back w %f",backBtn.frame.size.width);
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"tab-icon-back-selected"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma text field
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.secureTextEntry) {
        [textField resignFirstResponder];
    }
    else{
        [passwordInput becomeFirstResponder];
    }
    
    return YES;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - actions & handlers


- (void)handleTapTick:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"tap - start location: %f,%f", point.x, point.y);
    NSLog(@"tag: %d", recognizer.view.tag);
    tickChecked=NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         tickImageView.alpha=0;
                         tickImageView.frame=CGRectMake(tickBoxImageView.center.x,
                                                        tickBoxImageView.center.y, 0, 0);
                         tickImageView.center=CGPointMake(tickBoxImageView.center.x,
                                                          tickBoxImageView.center.y);
                     }];
}



- (void)handleTapTickBox:(UITapGestureRecognizer *)recognizer
{

    [UIView animateWithDuration:0.2
                     animations:^{
                         tickImageView.alpha=1;
                         tickImageView.frame=CGRectMake(tickBoxImageView.center.x,
                                                        tickBoxImageView.center.y,
                                                        tickImage.size.width,
                                                        tickImage.size.height);
                         tickImageView.center=CGPointMake(tickBoxImageView.center.x,
                                                          tickBoxImageView.center.y);
                     }];
}


-(void)backAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)loginAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];

    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)registerAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];
//    [self.navigationController popViewControllerAnimated:NO];
//    [self.navigationController removeFromParentViewController];
//    
//    [UIView animateWithDuration:0.3
//                          delay:0 animations:^{
//        self.view.transform = CATransform3DMakeRotation(M_PI,1.0,0.0,0.0);
//    } completion:^{
//        // code to be executed when flip is completed
//    }];

    RegisterViewController *controller = [[RegisterViewController alloc] init];
//    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentModalViewController:controller animated:YES];
//    controller.
    [self.navigationController pushViewController:controller animated:YES];
}

@end