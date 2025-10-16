import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/modules/bar"

Scope {
  required property BarContext context

  CustomShortcut {
    name: "toggleBar"
    description: "Toggle the bar"
    onPressed: {
      context.visible = !context.visible
    }
  }

  IpcHandler {
    target: "bar"

    function setVilibility(value: bool): void {
      context.visible = value
    }

    function toggle(): void {
      context.visible = !context.visible
    }
  }
}
