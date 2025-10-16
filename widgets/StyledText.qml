pragma ComponentBehavior: Bound

import "root:/services"
import "root:/config"
import QtQuick

Text {
  id: root

  property bool animate: false
  property string animateProp: "scale"
  property real animateFrom: 0
  property real animateTo: 1
  property int animateDuration: Config.animation.durations.normal

  renderType: Text.NativeRendering
  textFormat: Text.PlainText
  color: Config.color.backgroundContent 
  font.family: Config.font.family.sans
  font.pointSize: Config.font.size.smaller

  Behavior on color {
    ColorAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }

  Behavior on text {
    enabled: root.animate

    SequentialAnimation {
      Anim {
        to: root.animateFrom
        easing.bezierCurve: Config.animation.curves.standardAccel
      }
      PropertyAction {}
      Anim {
        to: root.animateTo
        easing.bezierCurve: Config.animation.curves.standardDecel
      }
    }
  }

  component Anim: NumberAnimation {
    target: root
    property: root.animateProp
    duration: root.animateDuration / 2
    easing.type: Easing.BezierSpline
  }
}
