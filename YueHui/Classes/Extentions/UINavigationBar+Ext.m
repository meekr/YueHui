//
//  UINavigationBar+Extra.m
//  YueHui
//
//  Created by Lei Perry on 3/14/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "UINavigationBar+Ext.h"

@implementation UINavigationBar (Ext)

- (void)setBackgroundImage:(UIImage*)image {
    if (image == NULL)
        return;
    
    UIImageView *aTabBarBackground = [[UIImageView alloc] initWithImage:image];
    aTabBarBackground.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:aTabBarBackground];
    [self sendSubviewToBack:aTabBarBackground];
}

@end