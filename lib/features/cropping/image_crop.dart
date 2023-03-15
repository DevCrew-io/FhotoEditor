part of image_crop;

class ImageOptions {
  final int width;
  final int height;

  ImageOptions({
    required this.width,
    required this.height,
  });

  @override
  int get hashCode => hashValues(width, height);

  @override
  bool operator ==(other) =>
      other is ImageOptions && other.width == width && other.height == height;

  @override
  String toString() => '$runtimeType(width: $width, height: $height)';
}

abstract class ImageCrop {
  ImageCrop._();

  /// Request permissions from native side

  Future<bool> requestPermissions();

  /// Read image options, such as: width and height.
  /// This is efficient implementation that does not decode
  /// nor load actual image into a memory.

  Future<ImageOptions> getImageOptions({required File file});


  /// scale up to use maximum possible number of pixels
  /// this will sample image in higher resolution to make cropped image larger
  /// If a large image is to be loaded into the memory, there is a sampling function that relies on a native platform
  /// to proportionally scale down the image before loading it to the memory. e.g. resample image to get down to 1024x4096
  /// dimension as close as possible. If it is a square preferredSize can be used to specify both width and height. Prefer
  /// to leverage this functionality when displaying images in UI.


  Future<File> sampleImage({
    required File file,
    int? preferredSize,
    int? preferredWidth,
    int? preferredHeight,
  });


  /// Native support of cropping and scaling an image. In order to produce higher
  /// quality cropped image, rely on sampling image with preferred maximum width and height. Scale up a resolution of
  /// the sampled image. When cropped, the image is in higher resolution.

  Future<File> cropImage({
    required File file,
    required Rect area,
    double? scale,
  });

  static ImageCrop? _instance;

  static ImageCrop getInstance() => _instance ??= _ImageCropImpl();
}
