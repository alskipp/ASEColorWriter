//
//  ASEColorWriter.m
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

@interface NSMutableData (ASEAdditions)
+ (NSMutableData *)ASEDataWithLength:(UInt32)length; // length == number of colors + number of groups
- (void)appendASESwatchName:(NSString *)name;
- (void)appendASEColor:(UIColor *)color;
- (void)appendASEData:(NSData *)data startMarker:(UInt16)marker;
@end

@implementation NSMutableData (ASEAdditions)

+ (NSMutableData *)ASEDataWithLength:(UInt32)length
{
    NSData *nameData = [@"ASEF" dataUsingEncoding: NSASCIIStringEncoding];
	UInt16 fileVersionMajor = CFSwapInt16HostToBig(1);
	UInt16 fileVersionMinor = CFSwapInt16HostToBig(0);
	UInt32 numberOfBlocks = CFSwapInt32HostToBig(length);
    
    NSMutableData *aseData = [NSMutableData data];
	[aseData appendData:nameData];
	[aseData appendBytes:&fileVersionMajor length:sizeof(UInt16)];
	[aseData appendBytes:&fileVersionMinor length:sizeof(UInt16)];
	[aseData appendBytes:&numberOfBlocks length:sizeof(UInt32)];
    
    return aseData;
}

- (void)appendASESwatchName:(NSString *)name;
{
    UInt16 nameSize = CFSwapInt16HostToBig((UInt16)[name length]+1);
	NSData *nameData = [name dataUsingEncoding: NSUTF16BigEndianStringEncoding];
	UInt16 terminate = CFSwapInt16HostToBig(0x0000);
    
    [self appendBytes:&nameSize length:sizeof(UInt16)];
	[self appendData:nameData];
	[self appendBytes:&terminate length:sizeof(UInt16)];
}

- (void)appendASEColor:(UIColor *)color
{
    NSData *colorModeData = [@"RGB " dataUsingEncoding: NSASCIIStringEncoding];
    [self appendData:colorModeData];

    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    CFSwappedFloat32 col1, col2, col3;
    
    col1 = CFConvertFloatHostToSwapped((Float32)red);
    col2 = CFConvertFloatHostToSwapped((Float32)green);
    col3 = CFConvertFloatHostToSwapped((Float32)blue);
    [self appendBytes:&col1 length:sizeof(Float32)];
    [self appendBytes:&col2 length:sizeof(Float32)];
    [self appendBytes:&col3 length:sizeof(Float32)];
    
    UInt16 swatchType = CFSwapInt16HostToBig(0); // Global swatch
    [self appendBytes:&swatchType length:sizeof(UInt16)];
}

- (void)appendASEData:(NSData *)data startMarker:(UInt16)marker
{
    UInt32 blockLength = CFSwapInt32HostToBig((UInt32)[data length]);
    [self appendBytes:&marker length:sizeof(UInt16)];
    [self appendBytes:&blockLength length:sizeof(UInt32)];
    [self appendData:data];
}

@end


#import "ASEColorWriter.h"

@implementation ASEColorWriter
{
    NSArray *_colors;
    NSMutableData *_aseData;
    NSMutableData *_tempData;
}

- (instancetype)initWithColors:(NSArray *)colors paletteName:(NSString *)paletteName
{
    self = [super init];
    if (self) {
        _colors = colors;
        _aseData = [NSMutableData ASEDataWithLength:(UInt32)[colors count] + 1]; // colors + 1 group
        _tempData = [NSMutableData data];
    }
    return self;
}

- (NSData *)data
{
    [self appendGroupName:_paletteName];
    [self appendSwatches:_colors];
    return _aseData;
}

- (void)appendGroupName:(NSString *)name;
{
    [_tempData setLength:0];
    [_tempData appendASESwatchName:name];

    UInt16 groupStart = CFSwapInt16HostToBig(0xc001);
    [_aseData appendASEData:_tempData startMarker:groupStart];
}

- (void)appendSwatches:(NSArray *)colors
{
    for (UIColor *color in colors){
        [_tempData setLength:0];
        [_tempData appendASESwatchName:[self displayStringForColor:color]];
        [_tempData appendASEColor:color];
        
        UInt16 colorStart = CFSwapInt16HostToBig(0x0001);
        [_aseData appendASEData:_tempData startMarker:colorStart];
	}
}

- (NSString *)displayStringForColor:(UIColor *)color
{
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    return [NSString stringWithFormat:@"R=%d G=%d B=%d",
            (UInt8)(red * 255),
            (UInt8)(green * 255),
            (UInt8)(blue * 255)];
}

@end