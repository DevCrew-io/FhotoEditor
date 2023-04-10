part of fhoto_editor;

/// abstract class for generating color matrix

abstract class ColorFilterGenerator{

  ColorFilterGenerator._();

  static ColorFilterGenerator? _instance;

  static ColorFilterGenerator getInstance() => _instance ??= _ColorFilterGenerator();

  /// a hue matrix is a way to modify the colors of an image or widget by applying
  /// a transformation matrix to its color values. The transformation matrix is a 4x4 matrix
  /// that can be used to adjust the hue, saturation, brightness, and contrast of the colors in the image.

  List<double> getHueMatrix({required double value});
  List<double> getBrightnessMatrix({required double value});
  List<double> getSaturationMatrix({required double value});
  List<double> getExposureMatrix({required double value});
  List<double> getShadowMatrix({required double value});
  List<double> getHighlightedMatrix({required double value});
  //Not implemented Yet
  List<double> getVignetteMatrix({required double value});
  //Not implemented Yet
  List<double> getSharpnessMatrix({required double value});
  List<double> getFadedMatrix({required double value});
  //Not implemented Yet
  List<double> getSmoothMatrix({required double value});
  List<double> getVibrancyMatrix({required double value});
  List<double> getTemperatureMatrix({required double value});
  List<double> getContrastMatrix({required double value});


}