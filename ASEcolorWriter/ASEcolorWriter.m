//
//  ASEcolorWriter.m
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "ASEcolorWriter.h"

#define COLOR_CHANNELS 3

@implementation ASEcolorWriter
{
    NSArray *_colors;
    NSMutableData *_swatchData;
}

- (instancetype)initWithColors:(NSArray *)colors paletteName:(NSString *)paletteName
{
    self = [super init];
    if (self) {
        _colors = colors;
        _swatchData = [NSMutableData data];
    }
    return self;
}

- (NSData *)data
{
    [self appendFileSignature];
    [self appendPaletteName:_paletteName];
    [self appendSwatches:_colors];
    return _swatchData;
}

- (void)appendFileSignature;
{
	NSData *nameData = [@"ASEF" dataUsingEncoding: NSASCIIStringEncoding];
    
	UInt16 fileVersionMajor = CFSwapInt16HostToBig(1);
	UInt16 fileVersionMinor = CFSwapInt16HostToBig(0);
    
    UInt32 blockLength = (UInt32)[_colors count] + 1; // number of colors + palette
	UInt32 numberOfBlocks = CFSwapInt32HostToBig(blockLength);
    
	[_swatchData appendData:nameData];
	[_swatchData appendBytes:&fileVersionMajor length:sizeof(UInt16)];
	[_swatchData appendBytes:&fileVersionMinor length:sizeof(UInt16)];
	[_swatchData appendBytes:&numberOfBlocks length:sizeof(UInt32)];
}

- (void)appendPaletteName:(NSString *)name;
{
    UInt16 groupStart = CFSwapInt16HostToBig(0xc001);
	UInt32 blockLength = CFSwapInt32HostToBig((UInt32)([name length]*2)+4); //double byte name + 2 byte null termination
	UInt16 nameSize = CFSwapInt16HostToBig((UInt16)[name length]+1);
	NSData *nameData = [name dataUsingEncoding: NSUTF16BigEndianStringEncoding];
	UInt16 terminate = CFSwapInt16HostToBig(0x0000);
	
	[_swatchData appendBytes:&groupStart length:sizeof(UInt16)];
	[_swatchData appendBytes:&blockLength length:sizeof(UInt32)];
	[_swatchData appendBytes:&nameSize length:sizeof(UInt16)];
	[_swatchData appendData:nameData];
	[_swatchData appendBytes:&terminate length:sizeof(UInt16)];
}

- (void)appendSwatches:(NSArray *)colors
{
    for (UIColor *color in colors){
        
        NSString *colorName = [self displayStringForColor:color];
		
		UInt16 colStart = CFSwapInt16HostToBig(0x0001);
		UInt32 blockLength = CFSwapInt32HostToBig((UInt32)([colorName length] * 2) + (COLOR_CHANNELS * 4) + 10);
		UInt16 nameSize = CFSwapInt16HostToBig([colorName length]+1);
		NSData *colorNameData = [colorName dataUsingEncoding: NSUTF16BigEndianStringEncoding];
		UInt16 terminate = CFSwapInt16HostToBig(0x0000);
		
        NSData *colorModeData = [@"RGB " dataUsingEncoding: NSASCIIStringEncoding];
        NSData *colorValueData = [self dataForColor:color];
		UInt16 swatchType = CFSwapInt16HostToBig(2);
        
		[_swatchData appendBytes:&colStart length:sizeof(UInt16)];
		[_swatchData appendBytes:&blockLength length:sizeof(UInt32)];
		[_swatchData appendBytes:&nameSize length:sizeof(UInt16)];
		[_swatchData appendData:colorNameData];
		[_swatchData appendBytes:&terminate length:sizeof(UInt16)];
		[_swatchData appendData:colorModeData];
		[_swatchData appendData:colorValueData];
		[_swatchData appendBytes:&swatchType length:sizeof(UInt16)];
	}
}

- (NSData *)dataForColor:(UIColor *)color
{
    NSMutableData *colorValueData = [NSMutableData data];
    
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    CFSwappedFloat32 col1, col2, col3;

    col1 = CFConvertFloatHostToSwapped((Float32)red);
    col2 = CFConvertFloatHostToSwapped((Float32)green);
    col3 = CFConvertFloatHostToSwapped((Float32)blue);
    [colorValueData appendBytes:&col1 length:sizeof(Float32)];
    [colorValueData appendBytes:&col2 length:sizeof(Float32)];
    [colorValueData appendBytes:&col3 length:sizeof(Float32)];
    
    return colorValueData;
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