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

  Future<bool> requestPermissions();

  Future<ImageOptions> getImageOptions({required File file});

  Future<File> sampleImage({
    required File file,
    int? preferredSize,
    int? preferredWidth,
    int? preferredHeight,
  });

  Future<File> cropImage({
    required File file,
    required Rect area,
    double? scale,
  });

  static ImageCrop? _instance;

  static ImageCrop getInstance() => _instance ??= _ImageCropImpl();
}
