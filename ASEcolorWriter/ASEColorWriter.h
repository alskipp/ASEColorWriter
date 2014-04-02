//
//  ASEColorWriter.h
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASEColorWriter : NSObject
@property (retain, nonatomic) NSString *paletteName;

- (instancetype)initWithColors:(NSArray *)colors paletteName:(NSString *)paletteName;
- (NSData *)data;
@end
