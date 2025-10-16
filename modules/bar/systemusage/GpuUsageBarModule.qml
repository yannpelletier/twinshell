import QtQuick
import "root:/config"
import "root:/services"

Loader {
  active: SystemUsage.gpuType !== "NONE"

  sourceComponent: Resource {
    icon: "developer_board"
    value: SystemUsage.gpuPerc
    colour: Config.color.surfaceTint

    Component.onCompleted: {
      SystemUsage.refCount++;
    }

    Component.onDestruction: {
      SystemUsage.refCount--;
    }
  }
}
