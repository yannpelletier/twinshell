import Quickshell
import QtQuick
import "root:/config"
import "root:/modules/screencap"

Loader {
  id: root

  required property ScreencapContext context

  active: context.recording

  sourceComponent: Rectangle {
    width: 10
    height: 10
    color: Config.color.error
    radius: Config.rounding.full
  }
}
