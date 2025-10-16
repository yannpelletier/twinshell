import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

Scope {
  CustomShortcut {
    name: "increaseMicrophoneVolume"
    description: "Increase volume of default microphone"
    onPressed: {
      Audio.shiftVolume(Audio.defaultMicrophone, 0.1);
    }
  }

  CustomShortcut {
    name: "decreaseMicrophoneVolume"
    description: "Decrease volume of default microphone"
    onPressed: {
      Audio.shiftVolume(Audio.defaultMicrophone, -0.1);
    }
  }

  CustomShortcut {
    name: "toggleMicrophoneMuted"
    description: "Toggle the muted state of the default microphone"
    onPressed: {
      Audio.toggleMuted(Audio.defaultMicrophone);
    }
  }

  IpcHandler {
    target: "microphone"

    function setVolume(volume: real): void {
      Audio.setVolume(Audio.defaultMicrophone, volume);
    }

    function increaseVolume(): void {
      Audio.shiftVolume(Audio.defaultMicrophone, 0.1);
    }

    function decreaseVolume(): void {
      Audio.shiftVolume(Audio.defaultMicrophone, -0.1);
    }

    function toggleMuted(): void {
      Audio.toggleMuted(Audio.defaultMicrophone);
    }
  }
}
