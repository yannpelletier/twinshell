import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"
import "root:/widgets"
import "root:/services"


Scope {
  CustomShortcut {
    name: "increaseSpeakerVolume"
    description: "Increase volume of default speaker"
    onPressed: {
      Audio.shiftVolume(Audio.defaultSpeaker, 0.1);
    }
  }

  CustomShortcut {
    name: "decreaseSpeakerVolume"
    description: "Decrease volume of default speaker"
    onPressed: {
      Audio.shiftVolume(Audio.defaultSpeaker, -0.1);
    }
  }

  CustomShortcut {
    name: "toggleSpeakerMuted"
    description: "Toggle the muted state of the default speaker"
    onPressed: {
      Audio.toggleMuted(Audio.defaultSpeaker);
    }
  }

  IpcHandler {
    target: "speaker"

    function setVolume(volume: real): void {
      Audio.setVolume(Audio.defaultSpeaker, volume);
    }

    function increaseVolume(): void {
      Audio.shiftVolume(Audio.defaultSpeaker, 0.1);
      Audio.play(Config.paths.soundCheck)
    }

    function decreaseVolume(): void {
      Audio.shiftVolume(Audio.defaultSpeaker, -0.1);
      Audio.play(Config.paths.soundCheck)
    }

    function toggleMuted(): void {
      Audio.toggleMuted(Audio.defaultSpeaker);
      Audio.play(Config.paths.soundCheck)
    }
  }
}
