import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

import "root:/modules/ocr"

Scope {
  id: root

  required property OcrContext context

  IpcHandler {
    target: "ocr"

    function open(): void {
      context.open()
    }

    function openFreeze(): void {
      context.openFreeze()
    }
  }

  CustomShortcut {
    name: "ocr"
    description: "Open ocr tool"
    onPressed: {
      context.open()
    }
  }

  CustomShortcut {
    name: "ocrFreeze"
    description: "Open ocr tool (freeze mode)"
    onPressed: {
      context.openFreeze()
    }
  }
}
