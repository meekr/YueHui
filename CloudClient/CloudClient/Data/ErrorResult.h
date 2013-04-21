//
//  ErrorResult.h
//  FlipInkCloudClient
//
//  Created by Ji Jim on 4/21/13.
//  Copyright (c) 2013 FlipInk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorResult: NSObject
@property (nonatomic, retain) NSString* code;
@property (nonatomic, retain) NSString* message;
@end
