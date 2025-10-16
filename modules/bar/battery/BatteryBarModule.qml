import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import "root:/utils"
import "root:/config"
import "root:/widgets"
import "../"

BarModule {
  id: root

  property int roundedBattery: Math.round(UPower.displayDevice.percentage * 100)

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight
  visible: roundedBattery > 0

  function getChargeColor(percentage: int, charging: bool): color {
    const chargeColors = {
      charging: [
        { min: 85, color: Config.color.success },
        { min: 20, color: Config.color.backgroundContent },
        { min: 0, color: Config.color.error }
      ],
      nonCharging: [
        { min: 20, color: Config.color.backgroundContent },
        { min: 0, color: Config.color.error }
      ]
    };

    const colorSet = charging ? chargeColors.charging : chargeColors.nonCharging;
    return colorSet.find(level => percentage >= level.min).color;
  }

  RowLayout {
    id: row

    anchors.fill: parent
    spacing: Config.spacing.small

    MaterialIcon {
      text: Icons.getBatteryIcon(roundedBattery, !UPower.onBattery)
      font.pointSize: Config.font.size.large
      color: getChargeColor(roundedBattery, !UPower.onBattery);
      width: Config.font.size.normal + Config.padding.small * 2
    }

    StyledText {
      text: `${roundedBattery}%`
      color: getChargeColor(roundedBattery, !UPower.onBattery);
      width: Config.font.size.normal + Config.padding.small * 2
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    acceptedButtons: Qt.NoButton 
    hoverEnabled: false 
    scrollGestureEnabled: true 

  }
}
