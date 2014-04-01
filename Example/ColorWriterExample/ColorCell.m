//
//  ColorCell.m
//  ColorWriterExample
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "ColorCell.h"
#import "UIColor+Additions.h"

@interface ColorCell ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@end

@implementation ColorCell

- (void)setColor:(UIColor *)color;
{
    self.colorView.backgroundColor = color;
    self.colorLabel.text = [color displayString];
}

@end
