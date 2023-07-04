part of fhoto_editor;

class _ColorFilterGenerator implements ColorFilterGenerator {

  /// The function [getHueMatrix] first converts the input value to radians by multiplying it with the constant pi.
  /// If the input value is zero, it returns a default hue matrix with no changes to the original image colors.
  /// to see the proper Hue effects you need to convert your input values from 0 to 1 in function[getHueMatrix]

  @override
  List<double> getHueMatrix({required double value}) {

    /// convert an angle from degrees to radians.

    value = value * pi;

    if (value == 0) {
      return [
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0
      ];
    }

    /// If the input value is not zero, the function computes the sine and cosine of the input value.

    double cosVal = cos(value);
    double sinVal = sin(value);

    /// It then defines three constants, lumR, lumG, and lumB, which represent the luminance constants for
    /// the red, green, and blue channels, respectively.

    const lumR = 0.213;
    const lumG = 0.715;
    const lumB = 0.072;

    /// The function then returns a List of double values, which represents a hue matrix.
    /// The hue matrix is computed using the sine and cosine values of the input, and the luminance constants.
    /// The resulting matrix is a 4x4 matrix with the following coefficients:
    /// [R', G', B', 0,
    ///  R', G', B', 0,
    ///  R', G', B', 0,
    ///  0,   0,   0,  1]

    /// where R', G', and B' are the new red, green, and blue channel values after applying the hue transformation.

    /// Finally, the map function is used to convert each element of the List to a double,
    /// since the List<double>.from constructor returns a List of num values.
    /// The resulting List of double values represents the hue matrix for the provided input value.

    return List<double>.from(<double>[
      (lumR + (cosVal * (1 - lumR))) + (sinVal * (-lumR)),
      (lumG + (cosVal * (-lumG))) + (sinVal * (-lumG)),
      (lumB + (cosVal * (-lumB))) + (sinVal * (1 - lumB)),
      0,
      0,
      (lumR + (cosVal * (-lumR))) + (sinVal * 0.143),
      (lumG + (cosVal * (1 - lumG))) + (sinVal * 0.14),
      (lumB + (cosVal * (-lumB))) + (sinVal * (-0.283)),
      0,
      0,
      (lumR + (cosVal * (-lumR))) + (sinVal * (-(1 - lumR))),
      (lumG + (cosVal * (-lumG))) + (sinVal * lumG),
      (lumB + (cosVal * (1 - lumB))) + (sinVal * lumB),
      0,
      0,
      0,
      0,
      0,
      1,
      0
    ]).map((i) => i.toDouble()).toList();
  }

  /// [getBrightnessMatrix] function first checks if the input value is less than or equal to zero.
  /// If it is, the function assumes the input value is a decimal percentage of the maximum brightness,
  /// so it converts the value to a range between 0 and 255. If the input value is greater than zero,
  /// the function assumes the input value is a decimal percentage of the maximum brightness,
  /// so it keeps the value in the range between 0 and 100.
  /// input value for function[getBrightnessMatrix] is from 0 to 1

  @override
  List<double> getBrightnessMatrix({required double value}) {

    if (value <= 0) {
      value = value * 255;
    } else {
      value = value * 100;
    }

    /// If the input value is zero, the function returns a default brightness matrix with no changes to the original image colors.
    /// If the input value is not zero, the function returns a List of double values representing a brightness matrix.
    /// The brightness matrix is a 4x4 matrix with the following coefficients:
    /// [1, 0, 0, 0,
    ///  0, 1, 0, 0,
    ///  0, 0, 1, 0,
    ///  V, V, V, 1]
    /// where V is the brightness value calculated from the input.
    /// The matrix scales the original color values by the brightness value V.

    if (value == 0) {
      return [
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0
      ];
    }

    return List<double>.from(<double>[
      1, 0, 0, 0, value,
      0, 1, 0, 0, value,
      0, 0, 1, 0, value,
      0, 0, 0, 1, 0
    ]).map((i) => i.toDouble()).toList();
  }

  /// [getSaturationMatrix]The function first multiplies the value parameter by 100, and stores the result back in value.
  /// This is done to convert the value from a percentage to a decimal value, which is easier to work with.
  /// for better results pass values between -6 to 2 in in function[getSaturationMatrix]

  @override
  List<double> getSaturationMatrix({required double value}) {
    value = value * 100;

    /// If the resulting value is 0, the function returns a list representing an identity matrix.
    /// Otherwise, the function calculates a saturation matrix using the following formula:

    /// | (0.3086 * (1 - x)) + x   0.6094 * (1 - x)        0.082 * (1 - x)         0      |
    /// | 0.3086 * (1 - x)         (0.6094 * (1 - x)) + x   0.082 * (1 - x)         0     |
    /// | 0.3086 * (1 - x)         0.6094 * (1 - x)        (0.082 * (1 - x)) + x    0     |
    /// | 0                        0                        0                        1    |

    /// where x is (1 + ((value > 0) ? ((3 * value) / 100) : (value / 100))).
    /// Note that this function assumes that the input value is between -1 and 1.

    if (value == 0) {
      return [
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0
      ];
    }

    double x =
        ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();
    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.082;

    return List<double>.from(<double>[
      (lumR * (1 - x)) + x,
      lumG * (1 - x),
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      (lumG * (1 - x)) + x,
      lumB * (1 - x),
      0,
      0,
      lumR * (1 - x),
      lumG * (1 - x),
      (lumB * (1 - x)) + x,
      0,
      0,
      0,
      0,
      0,
      1,
      0
    ]).map((i) => i.toDouble()).toList();
  }

  /// [getExposureMatrix] function assumes that the input value can be any real number.
  /// for better results pass values between -2 to 5 in in function[getExposureMatrix]

  @override
  List<double> getExposureMatrix({required double value}) {

    /// The function first calculates a new value by raising 2 to the power of the value parameter,
    /// and stores the result in updatedValue.

  double updatedValue = math.pow(2, value).toDouble();

  /// The function then creates a list of doubles representing a 4x5 matrix,
  /// where the first three diagonal elements are set to updatedValue,
  /// and the rest of the elements are set to 0. This is done to create an exposure matrix.


    return List<double>.from(<double>[
      updatedValue,0,0,0,0,
      0,updatedValue,0,0,0,
      0,0,updatedValue,0,0,
      0,0,0,1,0
    ]).map((i) => i.toDouble()).toList();
  }

  /// for better results pass values between 0 to 100 in function[getContrastMatrix]

  @override
  List<double> getContrastMatrix({required double value}) {

    /// function first calculates a scale value by adding 1 to the value parameter.
    /// It then calculates a translate value by multiplying -0.5 with the scale value and adding 0.5,
    /// and then multiplying the result with 255.

    var scale = value + 1;
    var translate = (-.5 * scale + .5) * 255;

    /// The last row of the matrix is fixed with the values 0, 0, 0, 1, 0,
    /// which means it doesn't contribute to the contrast adjustment of the image.

    return List<double>.from(<double>[
      scale,0,0,0,translate,
      0,scale,0,0,translate,
      0,0,scale,0,translate,
      0,0,0,1,0
    ]).map((i) => i.toDouble()).toList();

  }

  /// for better results pass values between 0 to 10 in function[getFadedMatrix]

  @override
  List<double> getFadedMatrix({required double value}) {

    /// The first three rows, containing all 1's, represent a solid background color or image.
    /// These rows may be used to provide a consistent backdrop for the faded effect in the last row.
    /// The fourth row, containing all 0's except for the fourth column, represents the "faded" or transparent area.
    /// This row may be used to create a gradient effect, where the transparency gradually increases towards a certain point.

    return List<double>.from(<double>[
      value, 0, 0, 0, 0, // red
      0, value, 0, 0, 0, // green
      0, 0, value, 0, 0, // blue
      0, 0, 0, 1.0, 0, // alpha
    ]).map((i) => i.toDouble()).toList();

  }

  /// for better results pass values between -1 to 10 in function[getHighlightedMatrix]

  @override
  List<double> getHighlightedMatrix({required double value}) {
    var scale = value + 1;

    /// The translate variable is computed based on the scale value using the formula (-.1 * scale + .1) * 255.
    /// This formula computes a value between 0 and 255 that is used to adjust the brightness of the highlighted image.

    var translate = (-.1 * scale + .1) * 255;

    /// A list of 20 double values is defined, containing four rows and five columns,
    /// representing the 4x4 transformation matrix. The values in the matrix are set such that the first three rows
    /// represent scaling and translation operations that increase the intensity of the image,
    /// while the fourth row is a fixed row used for homogeneous transformations.

    return List<double>.from(<double>[
      scale,0,0,0,translate,
      0,scale,0,0,translate,
      0,0,scale,0,translate,
      0,0,0,1,0
    ]).map((i) => i.toDouble()).toList();
  }

  /// for better results pass values between -10 to 10 in function[getShadowMatrix]

  @override
  List<double> getShadowMatrix({required double value}) {
    var scale = value + 1.0;

    /// The translate variable is computed based on the scale value using the formula (-.8 * scale + .8) * 255.
    /// This formula computes a value between 0 and 255 that is used to adjust the darkness of the shadow effect on the image.

    var translate = (-.8 * scale + .8) * 255;

    /// A list of 20 double values is defined, containing four rows and five columns,
    /// representing the 4x4 transformation matrix. The values in the matrix are set such that
    /// the first three rows represent scaling and translation operations that increase the intensity
    /// of the shadow effect, while the fourth row is a fixed row used for homogeneous transformations.

    return List<double>.from(<double>[
      scale,0,0,0,translate,
      0,scale,0,0,translate,
      0,0,scale,0,translate,
      0,0,0,1,0
    ]).map((i) => i.toDouble()).toList();

  }

  @override
  List<double> getSharpnessMatrix({required double value}) {
    throw UnimplementedError();
   /* const List<double> sharpnessMatrix = [
      0, -1, 0, 0, 0,
      -1, 5, -1, 0, 0,
      0, -1, 0, 0, 0,
      0, 0, 0, 1, 0,
    ];
    return sharpnessMatrix;*/
  }

  @override
  List<double> getSmoothMatrix({required double value}) {
   /* final smoothMatrix = <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, value, 0
    ];
return smoothMatrix;*/
    throw UnimplementedError();
  }

  /// for better results pass values between 0 to 10 in function[getTemperatureMatrix]


  @override
  List<double> getTemperatureMatrix({required double value}) {

    double warmth = value;

    ///  Creates a list of doubles with a length of 20 (4 rows and 5 columns) and fills it with 0s.
    ///  This will be used to store the color matrix values.

    List<double> matrix = List<double>.filled(4 * 5, 0);

    /// The function creates a list matrix of length 20, filled with zeros,
    /// which will be used to store the color matrix values.
    /// It then sets the baseTemperature value to 5000 and checks if the warmth parameter is less than or equal to zero, in which case it sets it to 0.01.

    double baseTemperature = 5000;
    if (warmth <= 0) warmth = 0.01;

    /// The function then calculates the color values for red,
    /// green, and blue using the temperature value provided.
    /// It uses a mathematical formula to calculate the corresponding color values based on the temperature value,
    /// using conditional statements to determine the calculation method based on the temperature value.

    double tmpColorR;
    double tmpColorG;
    double tmpColorB;
    double kelvin = baseTemperature / warmth;
    double centiKelvin1 = kelvin / 100;
    double colorR1;
    double colorG1;
    if (centiKelvin1 > 66) {
      double tmp = centiKelvin1 - 60;
      colorR1 = 329.698727446 * pow(tmp, -0.1332047592);
      colorG1 = 288.1221695283 * pow(tmp, 0.0755148492);
    } else {
      colorG1 = 99.4708025861 * log(centiKelvin1) - 161.1195681661;
      colorR1 = 255;
    }
    double colorB1 = centiKelvin1 < 66
        ? centiKelvin1 > 19
        ? 138.5177312231 * log(centiKelvin1 - 10) - 305.0447927307
        : 0
        : 255;
     tmpColorR = 255.coerceAtMost(colorR1.coerceAtLeast(0).toInt()).toDouble();
     tmpColorG = 255.coerceAtMost(colorG1.coerceAtLeast(0).toInt()).toDouble();
     tmpColorB = 255.coerceAtMost(colorB1.coerceAtLeast(0).toInt()).toDouble();

    double color_r = tmpColorR;
    double color_g = tmpColorG;
    double color_b = tmpColorB;
    kelvin = baseTemperature;

    double centiKelvin = kelvin / 100;
    double colorR;
    double colorG;
    if (centiKelvin > 66) {
      double tmp = centiKelvin - 60;
      colorR = 329.698727446 * pow(tmp, -0.1332047592);
      colorG = 288.1221695283 * pow(tmp, 0.0755148492);
    } else {
      colorG = 99.4708025861 * log(centiKelvin) - 161.1195681661;
      colorR = 255;
    }
    double colorB = centiKelvin < 66
        ? centiKelvin > 19
        ? 138.5177312231 * log(centiKelvin - 10) - 305.0447927307
        : 0
        : 255;
     tmpColorR = 255.coerceAtMost(colorR.coerceAtLeast(0).toInt()).toDouble();
     tmpColorG = 255.coerceAtMost(colorG.coerceAtLeast(0).toInt()).toDouble();
     tmpColorB = 255.coerceAtMost(colorB.coerceAtLeast(0).toInt()).toDouble();

    color_r /= tmpColorR;
    color_g /= tmpColorG;
    color_b /= tmpColorB;

    matrix[0] = color_r;
    matrix[1] = 0;
    matrix[2] = 0;
    matrix[3] = 0;
    matrix[4] = 0;

    matrix[5] = 0;
    matrix[6] = color_g;
    matrix[7] = 0;
    matrix[8] = 0;
    matrix[9] = 0;

    matrix[10] = 0;
    matrix[11] = 0;
    matrix[12] = color_b;
    matrix[13] = 0;
    matrix[14] = 0;

    matrix[15] = 0;
    matrix[16] = 0;
    matrix[17] = 0;
    matrix[18] = 1;
    matrix[19] = 0;

   return matrix;
  }

  /// The vibrancy matrix is a 5x5 matrix used for image processing and manipulation,
  /// where each element of the matrix corresponds to a different color channel or image property.
  /// The vibrancy matrix is typically applied to images to increase their saturation and color intensity,
  /// resulting in a more vibrant and lively appearance.
  /// for better results pass values between -30 to 100 in function[getVibrancyMatrix]

  @override
  List<double> getVibrancyMatrix({required double value}) {

    final double x = value * 2.0 / 100.0;
    final double y = x * 1.9;
    final double z = x * 1.8;
    return [
      x + 1.0, y, z, 0, 0,
      0, x + 1.0, 0, 0, 0,
      0, 0, x + 1.0, 0, 0,
      0, 0, 0, 1.0, 0,
    ];
  }

  @override
  List<double> getVignetteMatrix({required double value}) {
    throw UnimplementedError();
    /*const List<double> vignetteMatrix = [
      0.8, 0, 0, 0, 0,
      0, 0.8, 0, 0, 0,
      0, 0, 0.6, 0, 0,
      0, 0, 0, 0.8, 0,
    ];
return vignetteMatrix;*/
  }
}
