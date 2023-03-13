
import 'fhoto_editor_platform_interface.dart';

class FhotoEditor {
  Future<String?> getPlatformVersion() {
    return FhotoEditorPlatform.instance.getPlatformVersion();
  }
}
