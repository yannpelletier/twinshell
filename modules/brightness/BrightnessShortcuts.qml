import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

Scope {
  id: root

  CustomShortcut {
    name: "increaseBrightness"
    description: "Increase brightness of focused screen"
    onPressed: {
      Brightness.focusedMonitor?.setBrightness(Brightness.focusedMonitor?.brightness + 0.1)
    }
  }

  CustomShortcut {
    name: "decreaseBrightness"
    description: "Decrease brightness of focused screen"
    onPressed: {
      Brightness.focusedMonitor?.setBrightness(Brightness.focusedMonitor?.brightness - 0.1)
    }
  }

  IpcHandler {
    target: "brightness"

    function set(brightness: real): void {
      Brightness.focusedMonitor?.setBrightness(brightness);
    }

    function increase(): void {
      Brightness.focusedMonitor?.setBrightness(Brightness.focusedMonitor?.brightness + 0.1)
    }

    function decrease(): void {
      Brightness.focusedMonitor?.setBrightness(Brightness.focusedMonitor?.brightness - 0.1)
    }
  }
}
