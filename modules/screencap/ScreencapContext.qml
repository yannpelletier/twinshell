import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import "root:/utils"
import "root:/services"
import "root:/modules/areapicker"

AreaPickerContext {
  readonly property Process screencapProcess: Process {}

  property bool recording: screencapProcess.running

  function startRecording(x: real, y: real, width: real, height: real): void {
    if (recording) {
      return;
    }

    console.log()
    const path = Paths.strip(`${Paths.videos}/recording.mp4`)
    screencapProcess.command = ["sh", "-c", `wf-recorder -g '${x},${y} ${width}x${height}' -y --audio=${Audio.defaultMicrophone?.name} --file=${path}`];
    screencapProcess.running = true;
  }

  function stop() {
    screencapProcess.running = false;
  }

  function toggle() {
    if (screencapProcess.running) {
      stop();
    } else {
      open();
    }
  }
}
