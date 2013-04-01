//
//  MainViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "NetWorkReachability.h"
#import "Receiver.h"
#import "LoginViewController.h"

@interface HomeViewController : UIViewController <NetworkReachabilityDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *token;

@end