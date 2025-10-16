import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import "root:/utils"
import "root:/widgets"
import "root:/config"
import "root:/services"

StyledWindow {
  id: root
  name: "bar"
  required property BarContext context
  property alias startModules: startSection.children
  property alias centerModules: centerSection.children
  property alias endModules: endSection.children

  HyprlandWindow.opacity: Config.transparency.base 
  implicitHeight: context.visible ? Config.bar.sizes.innerHeight : 0;

  anchors {
    top: true
    left: true
    right: true
  }

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin: Config.padding.large
    anchors.rightMargin: Config.padding.large
    spacing: Config.spacing.large

    RowLayout {
      id: startSection

      property ShellScreen screen: root.screen

      spacing: Config.spacing.larger
      Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
      Layout.preferredWidth: implicitWidth 
    }

    Item {
      Layout.fillWidth: true 
    }

    RowLayout {
      id: endSection

      property ShellScreen screen: root.screen

      spacing: Config.spacing.larger
      Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
      Layout.preferredWidth: implicitWidth // Size based on content
    }
  }

  RowLayout {
    id: centerSection

    property ShellScreen screen: root.screen

    spacing: Config.spacing.larger
    anchors.centerIn: parent 
    z: 1 
    Layout.preferredWidth: implicitWidth 
  }
}
