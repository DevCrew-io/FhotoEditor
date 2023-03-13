//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fhoto_editor/fhoto_editor_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) fhoto_editor_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FhotoEditorPlugin");
  fhoto_editor_plugin_register_with_registrar(fhoto_editor_registrar);
}
