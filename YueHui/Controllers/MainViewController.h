//
//  MainViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "YHTabBarController.h"
#import "NetWorkReachability.h"
#import "Receiver.h"

@interface MainViewController : UIViewController <NetworkReachabilityDelegate, YHTabBarControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) YHTabBarController *tabBarController;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *token;

@end