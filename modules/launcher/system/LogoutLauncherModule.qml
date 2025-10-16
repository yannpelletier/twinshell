import QtQuick
import Quickshell.Io
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      name: "Logout"
      icon: "logout"
      description: "End the current user session"
      keyword: "logout"

      readonly property var process: Process {
        command: ["sh", "-c", "loginctl terminate-user $USER"]
      }

      execute: () => {
        process.startDetached()
        Qt.quit()
      }
    }
  ]
}
