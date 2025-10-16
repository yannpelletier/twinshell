import Quickshell
import QtQuick
import QtQuick.Layouts
import "root:/config"
import "root:/widgets"

BarModule {
  id: root

  default property alias content: row.children
  property color color: Config.color.surface

  visible: row.implicitWidth > 2 && row.implicitHeight > 2

  implicitWidth: container.implicitWidth
  implicitHeight: container.implicitHeight

  StyledRect {
    id: container

    implicitWidth: row.implicitWidth + Config.spacing.normal * 2
    implicitHeight: row.implicitHeight + Config.spacing.smaller * 2

    anchors.centerIn: parent

    color: root.color
    radius: Config.rounding.normal

    RowLayout {
      id: row

      anchors.centerIn: parent
      spacing: Config.spacing.normal
    }
  }
}
