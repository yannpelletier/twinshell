import QtQuick
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  MaterialIcon {
    id: icon

    text: Icons.getNetworkIcon(Network.active?.strength ?? 0, false)
    color: Config.color.backgroundContent;
    font.pointSize: Config.font.size.large
  }
}
