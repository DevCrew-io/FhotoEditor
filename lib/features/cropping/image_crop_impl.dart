part of fhoto_editor;

class _ImageCropImpl implements ImageCrop {
  static const _channel = MethodChannel(methodChannelName);

  @override
  Future<bool> requestPermissions() => _channel
      .invokeMethod('requestPermissions')
      .then<bool>((result) => result);

  @override
  Future<File> cropImage(
          {required File file, required ui.Rect area, double? scale}) =>
      _channel.invokeMethod('cropImage', {
        'path': file.path,
        'left': area.left,
        'top': area.top,
        'right': area.right,
        'bottom': area.bottom,
        'scale': scale ?? 1.0,
      }).then<File>((result) => File(result));

  @override
  Future<ImageOptions> getImageOptions({required File file}) async {
    final result =
        await _channel.invokeMethod('getImageOptions', {'path': file.path});

    return ImageOptions(
      width: result['width'],
      height: result['height'],
    );
  }

  @override
  Future<File> sampleImage(
      {required File file,
      int? preferredSize,
      int? preferredWidth,
      int? preferredHeight}) async {
    assert(() {
      if (preferredSize == null &&
          (preferredWidth == null || preferredHeight == null)) {
        throw ArgumentError(
            'Preferred size or both width and height of a resampled image must be specified.');
      }
      return true;
    }());

    final String path = await _channel.invokeMethod('sampleImage', {
      'path': file.path,
      'maximumWidth': preferredSize ?? preferredWidth,
      'maximumHeight': preferredSize ?? preferredHeight,
    });

    return File(path);
  }
}
