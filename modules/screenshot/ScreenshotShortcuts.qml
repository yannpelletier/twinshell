import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

import "root:/modules/screenshot"

Scope {
  id: root

  required property ScreenshotContext context

  IpcHandler {
    target: "screenshot"

    function open(): void {
      context.open()
    }

    function openFreeze(): void {
      context.openFreeze()
    }
  }

  CustomShortcut {
    name: "screenshot"
    description: "Open screenshot tool"
    onPressed: {
      context.open()
    }
  }

  CustomShortcut {
    name: "screenshotFreeze"
    description: "Open screenshot tool (freeze mode)"
    onPressed: {
      context.openFreeze()
    }
  }
}
