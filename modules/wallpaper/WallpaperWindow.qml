pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Dialogs
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"

StyledWindow {
  id: root

  name: "wallpaper"
  property Image current: one
  property string source: Wallpapers.current
  function selectWallpaper(): void {
    // empty
  }
  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore

  color: "black"
  anchors.top: true
  anchors.bottom: true
  anchors.left: true
  anchors.right: true

  onSourceChanged: {
    if (!source)
      current = null;
    else if (current === one)
      two.update();
    else
      one.update();
  }


  Loader {
    anchors.fill: parent

    active: !root.source
    asynchronous: true

    sourceComponent: StyledRect {
      color: Config.color.surfaceContainer

      Row {
        anchors.centerIn: parent
        spacing: Config.spacing.large

        MaterialIcon {
          text: "sentiment_stressed"
          color: Config.color.surfaceVariantContent
          font.pointSize: Config.font.size.extraLarge * 5
        }

        Column {
          anchors.verticalCenter: parent.verticalCenter
          spacing: Config.spacing.small

          StyledText {
            text: qsTr("Wallpaper missing?")
            color: Config.color.surfaceVariantContent
            font.pointSize: Config.font.size.extraLarge * 2
            font.bold: true
          }

          StyledRect {
            implicitWidth: selectWallText.implicitWidth + Config.padding.large * 2
            implicitHeight: selectWallText.implicitHeight + Config.padding.small * 2

            radius: Config.rounding.full
            color: Config.color.primary

            StateLayer {
              radius: parent.radius
              color: Config.color.primaryContent

              function onClicked(): void {
                root.selectWallpaper()
              }
            }

            StyledText {
              id: selectWallText

              anchors.centerIn: parent

              text: qsTr("Set it now!")
              color: Config.color.primaryContent
              font.pointSize: Config.font.size.large
            }
          }
        }
      }
    }

    Img {
      id: one
    }

    Img {
      id: two
    }

    component Img: CachingImage {
      id: img

      function update(): void {
        if (path === root.source)
          root.current = this;
        else
          path = root.source;
      }

      anchors.fill: parent

      opacity: 0
      scale: Wallpapers.showPreview ? 1 : 0.8

      onStatusChanged: {
        if (status === Image.Ready)
          root.current = this;
      }

      states: State {
        name: "visible"
        when: root.current === img

        PropertyChanges {
          img.opacity: 1
          img.scale: 1
        }
      }

      transitions: Transition {
        NumberAnimation {
          target: img
          properties: "opacity,scale"
          duration: Config.animation.durations.normal
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Config.animation.curves.standard
        }
      }
    }
  }
}
