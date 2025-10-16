import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  property int maxTextWidth: 300
  property Toplevel activeToplevel: Hyprland.isWorkspaceOccupied(Hyprland.focusedWorkspaceId) ? Hyprland.activeToplevel : null

  implicitWidth: column.implicitWidth 
  implicitHeight: column.implicitHeight 

  ColumnLayout {
    id: column
    anchors.centerIn: parent 
    spacing: 0

    RowLayout {
      spacing: Config.spacing.small
      Layout.alignment: Qt.AlignHCenter 

      IconImage {
        id: icon
        visible: !!activeToplevel
        source: Icons.getAppIcon(activeToplevel?.appId, "image-missing")
        implicitWidth: Config.iconSize || 16
        implicitHeight: Config.iconSize || 16
        Layout.alignment: Qt.AlignVCenter 
      }

      StyledText {
        text: activeToplevel?.appId || "Desktop"
        font.bold: true
        Layout.maximumWidth: root.maxTextWidth
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
      }
    }

    StyledText {
        text: activeToplevel?.title || `Workspace ${Hyprland.focusedWorkspaceId}`
        Layout.maximumWidth: root.maxTextWidth
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
    }
  }
}
