import "root:/config"
import QtQuick

Rectangle {
  id: root

  color: "transparent"

  Behavior on color {
    ColorAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }
}
