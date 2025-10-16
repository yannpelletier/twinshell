import Quickshell
import QtQuick
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  readonly property Brightness.Monitor monitor: Brightness.getMonitorForScreen(parent.screen)
  property int roundedBrightness: Math.round(monitor?.brightness * 100 || 0)

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight
  visible: roundedBrightness > 0

  RowLayout {
    id: row

    spacing: Config.spacing.small

    MaterialIcon {
      text: Icons.getBrightnessIcon(roundedBrightness)
      font.pointSize: Config.font.size.large
      color: Config.color.backgroundContent
    }

    StyledText {
      text: `${roundedBrightness}%`
      color: Config.color.backgroundContent
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    acceptedButtons: Qt.NoButton 
    hoverEnabled: false 
    scrollGestureEnabled: true 

    width: row.implicitWidth + Config.padding.small * 2
    height: row.implicitHeight 

    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        root.monitor?.setBrightness(root.monitor?.brightness + 0.05)
      } else if (wheel.angleDelta.y < 0) {
        root.monitor?.setBrightness(root.monitor?.brightness - 0.05)
      }
    }


  }
}
