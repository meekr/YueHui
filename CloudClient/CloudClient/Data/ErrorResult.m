//
//  ErrorResult.m
//  FlipInkCloudClient
//
//  Created by Ji Jim on 4/21/13.
//  Copyright (c) 2013 FlipInk. All rights reserved.
//

#import "ErrorResult.h"

@implementation ErrorResult
@synthesize code;
@synthesize message;


- (NSString *)description {
    return [NSString stringWithFormat: @"code=%@, message=%@", self.code, self.message];
}

@end
