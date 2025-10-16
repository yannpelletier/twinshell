import QtQuick
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  readonly property real speakerVolume: Audio.defaultSpeaker?.audio?.volume ?? 0
  readonly property bool speakerMuted: Audio.defaultSpeaker?.audio?.muted ?? false
  property int roundedVolume: Math.round(speakerVolume * 100)

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row

    spacing: Config.spacing.small

    MaterialIcon {
      text: Icons.getSpeakerIcon(roundedVolume, speakerMuted)
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
        Audio.shiftVolume(Audio.defaultSpeaker, 0.05);
      } else if (wheel.angleDelta.y < 0) {
        Audio.shiftVolume(Audio.defaultSpeaker, -0.05);
      }
    }


  }
}
