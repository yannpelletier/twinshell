import QtQuick
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row

    spacing: Config.spacing.small

    MaterialIcon {
      text: "keyboard"
      color: Config.color.backgroundContent
      font.pointSize: Config.font.size.large
    }

    StyledText {
      text: Hyprland.keyboardLayout
      color: Config.color.backgroundContent
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    acceptedButtons: Qt.NoButton 
    hoverEnabled: false 
    scrollGestureEnabled: true 
  }
}

