import QtQuick
import "root:/config"

Rectangle {
  id: root

  implicitWidth: Config.border.thickness 
  implicitHeight: parent.implicitHeight - 6 
  color: Config.color.backgroundContent || "#FFFFFF"

  // Ensure the divider is vertically centered in the parent
  anchors.verticalCenter: parent.verticalCenter
}
