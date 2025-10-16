import QtQuick
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  readonly property real microphoneVolume: Audio.defaultMicrophone?.audio?.volume ?? 0
  readonly property bool microphoneMuted: Audio.defaultMicrophone?.audio?.muted ?? false
  readonly property int roundedVolume: Math.round(microphoneVolume * 100)

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row

    spacing: Config.spacing.small

    MaterialIcon {
      text: Icons.getMicrophoneIcon(microphoneMuted)
      color: Config.color.backgroundContent
      font.pointSize: Config.font.size.large
    }

    StyledText {
      text: `${roundedVolume}%`
      color: Config.color.backgroundContent
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    acceptedButtons: Qt.NoButton 
    hoverEnabled: false 
    scrollGestureEnabled: true 

    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) {
        Audio.shiftVolume(Audio.defaultMicrophone, 0.05);
      } else if (wheel.angleDelta.y < 0) {
        Audio.shiftVolume(Audio.defaultMicrophone, -0.05);
      }
    }
  }
}
