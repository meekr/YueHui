//
//  MainViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "YHTabBarController.h"

@interface MainViewController : UIViewController <YHTabBarControllerDelegate>

@property (nonatomic, strong) YHTabBarController *tabBarController;

@end