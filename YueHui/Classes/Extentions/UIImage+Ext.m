//
//  UIImageExtention.m
//  FlipBook3D
//
//  Created by Lei Perry on 9/27/12.
//
//

#import "UIImage+Ext.h"

#define COLOR_PART_RED(color)    (((color) >> 16) & 0xff)
#define COLOR_PART_GREEN(color)  (((color) >>  8) & 0xff)
#define COLOR_PART_BLUE(color)   ( (color)        & 0xff)


@implementation UIImage (Ext)

- (UIImage *)imageByRemovingColor:(uint)color {
    return [self imageByRemovingColorsWithMinColor:color maxColor:color];
}

- (UIImage *)imageByRemovingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor {
    return [self imageByReplacingColorsWithMinColor:minColor maxColor:maxColor withColor:0 andAlpha:0];
}

- (UIImage *)imageByReplacingColor:(uint)color withColor:(uint)newColor {
    return [self imageByReplacingColorsWithMinColor:color maxColor:color withColor:newColor];
}

- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor {
    return [self imageByReplacingColorsWithMinColor:minColor maxColor:maxColor withColor:newColor andAlpha:1.0f];
}

- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor andAlpha:(float)alpha {
    CGImageRef imageRef = self.CGImage;
    float width = CGImageGetWidth(imageRef);
    float height = CGImageGetHeight(imageRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    uint minRed = COLOR_PART_RED(minColor);
    uint minGreen = COLOR_PART_GREEN(minColor);
    uint minBlue = COLOR_PART_BLUE(minColor);
    uint maxRed = COLOR_PART_RED(maxColor);
    uint maxGreen = COLOR_PART_GREEN(maxColor);
    uint maxBlue = COLOR_PART_BLUE(maxColor);
    float newRed = COLOR_PART_RED(newColor)/255.0f;
    float newGreen = COLOR_PART_GREEN(newColor)/255.0f;
    float newBlue = COLOR_PART_BLUE(newColor)/255.0f;
    
    CGContextRef context = nil;
    
    if (alpha) {
        context = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), CGImageGetBitmapInfo(imageRef));
        CGContextSetRGBFillColor(context, newRed, newGreen, newBlue, alpha);
        CGContextFillRect(context, bounds);
    }
    float maskingColors[6] = {minRed, maxRed, minGreen, maxGreen, minBlue, maxBlue};
    CGImageRef maskedImageRef = CGImageCreateWithMaskingColors(imageRef, maskingColors);
    if (!maskedImageRef) {
        CGContextRelease(context);
        return nil;
    }
    
    UIImage *newImage;
    if (alpha) {
        CGContextDrawImage(context, bounds, maskedImageRef);
        CGImageRef newImageRef = CGBitmapContextCreateImage(context);
        newImage = [UIImage imageWithCGImage:newImageRef];
        CGImageRelease(newImageRef);
    }
    else {
        newImage = [UIImage imageWithCGImage:maskedImageRef];
    }
    CGContextRelease(context);
    CGImageRelease(maskedImageRef);
    return newImage;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		}
#else
		if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0) {
			UIGraphicsBeginImageContext([self size]);
		}
#endif
		CGRect rect = CGRectZero;
		rect.size = [self size];
        
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
        
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
        
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
        
		return image;
	}
    
	return self;
}

-(UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage *)scaleProportionalToSize:(CGSize)size1
{
    float scaleVal = 1.0f;
    if (self.size.width > size1.width) {
        scaleVal = size1.width / self.size.width;
    }
    if (self.size.height > size1.height) {
        float scaleVal2 = size1.height / self.size.height;
        if (scaleVal2 < scaleVal) {
            scaleVal = scaleVal2;
        }
    }
    size1 = CGSizeMake(self.size.width * scaleVal, self.size.height * scaleVal);
    return [self scaleToSize:size1];
}

@end
