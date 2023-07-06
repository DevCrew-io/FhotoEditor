part of fhoto_editor;

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
  /// [file] is the source image. This is efficient implementation that does not decode
  /// nor load actual image into a memory.

  Future<ImageOptions> getImageOptions({required File file});


  /// [sampleImage] is used for scaling the image before loading into memory
  /// if you have larger image you can scale down by setting height and width of the image [preferredWidth] and [preferredHeight]
  /// if you have a square image then choose [preferredSize] to set height and width equally.
  /// [file] is the source image use for scaling


  Future<File> sampleImage({
    required File file,
    int? preferredSize,
    int? preferredWidth,
    int? preferredHeight,
  });


  /// Native support of cropping and scaling an image. In order to produce higher
  /// quality cropped image, rely on sampling image [sampleImage] with preferred maximum width [preferredWidth] and height [preferredHeight]. Scale [scale] up a resolution of
  /// the sampled image. When cropped, the image is in higher resolution.

  Future<File> cropImage({
    required File file,
    required Rect area,
    double? scale,
  });

  static ImageCrop? _instance;

  static ImageCrop getInstance() => _instance ??= _ImageCropImpl();
}
