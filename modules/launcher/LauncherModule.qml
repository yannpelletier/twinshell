import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

QtObject {
  function query(search: string): list<var> {
    return []
  }
  property list<LauncherCommand> commands: []
}
