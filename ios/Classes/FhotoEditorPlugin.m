#import "FhotoEditorPlugin.h"
#if __has_include(<fhoto_editor/fhoto_editor-Swift.h>)
#import <fhoto_editor/fhoto_editor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fhoto_editor-Swift.h"
#endif

@implementation FhotoEditorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFhotoEditorPlugin registerWithRegistrar:registrar];
}
@end
