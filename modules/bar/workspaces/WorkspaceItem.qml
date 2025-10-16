import "root:/widgets"
import "root:/services"
import "root:/utils"
import "root:/config"
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  required property int index
  required property bool isFocused
  required property bool hasWindows

  implicitWidth: Config.spacing.large
  implicitHeight: Config.spacing.large

  StyledRect {
    id: rect
    color: isFocused ? Config.color.primary : Config.color.backgroundContent
    radius: Config.rounding.full

    implicitWidth: hasWindows ? Config.padding.large : Config.padding.normal
    implicitHeight: hasWindows ? Config.padding.large : Config.padding.normal

    anchors.centerIn: parent
    opacity: isFocused ? 1.0 : 0.7 // Subtle opacity change for focus

    // Smooth color transition
    Behavior on color {
      ColorAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    // Smooth opacity transition
    Behavior on opacity {
      NumberAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    // Smooth size transitions
    Behavior on implicitWidth {
      NumberAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    Behavior on implicitHeight {
      NumberAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    // Optional scale animation on focus
    scale: isFocused ? 1.1 : 1.0
    Behavior on scale {
      NumberAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }
  }
}
