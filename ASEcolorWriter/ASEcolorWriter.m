//
//  ASEcolorWriter.m
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "ASEcolorWriter.h"

@implementation ASEcolorWriter
{
    NSMutableData *_swatchData;
}

- (instancetype)initWithColors:(NSArray *)colors paletteName:(NSString *)paletteName
{
    self = [super init];
    if (self) {
        _swatchData = [NSMutableData data];
    }
    return self;
}

- (NSData *)data
{
    return _swatchData;
}

@end