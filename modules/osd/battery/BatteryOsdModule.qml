import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "root:/utils"
import "root:/config"
import "root:/services"
import "../"

OsdModule {
  id: root

  property int roundedBattery: Math.round(UPower.displayDevice.percentage * 100)

  property var chargeLevels: ({
    charging: [
      { 
        min: 85,
        label: "Almost Full",
        borderColor: Config.color.successContainerContent,
        iconColor: Config.color.successContainerContent,
        backgroundColor: Config.color.successContainer,
        sound: Config.paths.batteryNotify
      },
      {
        min: 0,
        label: "Charging",
        borderColor: Config.color.backgroundContent,
        iconColor: Config.color.backgroundContent,
        backgroundColor: Config.color.background,
        sound: Config.paths.batteryCharging
      }
    ],
    nonCharging: [
      {
        min: 25,
        label: "Good",
        borderColor: Config.color.backgroundContent,
        iconColor: Config.color.backgroundContent,
        backgroundColor: Config.color.background,
        sound: Config.paths.batteryNotify
      },
      {
        min: 10,
        label: "Low Battery",
        borderColor: Config.color.errorContainerContent,
        iconColor: Config.color.errorContainerContent,
        backgroundColor: Config.color.errorContainer,
        sound: Config.paths.batteryLow
      },
      { 
        min: 0,
        label: "Critical", // Fixed misleading label
        borderColor: Config.color.errorContent,
        iconColor: Config.color.errorContainerContent,
        backgroundColor: Config.color.errorContainer,
        sound: Config.paths.batteryCritical
      }
    ]
  })

  property var chargeLevel: {
    const levels = UPower.onBattery ? chargeLevels.nonCharging : chargeLevels.charging
    return levels.find(level => {
      return roundedBattery >= level.min
    })
  }
  property var lastChargeLevel

  hideDelay: 3000
  icon: Icons.getBatteryIcon(roundedBattery, !UPower.onBattery)
  label: "Battery"
  value: chargeLevel.label
  iconColor: chargeLevel.iconColor
  backgroundColor: chargeLevel.backgroundColor
  borderColor: chargeLevel.borderColor

  property int lastPercent: roundedBattery

  onChargeLevelChanged: {
    if (chargeLevel !== lastChargeLevel) {
      root.show()
      if (root.initialized) {
        Audio.play(chargeLevel.sound)
      }
      lastChargeLevel = chargeLevel
    }
  }
}
