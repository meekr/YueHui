//
//  UIColorExtention.m
//  FlipBook3D
//
//  Created by Lei Perry on 9/25/12.
//
//

#import "UIColor+Ext.h"

@implementation UIColor (Ext)

+ (UIColor *)colorWithHex:(int)hex
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)colorFromCode:(int)hexCode inAlpha:(float)alpha {
    float red   = ((hexCode >> 16) & 0x000000FF)/255.0f;
    float green = ((hexCode >> 8) & 0x000000FF)/255.0f;
    float blue  = ((hexCode) & 0x000000FF)/255.0f;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}

- (NSUInteger)colorCode
{
    float red, green, blue;
    if ([self getRed:&red green:&green blue:&blue alpha:NULL])
    {
        NSUInteger redInt = (NSUInteger)(red * 255 + 0.5);
        NSUInteger greenInt = (NSUInteger)(green * 255 + 0.5);
        NSUInteger blueInt = (NSUInteger)(blue * 255 + 0.5);
        
        return (redInt << 16) | (greenInt << 8) | blueInt;
    }
    
    return 0;
}

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor
                               secondColor:(UIColor *)secondColor
                                   atRatio:(CGFloat)ratio {
    return [self colorForFadeBetweenFirstColor:firstColor secondColor:secondColor atRatio:ratio compareColorSpaces:YES];
    
}

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio compareColorSpaces:(BOOL)compare {
    // Eliminate values outside of 0 <--> 1
    ratio = MIN(MAX(0, ratio), 1);
    
    // Convert to common RGBA colorspace if needed
    if (compare) {
        if (CGColorGetColorSpace(firstColor.CGColor) != CGColorGetColorSpace(secondColor.CGColor))
        {
            firstColor = [UIColor colorConvertedToRGBA:firstColor];
            secondColor = [UIColor colorConvertedToRGBA:secondColor];
        }
    }
    
    // Grab color components
    const CGFloat *firstColorComponents = CGColorGetComponents(firstColor.CGColor);
    const CGFloat *secondColorComponents = CGColorGetComponents(secondColor.CGColor);
    
    // Interpolate between colors
    CGFloat interpolatedComponents[CGColorGetNumberOfComponents(firstColor.CGColor)] ;
    for (NSUInteger i = 0; i < CGColorGetNumberOfComponents(firstColor.CGColor); i++)
    {
        interpolatedComponents[i] = firstColorComponents[i] * (1 - ratio) + secondColorComponents[i] * ratio;
    }
    
    // Create interpolated color
    CGColorRef interpolatedCGColor = CGColorCreate(CGColorGetColorSpace(firstColor.CGColor), interpolatedComponents);
    UIColor *interpolatedColor = [UIColor colorWithCGColor:interpolatedCGColor];
    CGColorRelease(interpolatedCGColor);
    
    return interpolatedColor;
}

+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                                    inSteps:(NSUInteger)steps {
    
    return [self colorsForFadeBetweenFirstColor:firstColor lastColor:lastColor withRatioEquation:nil inSteps:steps];
}

+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor lastColor:(UIColor *)lastColor withRatioEquation:(float (^)(float))equation inSteps:(NSUInteger)steps {
    // Handle degenerate cases
    if (steps == 0)
        return nil;
    if (steps == 1)
        return [NSArray arrayWithObject:firstColor];
    if (steps == 2)
        return [NSArray arrayWithObjects:firstColor, lastColor, nil];
    
    // Assume linear if no equation is passed
    if (equation == nil) {
    	equation = ^(float input) {
    	    return input;
    	};
    }
    
    // Calculate step size
    CGFloat stepSize = 1.0f / (steps - 1);
    
    // Array to store colors in steps
    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:steps];
    [colors addObject:firstColor];
    
    // Compute intermediate colors
    CGFloat ratio = stepSize;
    for (int i = 2; i < steps; i++)
    {
        [colors addObject:[self colorForFadeBetweenFirstColor:firstColor secondColor:lastColor atRatio:equation(ratio)]];
        ratio += stepSize;
    }
    
    [colors addObject:lastColor];
    return colors;
}

+ (UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert;
{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    // Convert color to RGBA with a CGContext. UIColor's getRed:green:blue:alpha: doesn't work across color spaces. Adapted from http://stackoverflow.com/a/4700259
    
    alpha = CGColorGetAlpha(colorToConvert.CGColor);
    
    CGColorRef opaqueColor = CGColorCreateCopyWithAlpha(colorToConvert.CGColor, 1.0f);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[CGColorSpaceGetNumberOfComponents(rgbColorSpace)];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, opaqueColor);
    CGColorRelease(opaqueColor);
    CGContextFillRect(context, CGRectMake(0.f, 0.f, 1.f, 1.f));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    red = resultingPixel[0] / 255.0f;
    green = resultingPixel[1] / 255.0f;
    blue = resultingPixel[2] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (CGFloat) r
{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat) g
{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat) b
{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat) a
{
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) == kCGColorSpaceModelMonochrome) return c[0];
    return c[3];
}

@end