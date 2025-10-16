import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "root:/utils/scripts/fuzzysort.js" as Fuzzy

StyledWindow {
  id: root
  name: "launcher"
  required property LauncherContext context
  required property list<LauncherModule> modules
  readonly property real padding: Config.padding.normal
  readonly property list<LauncherCommand> commands: modules.reduce((a, m) => {
    return [...a, ...m.commands]
  }, [])
  readonly property list<var> preppedCommands: commands.map(c => {
    return {
      name: Fuzzy.prepare(c.name),
      keyword: Fuzzy.prepare(c.keyword),
      description: Fuzzy.prepare(c.description),
      entry: c
    }
  })
  readonly property var matchedCommand: commands.find(c => {
    return root.context.search.trim().startsWith(`${Config.launcher.actionPrefix}${c.keyword}`)
  }) || null

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.keyboardFocus: context.visible
  // HyprlandWindow.opacity: Config.transparency.base 

  focusable: context.visible

  exclusionMode: ExclusionMode.Ignore
  color: "transparent"
  anchors {
    top: true
    left: true
    right: true
    bottom: true
  }

  function queryItems(search: string): list<var> {
    return modules.reduce((a, m) => [...a, ...m.query(search)], [])
  }

  function queryCommands(search: string): list<var> {
    return Fuzzy.go(search, preppedCommands, {
      all: true,
      keys: ["name", "keyword", "description"],
      scoreFn: r => r[0].score > 0 ? r[0].score * 0.9 + r[1].score * 0.1 : 0
    }).map(r => r.obj.entry)
  }

  component Anim: NumberAnimation {
    duration: 150
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Config.animation.curves.standard
  }

  HyprlandFocusGrab {
    active: context.visible
    windows: [root]
    onCleared: {
      context.visible = false
    }
  }

  mask: Region { 
    item: overlay
    intersection: root.context.visible ? Intersection.Combine : Intersection.Xor
  }

  Rectangle {
    id: overlay
    anchors.fill: parent
    color: "black"
    opacity: root.context.visible ? Config.transparency.layers : 0
    Behavior on opacity {
      Anim {}
    }

    MouseArea {
      anchors.fill: parent
      enabled: root.context.visible
      onClicked: {
        root.context.search = ""
        root.context.visible = false
      }
    }
  }

  MergedEdgeRect {
    id: container
    visible: implicitHeight > 0
    readonly property real spacing: Config.spacing.normal
    implicitWidth: Math.max(Config.launcher.sizes.itemWidth, loader?.item?.implicitWidth ? loader.item.implicitWidth : 0) + container.cornerRadius * 4
    implicitHeight: root.context.visible
      ? searchBar.implicitHeight + (loader.item ? loader.item.implicitHeight : 0) + container.cornerRadius * 2 + Config.spacing.normal
      : 0
    color: Config.color.background
    opacity: Config.transparency.base
    cornerRadius: Config.rounding.large
    anchors {
      bottom: parent.bottom
      horizontalCenter: parent.horizontalCenter
      bottomMargin: Config.border.thickness + 1
    }

    Behavior on implicitWidth { 
      Anim {}
    }

    Behavior on implicitHeight { 
      Anim {}
    }

    Item {
      id: content
      anchors {
        fill: parent
        bottom: parent.bottom
        bottomMargin: Config.spacing.normal + Config.border.thickness
      }

      Loader {
        id: loader
        active: root.context.visible || root.context.forceActive
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          bottom: searchBar.top
          bottomMargin: Config.spacing.normal
        }
        readonly property string trimmedSearch: root.context.search.trim()
        readonly property Component resultsList: LauncherList {
          context: root.context
          results: trimmedSearch.startsWith(Config.launcher.actionPrefix) 
            ? queryCommands(trimmedSearch.substr(1)) 
            : queryItems(trimmedSearch)
        }
        sourceComponent: matchedCommand?.content ? matchedCommand.content : resultsList

        onLoaded: {
          if (!item.context) {
            item.context = root.context
          }
        }
      }

      LauncherSearchBar {
        id: searchBar
        context: root.context
        visible: root.context.visible || root.context.forceActive
        Keys.onPressed: (event) => {
          if (event.key === Qt.Key_Backspace && event.modifiers & Qt.ShiftModifier) {
            root.context.search = ""
            event.accepted = true
            return;
          }  
          loader?.item?.onPressed(event);
        }
      }

      MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        preventStealing: true
      }

      Keys.onEscapePressed: {
        root.context.visible = false
      }

      
    }
  }
}
