import QtQuick
import Quickshell.Io
import "root:/services"
import "root:/modules/lockscreen"
import "../"

LauncherModule {
  id: root

  commands: [
    LauncherCommand {
      name: "Lock"
      icon: "lock"
      description: "Launch the screen locker"
      keyword: "lock"

      readonly property var process: Process {
        command: ["sh", "-c", "loginctl lock-session"]
      }

      execute: (launcherState) => {
        process.startDetached()
        launcherState.search = "";
        launcherState.visible = false;
      }
    }
  ]
}
