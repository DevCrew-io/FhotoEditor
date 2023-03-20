part of image_crop;

/// Generic widget Used for the Changing colors for the selected Image

 Widget imageColorFilter({brightness, saturation, hue, child}) {
  final colorGen = ColorFilterGenerator.getInstance();
  return ColorFiltered(
      colorFilter: ColorFilter.matrix(
          colorGen.brightnessAdjustMatrix(
            value: brightness,
          )
      ),
      child: ColorFiltered(
          colorFilter: ColorFilter.matrix(
              colorGen.saturationAdjustMatrix(
                value: saturation,
              )
          ),
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(
                colorGen.hueAdjustMatrix(
                  value: hue,
                )
            ),
            child: child,
          )
      )
  );
}