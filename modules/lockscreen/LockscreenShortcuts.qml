import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"

Scope {
  id: root

  required property LockscreenContext context

  IpcHandler {
    target: "lockscreen"

    function open(): void {
      context.locked = true;
    }
  }

  CustomShortcut {
    name: "lockscreen"
    description: "Launch screen lock"
    onPressed: {
      context.locked = true;
    }
  }
}
