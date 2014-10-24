//
//  UIColor+BrandColors.m
//  Notetastic
//
//  Created by Daniel Garzon on 10/4/14.
//  Copyright (c) 2014 Daniel Garzon. All rights reserved.
//

#import "UIColor+BrandColors.h"
#import "UIColor+Expanded.h"

@implementation UIColor (BrandColors)

+ (UIColor *)emeraldColor {
    return [UIColor colorWithHexString:@"2ecc71"];
}

+ (UIColor *)nephritisColor {
  return [UIColor colorWithHexString:@"27ae60"];
}

+ (UIColor *)cloudsColor {
   return [UIColor colorWithHexString:@"ecf0f1"];
}

+ (UIColor *)silverColor {
   return [UIColor colorWithHexString:@"bdc3c7"];
}

+ (UIColor *)concreteColor {
   return [UIColor colorWithHexString:@"95a5a6"];
}

+ (UIColor *)asbestosColor {
   return [UIColor colorWithHexString:@"7f8c8d"];
}

+ (UIColor *)alizarinColor {
   return [UIColor colorWithHexString:@"e74c3c"];
}

+ (UIColor *)pomegranateColor {
    return [UIColor colorWithHexString:@"c0392b"];
}

+ (UIColor *)carrotColor {
    return [UIColor colorWithHexString:@"e67e22"];
}

+ (UIColor *)pumpkinColor {
    return [UIColor colorWithHexString:@"d35400"];
}

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

@end
