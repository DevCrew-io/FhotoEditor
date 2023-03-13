import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fhoto_editor_platform_interface.dart';

/// An implementation of [FhotoEditorPlatform] that uses method channels.
class MethodChannelFhotoEditor extends FhotoEditorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fhoto_editor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
