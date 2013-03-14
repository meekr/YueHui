//
//  UIColorExtention.h
//  FlipBook3D
//
//  Created by Lei Perry on 9/25/12.
//
//

@interface UIColor (Ext)

+ (UIColor *)colorWithHex:(int)hex;
+ (UIColor *)colorFromCode:(int)hexCode inAlpha:(float)alpha;

- (NSUInteger)colorCode;

/**
 * Fades between firstColor and secondColor at the specified ratio:
 *
 *    @ ratio 0.0 - fully firstColor
 *    @ ratio 0.5 - halfway between firstColor and secondColor
 *    @ ratio 1.0 - fully secondColor
 *
 */

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor
                               secondColor:(UIColor *)secondColor
                                   atRatio:(CGFloat)ratio;

/**
 * Same as above, but allows turning off the color space comparison
 * for a performance boost.
 */

+ (UIColor *)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio compareColorSpaces:(BOOL)compare;

/**
 * An array of [steps] colors starting with firstColor, continuing with linear interpolations
 * between firstColor and lastColor and ending with lastColor.
 */
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                                    inSteps:(NSUInteger)steps;

/**
 * An array of [steps] colors starting with firstColor, continuing with interpolations, as specified
 * by the equation block, between firstColor and lastColor and ending with lastColor. The equation block
 * must take a float as an input, and return a float as an output. Output will be santizied to be between
 * a ratio of 0.0 and 1.0. Passing nil for the equation results in a linear relationship.
 */
+ (NSArray *)colorsForFadeBetweenFirstColor:(UIColor *)firstColor
                                  lastColor:(UIColor *)lastColor
                          withRatioEquation:(float (^)(float))equation
                                    inSteps:(NSUInteger)steps;


/**
 * Convert UIColor to RGBA colorspace. Used for cross-colorspace interpolation.
 */
+ (UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert;

- (CGFloat)r;
- (CGFloat)g;
- (CGFloat)b;
- (CGFloat)a;

@end