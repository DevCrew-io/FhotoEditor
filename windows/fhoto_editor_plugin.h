#ifndef FLUTTER_PLUGIN_FHOTO_EDITOR_PLUGIN_H_
#define FLUTTER_PLUGIN_FHOTO_EDITOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace fhoto_editor {

class FhotoEditorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FhotoEditorPlugin();

  virtual ~FhotoEditorPlugin();

  // Disallow copy and assign.
  FhotoEditorPlugin(const FhotoEditorPlugin&) = delete;
  FhotoEditorPlugin& operator=(const FhotoEditorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace fhoto_editor

#endif  // FLUTTER_PLUGIN_FHOTO_EDITOR_PLUGIN_H_
