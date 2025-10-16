import QtQuick
import Quickshell.Io
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      name: "Suspend"
      icon: "bedtime"
      description: "Put the system to sleep"
      keyword: "suspend"

      readonly property var process: Process {
        command: ["sh", "-c", "systemctl suspend"]
      }

      execute: () => {
        process.startDetached()
      }
    },
  ]
}
