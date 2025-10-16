import QtQuick
import "root:/config"
import "root:/services"

Resource {
  icon: "hard_disk"
  value: SystemUsage.storagePerc
  colour: Config.color.tertiary

  Component.onCompleted: {
    SystemUsage.refCount++;
  }
  
  Component.onDestruction: {
    SystemUsage.refCount--;
  }
}
