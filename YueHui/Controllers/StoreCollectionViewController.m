//
//  StoreCollectionViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/16/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "StoreCollectionViewController.h"
#import "UINavigationBar+Ext.h"

@interface StoreCollectionViewController ()

@end

@implementation StoreCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"到访过的商店"];
    self.view.backgroundColor = [UIColor redColor];
}

@end