import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

import "root:/modules/screencap"

Scope {
  id: root

  required property ScreencapContext context

  IpcHandler {
    target: "screencap"

    function toggle(): void {
      context.toggle()
    }
  }

  CustomShortcut {
    name: "toggleScreencap"
    description: "Open screencap tool or stop recording if already occuring"
    onPressed: {
      context.toggle()
    }
  }
}
