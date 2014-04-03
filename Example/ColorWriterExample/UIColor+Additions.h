//
//  UIColor+Additions.h
//  ColorWriterExample
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)
// returns a random color - either RGB or grayscale (1/3 of the time)
+ (UIColor *)randomColor;
- (NSString *)displayString;

@end
