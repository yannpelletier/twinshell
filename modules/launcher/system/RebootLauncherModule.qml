import QtQuick
import Quickshell.Io
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      name: "Reboot"
      icon: "restart_alt"
      description: "Restart the system"
      keyword: "reboot"

      readonly property var process: Process {
        command: ["sh", "-c", "systemctl reboot"]
      }

      execute: () => {
        process.startDetached()
        Qt.quit()
      }
    },
  ]
}
