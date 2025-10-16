import "root:/widgets"
import "root:/services"
import "root:/utils"
import "root:/config"
import "../"

BarModule {
  id: root

  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  StyledText {
    id: icon

    text: Icons.osIcon
    color: Config.color.backgroundContent
    font.pointSize: Config.font.size.large
    font.family: Config.font.family.mono
  }
}
