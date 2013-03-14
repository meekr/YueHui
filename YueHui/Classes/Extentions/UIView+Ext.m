//
//  UIViewExtention.m
//  FlipBook3D
//
//  Created by Lei Perry on 9/24/12.
//
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
