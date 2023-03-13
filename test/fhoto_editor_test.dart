import 'package:flutter_test/flutter_test.dart';
import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:fhoto_editor/fhoto_editor_platform_interface.dart';
import 'package:fhoto_editor/fhoto_editor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFhotoEditorPlatform 
    with MockPlatformInterfaceMixin
    implements FhotoEditorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FhotoEditorPlatform initialPlatform = FhotoEditorPlatform.instance;

  test('$MethodChannelFhotoEditor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFhotoEditor>());
  });

  test('getPlatformVersion', () async {
    FhotoEditor fhotoEditorPlugin = FhotoEditor();
    MockFhotoEditorPlatform fakePlatform = MockFhotoEditorPlatform();
    FhotoEditorPlatform.instance = fakePlatform;
  
    expect(await fhotoEditorPlugin.getPlatformVersion(), '42');
  });
}
