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

@interface RegisterViewController ()
{
    //    BOOL searching;
}

//@property (nonatomic, strong) NetworkReachability *netReacher;
//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterViewController


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
    UIImage *backImage = [UIImage imageNamed:@"tab-icon-back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    NSLog(@"back w %f",backBtn.frame.size.width);
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"tab-icon-back-selected"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:appBgView.frame];
    [self.view addSubview: scrollView];
    
    float formX=60;
    float formX2=formX+110;
    float formY=50;
    float diff=60;
    //
    UIImage *inputImage = [UIImage imageNamed:@"msg-user"];

    
    UILabel* label = [[UILabel alloc]init];
    [self initLabel:label];
    label.text = @"用户名";
    label.center = CGPointMake(formX+8,formY);
    [scrollView addSubview:label];
    
    //
    inputImage = [UIImage imageNamed:@"input-content-register-page"];
    UIImageView* view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX2,formY);
    [scrollView addSubview:view];
    NSLog(@"%f",view.frame.size.height);
    
    UITextField* userfield = [[UITextField alloc]
                          initWithFrame:CGRectMake(view.frame.origin.x+3,
                                                   view.frame.origin.y+6,
                                                   view.frame.size.width-6, view.frame.size.height-6)];
    userfield.autocorrectionType = UITextAutocorrectionTypeYes;
    userfield.placeholder = @"在此处填写用户名";
    userfield.returnKeyType = UIReturnKeyDone;
    userfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    userfield.delegate = self;
    [scrollView addSubview:userfield];
    
    
    label = [[UILabel alloc]init];
    [self initCommetLabel:label];
    label.frame=CGRectMake(0, 0, inputImage.size.width,10);
    label.text=@"不超过20个汉字或字母";
    label.center = CGPointMake(formX2-20,formY+25);
    [scrollView addSubview:label];

    //==========
    
    label = [[UILabel alloc]init];
    [self initLabel:label];
        label.text = @"设置密码";
    label.center = CGPointMake(formX,formY+diff);
    [scrollView addSubview:label];
    
    //
    inputImage = [UIImage imageNamed:@"input-content-register-page"];
     view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX2,formY+diff);
    [scrollView addSubview:view];
    NSLog(@"%f",view.frame.size.height);
    
    UITextField* passwordfield = [[UITextField alloc]
                          initWithFrame:CGRectMake(view.frame.origin.x+3,
                                                   view.frame.origin.y+6,
                                                   view.frame.size.width-6, view.frame.size.height-6)];
    passwordfield.autocorrectionType = UITextAutocorrectionTypeYes;
    passwordfield.placeholder = @"输入密码";
    passwordfield.returnKeyType = UIReturnKeyDone;
    passwordfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordfield.delegate = self;
    [scrollView addSubview:passwordfield];
    
    label = [[UILabel alloc]init];
    [self initCommetLabel:label];
    label.frame=CGRectMake(0, 0, inputImage.size.width,10);
    label.text=@"长度6到16位，区分大小写";
    label.center = CGPointMake(formX2-10,formY+diff+25);
    [scrollView addSubview:label];
    
    
    
    //==========
    
    label = [[UILabel alloc]init];
    [self initLabel:label];
    label.text = @"确认密码";
    label.center = CGPointMake(formX,formY+diff*2);
    [scrollView addSubview:label];
    
    //
    inputImage = [UIImage imageNamed:@"input-content-register-page"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX2,formY+diff*2);
    [scrollView addSubview:view];
    NSLog(@"%f",view.frame.size.height);
    
    UITextField* emialfield = [[UITextField alloc]
                                        initWithFrame:CGRectMake(view.frame.origin.x+3,
                                                                 view.frame.origin.y+6,
                                                                 view.frame.size.width-6, view.frame.size.height-6)];
    emialfield.autocorrectionType = UITextAutocorrectionTypeYes;
    emialfield.placeholder = @"重复输入密码";
    emialfield.returnKeyType = UIReturnKeyDone;
    emialfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    emialfield.delegate = self;
    [scrollView addSubview:emialfield];
    
    
    
    //==========
    
    label = [[UILabel alloc]init];
    [self initLabel:label];
    label.text = @"电子邮件";
    label.center = CGPointMake(formX,formY+diff*3);
    [scrollView addSubview:label];
    
    //
    inputImage = [UIImage imageNamed:@"input-content-register-page"];
    view=[[UIImageView alloc] initWithImage:inputImage ];
    view.frame=CGRectMake(0, 0, inputImage.size.width,
                          inputImage.size.height);
    view.center=CGPointMake(formX2,formY+diff*3);
    [scrollView addSubview:view];
    NSLog(@"%f",view.frame.size.height);
    
    UITextField* repeatPasswordfield = [[UITextField alloc]
                                        initWithFrame:CGRectMake(view.frame.origin.x+3,
                                                                 view.frame.origin.y+6,
                                                                 view.frame.size.width-6, view.frame.size.height-6)];
    repeatPasswordfield.autocorrectionType = UITextAutocorrectionTypeYes;
    repeatPasswordfield.placeholder = @"输入邮箱地址";
    repeatPasswordfield.returnKeyType = UIReturnKeyDone;
    repeatPasswordfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    repeatPasswordfield.delegate = self;
    [scrollView addSubview:repeatPasswordfield];
    
    
    label = [[UILabel alloc]init];
    [self initCommetLabel:label];
    label.frame=CGRectMake(0, 0, 260,10);
    label.text=@"密码遗忘时凭此邮件取回密码";
    label.center = CGPointMake(formX2,formY+diff*3+25);
    [scrollView addSubview:label];

    
    
    //
    inputImage = [UIImage imageNamed:@"btn-right-now"];

    UIButton *regiterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regiterBtn.frame = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height);
    regiterBtn.center=CGPointMake(formX+100,formY+diff*4);
    [regiterBtn setImage:inputImage forState:UIControlStateNormal];
    [regiterBtn setImage:[UIImage imageNamed:@"btn-right-now-selected"] forState:UIControlStateHighlighted];
    [regiterBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:regiterBtn];
    
    
    //
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    keyboardIsShown = NO;
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    CGSize scrollContentSize = CGSizeMake(320, 345);
    scrollView.contentSize = scrollContentSize;
}
BOOL keyboardIsShown;


- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)dealloc {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:0.2];
    [scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:.2];
    [scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    [scrollView scrollRectToVisible:editingField.frame animated:YES];
    
    keyboardIsShown = YES;
}



//


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"注册新用户"];
}

-( void)initLabel:(UILabel*)label{
    label.frame=CGRectMake(0, 0, 60,30);
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
    label.shadowOffset = CGSizeMake(0, 1);
}

#pragma text field
UITextField* editingField;
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //scrollView.frame=CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height/2);
    editingField=textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    if (textField.secureTextEntry) {
//        [textField resignFirstResponder];
//    }
//    else{
//        [passwordInput becomeFirstResponder];
//    }
    
    return YES;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - actions & handlers

-(void)backAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)registerAction{
    [self.navigationController popViewControllerAnimated:NO];
}

@end