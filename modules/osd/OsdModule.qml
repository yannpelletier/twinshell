import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import "root:/utils" 
import "root:/widgets"
import "root:/config"

StyledRect {
  id: root

  visible: false

  required property string icon
  required property string label
  required property variant value
  property real hideDelay: Config.osd.hideDelay
  property color iconColor: Config.color.backgroundContent
  property color backgroundColor: Config.color.background
  property color borderColor: Config.color.backgroundContent
  property real borderWidth: 2
  property variant onValueChange

  property bool initialized: false


  function show() {
    if (initialized) {
      root.visible = true;
    }
    timer.restart();
  }

  width: 425
  height: 425
  color: backgroundColor
  radius: Config.border.rounding
  opacity: Config.transparency.base
  border.color: borderColor
  border.width: borderWidth

  Timer {
    id: timer

    interval: hideDelay
    running: true
    onTriggered: {
      root.visible = false;
      initialized = true;
    }
  }


  ColumnLayout {
    anchors.centerIn: parent
    spacing: Config.spacing.small

    MaterialIcon {
      text: icon
      color: iconColor
      font.pointSize: 175
      Layout.alignment: Qt.AlignCenter
    }

    StyledText {
      text: label
      font.bold: true
      font.pointSize: Config.font.size.extraLarge
      Layout.alignment: Qt.AlignHCenter
    }

    Loader {
      readonly property Component slider: Slider {
        id: slider
        orientation: Qt.Horizontal
        from: 0
        to: 1
        stepSize: 0.05

        Binding {
          target: slider
          property: "value"
          value: root.value
          restoreMode: Binding.RestoreBinding
        }

        onValueChanged: {
          if (root.onValueChange) {
            root.onValueChange(slider.value)
          }
        }

        handle: Rectangle {
          x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
          y: slider.topPadding + slider.availableHeight / 2 - height / 2
          width: 20
          height: 20
          radius: Config.rounding.full
          color: Config.color.surfaceContent
        }

        background: Rectangle {
          x: slider.leftPadding
          y: slider.topPadding + slider.availableHeight / 2 - height / 2
          implicitWidth: slider.availableWidth
          implicitHeight: 12
          radius: Config.rounding.small
          color: "transparent"

          Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            color: root.value > 1.0 ? Config.color.error : Config.color.primary
            radius: parent.radius
          }

          MouseArea {
            anchors.fill: parent
            onClicked: (mouse) => {
              slider.value = slider.from + (mouse.x / width) * (slider.to - slider.from)
            }
            onPressed: (mouse) => {
              slider.value = slider.from + (mouse.x / width) * (slider.to - slider.from)
              slider.pressed = true
            }
            onReleased: {
              slider.pressed = false
            }
          }
        }
      }

      readonly property Component text: Item {
        implicitWidth: styledText.implicitWidth
        implicitHeight: styledText.implicitHeight

        StyledText {
          id: styledText
          text: root.value // Use root.value directly
          font.pointSize: Config.font.size.large
          anchors.centerIn: parent // Center within the Item
        }
      }

      sourceComponent: typeof value === "number" ? slider : text
      Layout.alignment: Qt.AlignHCenter
      Layout.fillWidth: true
    }
  }
}
