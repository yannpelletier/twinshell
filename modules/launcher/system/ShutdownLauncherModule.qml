import QtQuick
import Quickshell.Io
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      name: "Shutdown"
      icon: "power_settings_new"
      description: "Power off the system"
      keyword: "shutdown"

      readonly property var process: Process {
        command: ["sh", "-c", "systemctl poweroff"]
      }

      execute: () => {
        process.startDetached()
        Qt.quit()
      }
    }
  ]
}
