import QtQuick
import Quickshell
import "root:/utils"
import "root:/config"
import "root:/services"
import "../"

OsdModule {
  id: root

  property int roundedBrightness: Math.round(Brightness.focusedMonitor?.brightness * 100 || 0)

  icon: Icons.getBrightnessIcon(roundedBrightness)
  label: "Brightness"
  value: Brightness.focusedMonitor?.brightness || 0
  onValueChange: (value) => {
    Brightness.focusedMonitor?.setBrightness(value);
  }


  Connections {
    target: Brightness.focusedMonitor

    function onBrightnessChanged(): void {
      root.show();
    }
  }
}
