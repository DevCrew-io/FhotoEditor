import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fhoto_editor_method_channel.dart';

abstract class FhotoEditorPlatform extends PlatformInterface {
  /// Constructs a FhotoEditorPlatform.
  FhotoEditorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FhotoEditorPlatform _instance = MethodChannelFhotoEditor();

  /// The default instance of [FhotoEditorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFhotoEditor].
  static FhotoEditorPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FhotoEditorPlatform] when
  /// they register themselves.
  static set instance(FhotoEditorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
