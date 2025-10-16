import QtQuick
import Quickshell.Services.SystemTray
import "root:/config"
import "../"

BarModule {
  id: root

  readonly property Repeater items: items

  clip: true
  visible: width > 0 && height > 0 // To avoid warnings about being visible with no size

  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  Row {
    id: layout

    spacing: Config.spacing.small

    add: Transition {
      NumberAnimation {
        properties: "scale"
        from: 0
        to: 1
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standardDecel
      }
    }

    move: Transition {
      NumberAnimation {
        properties: "scale"
        to: 1
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standardDecel
      }

      NumberAnimation {
        properties: "x,y"
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    Repeater {
      id: items

      model: SystemTray.items

      TrayItem {}
    }
  }

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.emphasized
    }
  }

  Behavior on implicitHeight {
    NumberAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.emphasized
    }
  }
}
