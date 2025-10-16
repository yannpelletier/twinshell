import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"

ListView {
  id: root

  required property LauncherContext context
  property list<var> results: []

  property var onPressed: (event) => {
    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
      if (root.currentIndex >= 0) {
        const selectedItem = root.model[root.currentIndex]
        selectedItem.execute?.(root.context)
        event.accepted = true
      }
    }

    if (event.key === Qt.Key_Up || (event.key === Qt.Key_K && event.modifiers & Qt.ControlModifier)) {
      root.decrementCurrentIndex()
      event.accepted = true
    } else if (event.key === Qt.Key_Down || (event.key === Qt.Key_J && event.modifiers & Qt.ControlModifier)) {
      root.incrementCurrentIndex()
      event.accepted = true
    }  
  }

  model: results
  spacing: Config.spacing.small
  implicitWidth: Config.launcher.sizes.itemWidth
  implicitHeight: {
    let height = 0
    for (let i = 0; i < Math.min(model.length, Config.launcher.maxShown); i++) {
      height += Config.launcher.sizes.itemHeight + spacing
    }
    return height
  }
  clip: true

  component Anim: NumberAnimation {
    duration: Config.animation.durations.expressiveFastSpatial
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Config.animation.curves.expressiveFastSpatial
  }

  delegate: StyledRect {
    id: wrapper
    required property var modelData
    required property int index
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
        rightMargin: Config.spacing.normal
        verticalCenter: parent.verticalCenter
      }
      spacing: Config.spacing.normal

      Loader {
        readonly property Component appIcon: IconImage {
          id: icon
          source: Icons.getAppIcon(modelData.icon.value, "application-x-executable")
          width: Config.launcher.sizes.iconSize
          height: Config.launcher.sizes.iconSize
        }
        readonly property Component materialIcon: MaterialIcon {
          id: icon
          text: modelData.icon?.value || modelData.icon || "image"
          font.pointSize: Config.launcher.sizes.iconSize
        }
        sourceComponent: modelData.icon?.type === "app" ? appIcon : materialIcon
      }

      ColumnLayout {
        Text {
          text: modelData.name || "No name"
          color: Config.color.backgroundContent
        }
        Text {
          text: modelData.description || ""
          color: Config.color.surfaceContent
          font.pointSize: 8
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
