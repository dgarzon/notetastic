#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Expanded)

#pragma mark - Strings

+ (UIColor *) colorWithHexString: (NSString *)stringToConvert;
+ (UIColor *) colorWithRGBHex: (uint32_t)hex;

@end
