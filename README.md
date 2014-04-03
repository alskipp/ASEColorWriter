ASEColorWriter
========

ASEColorWriter is an Objective-C library that enables you to export UIColors in ‘ASE’ (Adobe Swatch Exchange) format. The exported files can be used with Photoshop, Illustrator and InDesign. RGB and grayscale swatches are supported.

How to use it
---

Initialize an ASEColorWriter with an array of UIColors and a name for the palette. Then use the 'data' method to retrieve the ‘ASE’ formatted data.

```objective-c
NSArray *colors = @[[UIColor redColor], [UIColor grayColor], [UIColor blueColor]];
ASEColorWriter *writer = [[ASEColorWriter alloc] initWithColors:colors paletteName:@"Mixed Palette"];
NSData *swatchData = [writer data];
```

The ‘Example’ folder in the repository contains a project that generates random colors and allows you to email the ‘ASE’ file to test the results. (You can't send email from the iOS simulator, so install on your device to test the example project).

![screenshot] (http://alskipp.github.io/ASEColorWriter/img/screenshot1.png)
