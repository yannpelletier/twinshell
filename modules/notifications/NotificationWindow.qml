import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"

import "root:/modules/bar"

StyledWindow {
  id: root

  name: "notifications"
  required property BarWindow bar
  WlrLayershell.layer: WlrLayer.Top
  exclusionMode: ExclusionMode.Ignore
  anchors {
    top: true
    right: true
    bottom: true
  }

  mask: Region {
    item: list
  }

  implicitWidth: container.implicitWidth
  color: "transparent"

  MergedEdgeRect {
    id: container

    cornerRadius: 25
    color: Config.color.background
    implicitWidth: Config.notifs.sizes.width + cornerRadius * 3
    implicitHeight: list.count > 0 ? Math.min(screen?.height ?? 0, list.implicitHeight + container.cornerRadius * 2) : 0;

    anchors {
      fill: parent

      right: parent.right
      top: parent.top
      topMargin: bar.implicitHeight + Config.border.thickness
      // rightMargin: Config.border.thickness
    }

    Behavior on implicitHeight {
      NumberAnimation {
        duration: Config.animation.durations.expressiveFastSpatial
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.expressiveFastSpatial
      }
    }

    NotificationsList {
      id: list

      notifs: [...Notifs.popups].reverse()
    }
  }
}
