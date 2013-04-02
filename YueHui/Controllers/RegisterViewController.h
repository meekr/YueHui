//
//  MainViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

//#import "NetWorkReachability.h"
//#import "Receiver.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>{
    
    UITextField* passwordInput;
    UIImageView* tickBoxImageView;
    UIImageView* tickImageView;
    UIImage* tickImage;
    BOOL tickChecked;
    UIScrollView* scrollView;
}
//
//@property (nonatomic, strong) NSString *uuid;
//@property (nonatomic, strong) NSString *token;

@end