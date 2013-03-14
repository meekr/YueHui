//
//  UIImageExtention.h
//  FlipBook3D
//
//  Created by Lei Perry on 9/27/12.
//
//

@interface UIImage (Ext)

- (UIImage *)imageByRemovingColor:(uint)color;
- (UIImage *)imageByRemovingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor;
- (UIImage *)imageByReplacingColor:(uint)color withColor:(uint)newColor;
- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor;
- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor andAlpha:(float)alpha;

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage *)scaleProportionalToSize:(CGSize)size;

@end