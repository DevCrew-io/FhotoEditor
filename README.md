# FhotoEditor

[![pub package](https://img.shields.io/pub/v/expandable_richtext.svg)](https://pub.dev/packages/expandable_richtext)
[![license](https://img.shields.io/badge/license-MIT-green)](https://github.com/DevCrew-io/expandable-richtext/blob/main/LICENSE)
![](https://img.shields.io/badge/Code-Dart-informational?style=flat&logo=dart&color=29B1EE)
![](https://img.shields.io/badge/Code-Flutter-informational?style=flat&logo=flutter&color=0C459C)

FhotoEditor Plugin with simple, easy support for image editing using Filters, Cropping and transformation. plugin support for all ios and android and web, cropping feature is only available for ios and android.

To start with this, we need to simply add the dependencies in the gradle file of our app module like this

## Installation
First, add image_editor_plus: as a dependency in your pubspec.yaml file.

Import
```dart
import 'package:fhoto_editor/fhoto_editor.dart';
```
Then run ```flutter pub get``` to install the package.

## iOS
Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:

* NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
```dart
<key>NSPhotoLibraryUsageDescription</key>
<string>Used to demonstrate image picker plugin</string>
```

## Key Features
Here is update which already done in PhotoEditing plugin

[implement Single filter on given image](#single-filter-on-image)


[implement Multiple filters on given image](#multiple-filters-on-image)

[saving image after filters](#saving-image-locally)

[Cropping images](#cropping-images)

[Adjusting](#adjusting-hue)

[Brightness](#brightness)

[Saturation](#saturation)

[Exposure](#exposure)

[Shadow](#shadow)

[Highlighted](#highlighted)

[Vignette](#vignette)

[Faded](#faded)

[Vibrancy](#vibrancy)

[Temperature](#temperature)

[Contrast](#contrast)

[Rotation](#rotation)

[Flip](#flip)
## Demo
![Alt text](https://github.com/DevCrew-io/FhotoEditor/blob/readme/screeenshots/ezgif.com-video-to-gif.gif)

## Usage
### Single Filter on Image
making an instance for color generator class
```dart
final colorGen = ColorFilterGenerator.getInstance();
```
use it in the ColorFiltered widget as a matrix
```dart
  ColorFiltered(
         colorFilter: ColorFilter.matrix(myFilter.matrix),
         child: Image.asset('assets/shahid.jpeg'))
```
### Multiple filters on image
```dart
final colorGen = ColorFilterGenerator.getInstance();
```
 ```dart
ColorMultiFilterGenerator myFilter = ColorMultiFilterGenerator(filters: [
      colorGen.getHueMatrix(value: _hueSeekbarValue),
      colorGen.getContrastMatrix(value: _contrastSeekbarValue),
      colorGen.getBrightnessMatrix(value: _brightnessSeekbarValue),
      colorGen.getSaturationMatrix(value: _saturationSeekbarValue),
      colorGen.getExposureMatrix(value: _exposureSeekbarValue),
      colorGen.getShadowMatrix(value: _shadowSeekbarValue),
      colorGen.getHighlightedMatrix(value: _highlightedSeekbarValue),
      colorGen.getFadedMatrix(value: _fadedSeekbarValue),
      colorGen.getVibrancyMatrix(value: _vibrancySeekbarValue),
      colorGen.getTemperatureMatrix(value: _temperatureSeekbarValue),
    ]);
```
apply the myFilter instance to colorFiltered widget

  ```dart   ColorFiltered(
                      colorFilter: ColorFilter.matrix(myFilter.matrix),
                      child: Image.asset('assets/shahid.jpeg'))
```
### Saving image locally

RenderRepaintBoundary widget to capture a snapshot of a specific area of
the screen and converts it into a ui.Image object.

```dart   Future<ui.Image> _getImageFromRepaintBoundary() async {
    RenderRepaintBoundary boundary =
    _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }
 ```

 ```dart
 void saveImage(ui.Image image) async {
  // Create a ByteData buffer to hold the image data.
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  // Get the device's default directory for storing files.
  final directory = await getTemporaryDirectory();

  // Create a file to write the image data to.
  final File file = File('${directory.path}/filtered_image.png');

  // Write the image data to the file.
  await file.writeAsBytes(pngBytes);

  if (kDebugMode) {
    print("File Saved:${file.path}");
  }
}
``` 
### Cropping images
Select an image from the image picker and apply sampling to load into memory
 ```dart
  late File _file = File("path");
late File _sample = File("path");

Future<void> _openImage() async {
  final pickedFile =
  await ImagePicker().getImage(source: ImageSource.gallery);
  final file = File(pickedFile?.path as String);

  /// sampleImage is used here for scale down larger images before loading into memory.
  /// preferredSize is being used here for square images
  /// context.size?.longestSide.ceil() is to get actual size of height and width of image

  final sample = await  ImageCrop.getInstance().sampleImage(file: file, preferredSize: context.size?.longestSide.ceil());

  setState(() {
    _sample = sample;
    _file = file;
  });
}
```
use cropImage function to crop the sampled image loaded into memory
```dart

final cropKey = GlobalKey<CropViewState>();
late File _lastCropped = File("path");

Future<File?> _cropImage() async {
  final scale = cropKey.currentState?.scale;
  final area = cropKey.currentState?.area;
  if (area == null) {
    // cannot crop, widget is not setup
    return null;
  }

  /// scale up to use maximum possible number of pixels
  /// this will sample image in higher resolution to make cropped image larger
  final sample = await ImageCrop.getInstance().sampleImage(
    file: _file,
    preferredSize: (2000 / scale!).round(),
  );

  final file = await ImageCrop.getInstance().cropImage(
    file: sample,
    area: area,
  );

  sample.delete();

  _lastCropped.delete();
  _lastCropped = file;

  debugPrint('$file');
  return file;
}
```
show cropped image

```dart
 Expanded(
child: Image.file(File(croppedFile.path)),
)
```
![Alt text](https://github.com/DevCrew-io/FhotoEditor/blob/readme/screeenshots/cropping.gif)
### Adjusting Hue
```dart
ColorFilter.matrix(colorGen.getHueMatrix(value: _seekbarValue)
```
### Brightness
```dart
ColorFilter.matrix(colorGen.getBrightnessMatrix(value: _seekbarValue)
```
### Saturation
```dart
ColorFilter.matrix(colorGen.getSaturationMatrix(value: _seekbarValue)
```
### Exposure
```dart
ColorFilter.matrix(colorGen.getExposureMatrix(value: _seekbarValue)
```
### Shadow
```dart
ColorFilter.matrix(colorGen.getShadowMatrix(value: _seekbarValue)
```
### Highlighted
```dart
ColorFilter.matrix(colorGen.getHighlightedMatrix(value: _seekbarValue)
```
### Vignette
```dart
ColorFilter.matrix(colorGen.getVignetteMatrix(value: _seekbarValue)
```
### Faded
```dart
ColorFilter.matrix(colorGen.getFadedMatrix(value: _seekbarValue)
```
### Vibrancy
```dart
ColorFilter.matrix(colorGen.getVibrancyMatrix(value: _seekbarValue)
```
### Temperature
```dart
ColorFilter.matrix(colorGen.getTemperatureMatrix(value: _seekbarValue)
```
### Contrast
```dart
ColorFilter.matrix(colorGen.getContrastMatrix(value: _seekbarValue)
```
### Rotation
```dart
double _rotation = 0.0;
bool _isVerticalFlip = false;
rotateWidget(Image.asset("assets/image.jpeg"),_rotation),
```
### Flip
```dart
double _rotation = 0.0;
bool _isVerticalFlip = false;
flipWidget(Image.asset("assets/image.jpeg"),_rotation,_isVerticalFlip)
```

## Bugs and feature requests

Have a bug or a feature request? Please first search for existing and closed issues. If your problem
or idea is not addressed
yet, [please open a new issue](https://github.com/DevCrew-io/FhotoEditor/issues/new).

## Author

[DevCrew I/O](https://devcrew.io/)
<h3 align=“left”>Connect with Us:</h3>
<p align="left">
<a href="https://devcrew.io" target="blank"><img align="center" src="https://devcrew.io/wp-content/uploads/2022/09/logo.svg" alt="devcrew.io" height="35" width="35" /></a>
<a href="https://www.linkedin.com/company/devcrew-io/mycompany/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="mycompany" height="30" width="40" /></a>
<a href="https://github.com/DevCrew-io" target="blank"><img align="center" src="https://cdn-icons-png.flaticon.com/512/733/733553.png" alt="DevCrew-io" height="32" width="32" /></a>
</p>

## Contributing

Contributions, issues, and feature requests are welcome!

## Show your Support

Give a star if this project helped you.

## Copyright & License

Code copyright 2023 DevCrew I/O. Code released under
the [MIT license](https://github.com/DevCrew-io/expandable-richtext/blob/main/LICENSE).
