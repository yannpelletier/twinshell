import QtQuick
import "root:/config"
import "root:/services"

Resource {
  icon: "memory_alt"
  value: SystemUsage.memPerc
  colour: Config.color.secondary

  Component.onCompleted: {
    SystemUsage.refCount++;
  }
  
  Component.onDestruction: {
    SystemUsage.refCount--;
  }
}
