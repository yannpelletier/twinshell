pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  Process {
    id: screencapProcess
  }

  function execute(x: real, y: real, width: real, height: real) {
    screencapProcess.command = ["sh", "-c", `wf-recorder -g '${x},${y} ${width}x${height}'`];
    screencapProcess.running = true;
  }

  function stop() {
    screencapProcess.running = false;
  }
}
