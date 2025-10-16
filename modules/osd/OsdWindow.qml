import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"

StyledWindow {
  id: root

  name: "osd"
  default property alias modules: row.children
  WlrLayershell.layer: WlrLayer.Overlay

  color: "transparent"
  focusable: false
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row
  }
}
