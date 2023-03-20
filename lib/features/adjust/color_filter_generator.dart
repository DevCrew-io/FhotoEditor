part of image_crop;

/// abstract class for generating color matrix

abstract class ColorFilterGenerator{

  ColorFilterGenerator._();

  static ColorFilterGenerator? _instance;

  static ColorFilterGenerator getInstance() => _instance ??= _ColorFilterGenerator();
  List<double> hueAdjustMatrix({required double value});
  List<double> brightnessAdjustMatrix({required double value});
  List<double> saturationAdjustMatrix({required double value});



}