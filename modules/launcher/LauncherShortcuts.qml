import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

import "root:/modules/launcher"

Scope {
  id: root

  required property LauncherContext context

  CustomShortcut {
    name: "toggleLauncher"
    description: "Toggle the launcher"
    onPressed: {
      context.visible = !context.visible
    }
  }

  IpcHandler {
    target: "launcher"

    function open(): void {
      launcherContext.visible = true;
    }

    function toggle(): void {
      launcherContext.visible = !launcherContext.visible;
    }
  }
}
