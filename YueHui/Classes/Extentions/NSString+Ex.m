//
//  NSString+Extra.m
//  FlipBook3D
//
//  Created by Lei Perry on 1/16/13.
//
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

- (int)indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}

@end