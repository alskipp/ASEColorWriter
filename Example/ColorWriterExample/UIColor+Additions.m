//
//  UIColor+Additions.m
//  ColorWriterExample
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)randomColor
{
    UIColor *col;
    if (arc4random_uniform(3) == 0) {
        col = [UIColor colorWithWhite:(arc4random() % 255/255.0f) alpha:1.0];
    } else {
        col = [UIColor colorWithRed:(arc4random() % 255/255.0f)
                              green:(arc4random() % 255/255.0f)
                               blue:(arc4random() % 255/255.0f)
                              alpha:1.0];
    }
    return col;
}

- (NSString *)displayString
{
    NSString *colorString;
    CGFloat c1, c2, c3;
    
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        [self getWhite:&c1 alpha:NULL];
        colorString = [NSString stringWithFormat:@"Black:%d", (UInt8)lroundf(100 - c1 * 100)];
    } else {
        [self getRed:&c1 green:&c2 blue:&c3 alpha:NULL];
        colorString = [NSString stringWithFormat:@"R:%d G:%d B:%d",
                       (UInt8)(c1 * 255),
                       (UInt8)(c2 * 255),
                       (UInt8)(c3 * 255)];
    }
    return colorString;
}

@end
