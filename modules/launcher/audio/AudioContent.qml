import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick.Controls
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "root:/modules/launcher"

ListView {
  id: root

  property LauncherContext context

  property var onPressed: (event) => {
    const selectedNode = root.model[root.currentIndex];
    const type = PwNodeType.toString(selectedNode.type);
    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
      if (root.currentIndex >= 0) {
        if (type === "AudioSink") {
          Audio.setDefaultSpeaker(selectedNode);
        } else if (type === "AudioSource") {
          Audio.setDefaultMicrophone(selectedNode);
        }
        event.accepted = true;
      }
    }

    if (event.key === Qt.Key_Up || (event.key === Qt.Key_K && event.modifiers & Qt.ControlModifier)) {
      root.decrementCurrentIndex();
      event.accepted = true;
    } else if (event.key === Qt.Key_Down || (event.key === Qt.Key_J && event.modifiers & Qt.ControlModifier)) {
      root.incrementCurrentIndex();
      event.accepted = true;
    } else if (event.key === Qt.Key_Left || (event.key === Qt.Key_H && event.modifiers & Qt.ControlModifier)) {
      Audio.shiftVolume(selectedNode, -0.05)
      event.accepted = true
    } else if (event.key === Qt.Key_Right || (event.key === Qt.Key_L && event.modifiers & Qt.ControlModifier)) {
      Audio.shiftVolume(selectedNode, 0.05)
      event.accepted = true
    } else if (event.key === Qt.Key_M && event.modifiers & Qt.ControlModifier) {
      Audio.toggleMuted(selectedNode)
    }
  }

  model: Audio.devices
  implicitWidth: Config.launcher.sizes.itemWidth
  implicitHeight: {
    let height = 0
    for (let i = 0; i < Math.min(model.length, Config.launcher.maxShown); i++) {
      height += Config.launcher.sizes.itemHeight
    }
    return height
  }

  component Anim: NumberAnimation {
    duration: Config.animation.durations.expressiveFastSpatial
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Config.animation.curves.expressiveFastSpatial
  }

  onCurrentIndexChanged: {
    if (root.context) {
      root.context.forceActive = true
    }
  }

  Component.onDestruction: {
    if (root.context) {
      root.context.forceActive = false
    }
  }

  delegate: StyledRect {
    id: wrapper

    required property var modelData
    required property int index
    readonly property string name: {
      const suffix = `${modelData.id === Audio.defaultMicrophone?.id || modelData.id === Audio.defaultSpeaker?.id ? "(Default)" : ""}`
      return `${modelData.nickname} ${suffix}`
    }
    readonly property string type: {
      return PwNodeType.toString(modelData.type)
    }
    readonly property string icon: {
      const roundedVolume = Math.round((modelData?.audio?.volume ?? 0) * 100);
      const muted = modelData?.audio?.muted ?? false;
      if (type === "AudioSource") {
        return Icons.getMicrophoneIcon(muted);
      }
      return Icons.getSpeakerIcon(roundedVolume, muted);
    }

    implicitWidth: parent.width
    implicitHeight: Config.launcher.sizes.itemHeight
    radius: Config.rounding.normal
    color: ListView.isCurrentItem ? Config.color.surfaceVariant : "transparent"
    anchors {
      leftMargin: 15
      rightMargin: 15
    }

    Behavior on color {
      ColorAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }

    RowLayout {
      anchors {
        left: parent.left
        leftMargin: Config.spacing.normal
        right: parent.right
        rightMargin: Config.spacing.normal
        verticalCenter: parent.verticalCenter
      }
      spacing: Config.spacing.normal

      MaterialIcon {
        text: wrapper.icon
        font.pointSize: Config.launcher.sizes.iconSize
      }

      ColumnLayout {
        Layout.fillWidth: true
        Text {
          text: wrapper.name
          color: Config.color.backgroundContent
          Layout.fillWidth: true
          elide: Text.ElideRight
        }
        Text {
          text: modelData.description || ""
          color: Config.color.surfaceContent
          font.pointSize: 8
          Layout.fillWidth: true
          elide: Text.ElideRight
        }
      }

      Slider {
        id: slider
        visible: modelData.id === Audio.defaultSpeaker.id || modelData.id === Audio.defaultMicrophone.id
        orientation: Qt.Horizontal
        from: 0
        to: 1
        stepSize: 0.05

        Layout.fillWidth: true
        Layout.preferredWidth: Config.launcher.sizes.sliderWidth || 150
        Layout.minimumWidth: 100
        Layout.maximumWidth: 200
        value: modelData.audio?.volume ?? 0

        onValueChanged: {
          Audio.setVolume(modelData, slider.value)
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
            color: slider.value > 1.0 ? Config.color.error : Config.color.primary
            radius: parent.radius
          }
        }
      }
    }

    // MouseArea {
    //   anchors.fill: parent
    //   hoverEnabled: true
    //   onClicked: {
    //     const selectedItem = root.model[index]
    //     selectedItem.execute?.(root.context)
    //     event.accepted = true
    //   }
    //   onEntered: {
    //     root.currentIndex = index
    //   }
    // }
  }
}
