import QtQuick
import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import "root:/config"
import "root:/widgets"

StyledTextField {
  id: root

  required property LauncherContext context

  focus: true
  text: root.context.search
  placeholderText: qsTr("Type \"%1\" for commands").arg(Config.launcher.actionPrefix)
  placeholderTextColor: Config.color.surfaceContent
  background: Rectangle {
    color: Config.color.surface
    radius: Config.rounding.small
    border {
      color: root.activeFocus ? Config.color.primary : Config.color.background
      width: 1
    }
    Behavior on border.color {
      ColorAnimation {
        duration: 200
      }
    }
  }

  anchors {
    left: parent.left
    right: parent.right
    bottom: parent.bottom
  }

  topPadding: 10
  bottomPadding: 10
  leftPadding: 35
  rightPadding: 10

  onTextChanged: {
    root.context.search = text
  }

  MaterialIcon {
    id: searchIcon

    anchors {
      left: parent.left
      leftMargin: 8
      verticalCenter: parent.verticalCenter
    }

    text: "search" // Search icon (Unicode for Material Icons)
    color: Config.color.surfaceContent
    opacity: root.activeFocus ? 1.0 : 0.7

    Behavior on opacity {
      NumberAnimation {
        duration: 200
      }
    }
  }

  MaterialIcon {
    id: clearIcon

    anchors {
      right: parent.right
      rightMargin: 8
      verticalCenter: parent.verticalCenter
    }

    text: "close"
    color: Config.color.surfaceContent
    opacity: root.text.length > 0 ? 1.0 : 0.5
    visible: root.text.length > 0

    Behavior on opacity {
      NumberAnimation {
        duration: 200
      }
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        root.context.search = ""
        root.forceActiveFocus()
      }
    }
  }
}
