import QtQuick
import QtQuick.Layouts
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  RowLayout {
    id: row

    spacing: Config.spacing.small

    MaterialIcon {
      id: icon

      text: "schedule"
      color: Config.color.backgroundContent
      font.pointSize: Config.font.size.large
    }

    StyledText {
      id: text

      text: Time.format("hh:mm")
      color: Config.color.backgroundContent
      font.pointSize: Config.font.size.smaller
      font.family: Config.font.family.mono
    }
  }
}
