ASEColorWriter
========

ASEColorWriter is an Objective-C class that enables you to export UIColors in ‘ASE’ (Adobe Swatch Exchange) format. The exported files can be used with Photoshop, Illustrator and InDesign.

How to use it
---

Initialize an ASEColorWriter with an array of UIColors and a name for the palette. Then use the 'data' method to retrieve the ‘ASE’ formatted data.

```objective-c
NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
ASEColorWriter *writer = [[ASEColorWriter alloc] initWithColors:colors paletteName:@"RGB Palette"];
NSData *swatchData = [writer data];
```

The ‘Example’ folder in the repository contains a project that generates random colors and allows you to email the ‘ASE’ file to test the results.

Limitations
---

Only RGB colors are currently supported. Greyscale will be added soon.
