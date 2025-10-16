import QtQuick
import Quickshell
import "root:/utils"
import "root:/config"
import "root:/services"
import "../"

OsdModule {
  id: root

  icon: "keyboard"
  label: "Keyboard Layout"
  value: `(${Hyprland.keyboardLayout})`

  Connections {
    target: Hyprland

    function onKeyboardLayoutChanged(): void {
      root.show();
    }
  }
}
