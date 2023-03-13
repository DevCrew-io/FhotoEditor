#include "include/fhoto_editor/fhoto_editor_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fhoto_editor_plugin.h"

void FhotoEditorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fhoto_editor::FhotoEditorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
