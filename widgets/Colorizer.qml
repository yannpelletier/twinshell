import QtQuick
import QtQuick.Effects
import "root:/config"

MultiEffect {
  colorization: 1

  Behavior on colorizationColor {
    ColorAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }
}
