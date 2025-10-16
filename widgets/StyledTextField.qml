pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import "root:/config"
import "root:/services"

TextField {
  id: root

  color: Config.color.surfaceContent
  placeholderTextColor: Config.color.outline
  font.family: Config.font.family.sans
  font.pointSize: Config.font.size.smaller

  cursorDelegate: StyledRect {
    id: cursor

    property bool disableBlink

    implicitWidth: 2
    color: Config.color.primary
    radius: Config.rounding.normal
    onXChanged: {
      opacity = 1;
      disableBlink = true;
      enableBlink.start();
    }

    Timer {
      id: enableBlink

      interval: 100
      onTriggered: cursor.disableBlink = false
    }

    Timer {
      running: root.cursorVisible && !cursor.disableBlink
      repeat: true
      interval: 500
      onTriggered: parent.opacity = parent.opacity === 1 ? 0 : 1
    }

    Behavior on opacity {
      NumberAnimation {
        duration: Config.animation.durations.small
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }
  }

  Behavior on color {
    ColorAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }

  Behavior on placeholderTextColor {
    ColorAnimation {
      duration: Config.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }
}
