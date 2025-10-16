import Quickshell
import Quickshell.Io
import QtQuick

import "root:/modules/areapicker"

AreaPickerContext {
  readonly property Process screenshotProcess: Process {}

  function screenshot(x: real, y: real, width: real, height: real) {
    screenshotProcess.command = ["sh", "-c", `grim -l 0 -g '${x},${y} ${width}x${height}' - | swappy -f -`];
    screenshotProcess.running = true;
  }
}
