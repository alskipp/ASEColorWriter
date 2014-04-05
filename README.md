ASEColorWriter
========

ASEColorWriter is an Objective-C library that enables you to export UIColors in ‘ASE’ (Adobe Swatch Exchange) format. The exported files can be used with Photoshop, Illustrator and InDesign. RGB and grayscale swatches are supported.


Which files are needed?
---

For [CocoaPods](http://beta.cocoapods.org) users, simply add `pod 'ASEColorWriter'` to your podfile. 

Incidentally, CocoaPods allows you to quickly test Pods. To do so, just enter `$ pod try ASEColorWriter` in the terminal. CocoaPods will download the demo project into a temp folder and open it in Xcode. Magic.

If you don't use CocoaPods, just include these files in your project:

* ASEColorWriter.h
* ASEColorWriter.m


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
