import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import "root:/config"
import "root:/widgets"
import "root:/services"

Image {
  id: root

  required property LockscreenContext context
  property var date: new Date()

  source: Wallpapers.current
  Layout.fillWidth: true
  Layout.fillHeight: true
  fillMode: Image.PreserveAspectFit
  asynchronous: true
  cache: true

  opacity: 0
  
  Timer {
    running: true
    repeat: true
    interval: 1000

    onTriggered: root.date = new Date();
  }

  NumberAnimation {
    id: fadeInAnimation
    target: root
    property: "opacity"
    to: 1
    duration: 1000
  }

  Component.onCompleted: fadeInAnimation.start()

  Rectangle {
    anchors.fill: parent
    color: Config.color.background
    opacity: Config.transparency.base
  }

  ColumnLayout {
    visible: Window.active

    anchors {
      horizontalCenter: parent.horizontalCenter
      top: parent.verticalCenter
    }

    StyledText {
      anchors.horizontalCenter: parent.horizontalCenter

      color: Config.color.backgroundContent
      font.pointSize: Config.font.size.normal
      font.family: Config.font.family.mono

      // updated when the date changes
      text: {
        return Qt.formatDateTime(root.date, "dddd dd MMMM yyyy");
      }
    }

    StyledText {
      anchors.horizontalCenter: parent.horizontalCenter

      color: Config.color.backgroundContent
      font.pointSize: 80
      font.family: Config.font.family.mono

      // updated when the date changes
      text: Qt.formatDateTime(root.date, "hh:mm");

    }

    StyledTextField {
      id: passwordBox

      placeholderText: qsTr("Enter Password")
      placeholderTextColor: Config.color.surfaceContent

      background: Rectangle {
        color: root.context.unlockInProgress ? Config.color.surfaceDim : Config.color.surface
        radius: Config.rounding.small
        border {
          color: Config.color.primary
          width: 1
        }
        Behavior on border.color {
          ColorAnimation {
            duration: 200
          }
        }
      }

      implicitWidth: 400
      topPadding: 10
      bottomPadding: 10
      leftPadding: 35
      rightPadding: 10

      focus: true
      enabled: !root.context.unlockInProgress
      echoMode: TextInput.Password
      inputMethodHints: Qt.ImhSensitiveData

      onTextChanged: root.context.currentText = this.text;

      onAccepted: root.context.tryUnlock();

      MaterialIcon {
        anchors {
          left: parent.left
          leftMargin: 8
          verticalCenter: parent.verticalCenter
        }

        text: "lock"
        color: Config.color.surfaceContent
        opacity: root.activeFocus ? 1.0 : 0.7

        Behavior on opacity {
          NumberAnimation {
            duration: 200
          }
        }
      }

      Connections {
        target: root.context

        function onCurrentTextChanged() {
          passwordBox.text = root.context.currentText;
        }
      }
    }

    Label {
      anchors.horizontalCenter: parent.horizontalCenter

      visible: root.context.showFailure
      text: "Incorrect password"
      color: Config.color.error
    }
  }
}
