import QtQuick
import "root:/config"
import "root:/services"

Resource {
  icon: "memory"
  value: SystemUsage.cpuPerc
  colour: Config.color.primary

  Component.onCompleted: {
    SystemUsage.refCount++;
  }
  
  Component.onDestruction: {
    SystemUsage.refCount--;
  }
}
