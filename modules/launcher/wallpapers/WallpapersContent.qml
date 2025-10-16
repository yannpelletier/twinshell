import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Layouts
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

ListView {
  id: root
  property LauncherContext context
  required property string keyword
  property string treatedSearch: {
    let search = context?.search.trim() || ""
    let prefix = Config.launcher.actionPrefix + keyword
    if (search.startsWith(prefix)) {
      return search.substring(prefix.length).trim()
    }
    return search
  }

  property var onPressed: (event) => {
    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
      if (root.currentIndex >= 0) {
        const selectedItem = root.model[root.currentIndex]
        Wallpapers.setWallpaper(selectedItem.path);
        root.context.visible = false
        root.context.search = ""
        event.accepted = true
      }
    }

    if (event.key === Qt.Key_Left || (event.key === Qt.Key_H && event.modifiers & Qt.ControlModifier)) {
      root.decrementCurrentIndex()
      event.accepted = true
    } else if (event.key === Qt.Key_Right || (event.key === Qt.Key_L && event.modifiers & Qt.ControlModifier)) {
      root.incrementCurrentIndex()
      event.accepted = true
    }
  }

  model: Wallpapers.fuzzyQuery(treatedSearch)
  spacing: Config.spacing.small
  orientation: Qt.Horizontal
  implicitWidth: Config.launcher.sizes.wallpaperWidth * Config.launcher.maxWallpapers
  implicitHeight: Config.launcher.sizes.wallpaperHeight + Config.spacing.normal * 2
  clip: true
  cacheBuffer: Config.launcher.sizes.wallpaperWidth * 2
  snapMode: ListView.SnapToItem
  highlightRangeMode: ListView.StrictlyEnforceRange
  preferredHighlightBegin: implicitWidth / 2 - Config.launcher.sizes.wallpaperWidth / 2
  preferredHighlightEnd: implicitWidth / 2 + Config.launcher.sizes.wallpaperWidth / 2

  onCurrentIndexChanged: {
    Wallpapers.preview(root.model[currentIndex].path)
    if (root.context) {
      root.context.forceActive = true
    }
  }

  Component.onDestruction: {
    Wallpapers.stopPreview()
    if (root.context) {
      root.context.forceActive = false
    }
  }

  delegate: StyledRect {
    id: wrapper
    required property var modelData
    required property int index
    implicitWidth: Config.launcher.sizes.wallpaperWidth
    implicitHeight: Config.launcher.sizes.wallpaperHeight
    radius: Config.rounding.normal
    color: ListView.isCurrentItem ? Config.color.surfaceVariant : "transparent"
    anchors {
      leftMargin: 15
      rightMargin: 15
    }

    ColumnLayout {
      anchors {
        fill: parent
        margins: Config.spacing.normal
      }
      spacing: Config.spacing.small

      Image {
        source: modelData.path || ""
        Layout.fillWidth: true
        Layout.fillHeight: true
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        cache: true
      }

      Text {
        text: modelData.name || "No name"
        color: Config.color.backgroundContent
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: Config.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.animation.curves.standard
      }
    }
  }
}
