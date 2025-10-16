import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import "root:/config"
import "root:/services"

ListView {
  id: root

  required property list<var> notifs

  model: ScriptModel {
    values: notifs
  }

  anchors {
    fill: parent

    right: parent.right
    top: parent.top
  }
  implicitHeight: children.reduce((h, c) => h + c.height, 0)

  orientation: Qt.Vertical
  spacing: 8
  cacheBuffer: QsWindow.window?.screen.height ?? 0

  component Anim: NumberAnimation {
    duration: Config.animation.durations.expressiveFastSpatial
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Config.animation.curves.expressiveFastSpatial
  }

  delegate: Item {
    id: wrapper

    required property Notifs.Notif modelData
    readonly property alias nonAnimHeight: notif.nonAnimHeight

    implicitWidth: notif.implicitWidth
    implicitHeight: notif.implicitHeight

    ListView.onRemove: removeAnim.start()

    SequentialAnimation {
      id: removeAnim

      PropertyAction {
        target: wrapper
        property: "ListView.delayRemove"
        value: true
      }

      PropertyAction {
        target: wrapper
        property: "enabled"
        value: false
      }

      PropertyAction {
        target: wrapper
        property: "implicitHeight"
        value: 0
      }

      PropertyAction {
          target: wrapper
          property: "z"
          value: 1
      }

      Anim {
        target: notif
        property: "x"
        to: (notif.x >= 0 ? Config.notifs.sizes.width : -Config.notifs.sizes.width) * 2
        duration: Config.animation.durations.normal
        easing.bezierCurve: Config.animation.curves.emphasized
      }

      PropertyAction {
        target: wrapper
        property: "ListView.delayRemove"
        value: false
      }
    }

    ClippingRectangle {
      anchors.top: parent.top

      color: "transparent"
      radius: notif.radius
      implicitWidth: notif.implicitWidth
      implicitHeight: notif.implicitHeight

      NotificationItem {
        id: notif
        modelData: wrapper.modelData
      }
    }
  }

  move: Transition {
    Anim {
      property: "y"
    }
  }

  displaced: Transition {
    Anim {
      property: "y"
    }
  }
}
