import QtQuick
import QtQuick.Shapes
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root
  
  required property string icon
  required property real value
  required property color colour
  property real ringSize: 32
  property int iconSize: Config.font.size.larger
  property real ringThickness: Math.max(2, ringSize / 12)
  
  implicitWidth: ringSize
  implicitHeight: ringSize
  
  // Background ring
  Shape {
    id: backgroundRing
    anchors.fill: parent
    
    ShapePath {
      strokeWidth: root.ringThickness
      strokeColor: Config.color.surfaceBright || "#20FFFFFF"
      fillColor: "transparent"
      
      PathAngleArc {
        centerX: root.width / 2
        centerY: root.height / 2
        radiusX: (root.width - root.ringThickness) / 2
        radiusY: (root.height - root.ringThickness) / 2
        startAngle: 0
        sweepAngle: 360
      }
    }
  }
  
  Shape {
    id: progressRing
    anchors.fill: parent
    
    ShapePath {
      strokeWidth: root.ringThickness
      strokeColor: root.colour
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap
      
      PathAngleArc {
        centerX: root.width / 2
        centerY: root.height / 2
        radiusX: (root.width - root.ringThickness) / 2
        radiusY: (root.height - root.ringThickness) / 2
        startAngle: -90
        sweepAngle: root.value * 360
      }
    }
  }
  
  MaterialIcon {
    id: icon
    anchors.centerIn: parent
    font.pointSize: iconSize
    text: root.icon
    color: root.colour
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
  }
  
  Behavior on value {
    NumberAnimation {
      duration: Config.animation.durations.large
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }
  
  Behavior on ringSize {
    NumberAnimation {
      duration: Config.animation.durations.medium
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.animation.curves.standard
    }
  }
}
