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
    return [UIColor colorWithRed:(arc4random() % 255/255.0f)
                           green:(arc4random() % 255/255.0f)
                            blue:(arc4random() % 255/255.0f)
                           alpha:1.0];
}

- (NSString *)displayString
{
    CGFloat red, green, blue;
    [self getRed:&red green:&green blue:&blue alpha:NULL];
    
    return [NSString stringWithFormat:@"R:%d G:%d B:%d",
            (UInt8)(red * 255),
            (UInt8)(green * 255),
            (UInt8)(blue * 255)];
}

@end
