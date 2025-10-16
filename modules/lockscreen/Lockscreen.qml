import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/config"

WlSessionLock {
  id: root

  required property LockscreenContext context

  locked: root.context.locked

  WlSessionLockSurface {
    color: Config.color.background

    LockscreenSurface {
      anchors.fill: parent
      context: root.context
    }
  }
}
