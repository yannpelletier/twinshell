import Quickshell
import Quickshell.Io
import QtQuick

import "root:/modules/areapicker"

AreaPickerContext {
  readonly property Process ocrProcess: Process {
    id: ocrProcess
    stdout: StdioCollector {
      onStreamFinished: {
        Quickshell.clipboardText = text;
        Quickshell.execDetached(["rm", "tmp.png"]);
      }
    }
  }

  function ocr(x: real, y: real, width: real, height: real): void {
    ocrProcess.command = ["sh", "-c", `grim -l 0 -g '${x},${y} ${width}x${height}' tmp.png && tesseract -l eng tmp.png -`];
    ocrProcess.running = true;
  }
}
