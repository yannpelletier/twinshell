import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects
import "root:/config"
import "root:/widgets"

import "root:/modules/bar"

StyledWindow {
  id: root

  name: "border"
  required property BarWindow bar

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  HyprlandWindow.opacity: Config.transparency.base 

  mask: Region { item: container; intersection: Intersection.Xor }

  anchors {
    top: true
    left: true
    bottom: true
    right: true
  }

  Item {
    id: container 
    anchors.fill: parent

    StyledRect {
      anchors.fill: parent

      color: Config.color.background

      layer.enabled: true
      layer.effect: MultiEffect {
        maskSource: mask
        maskEnabled: true
        maskInverted: true
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
      }
    }
    
    Item {
      id: mask

      anchors.fill: parent
      layer.enabled: true
      visible: false

      Rectangle {
        anchors.fill: parent
        anchors.margins: Config.border.thickness
        anchors.topMargin: bar.implicitHeight + Config.border.thickness
        radius: Config.border.rounding
      }
    }
  }
}
