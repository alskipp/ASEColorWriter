//
//  ASEColorWriter.h
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

/*
    A description of the binary format of ASE (Adobe Swatch Exchange) can be found here:
    http://www.selapa.net/swatches/colors/fileformats.php
*/

#import <Foundation/Foundation.h>

@interface ASEColorWriter : NSObject
- (instancetype)initWithColors:(NSArray *)colors paletteName:(NSString *)paletteName;
- (NSData *)data;
@end
