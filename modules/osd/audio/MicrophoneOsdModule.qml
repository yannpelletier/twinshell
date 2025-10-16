import QtQuick
import Quickshell
import "root:/utils"
import "root:/config"
import "root:/services"
import "../"

OsdModule {
  id: root

  readonly property real microphoneVolume: Audio.defaultMicrophone?.audio?.volume ?? 0
  readonly property bool microphoneMuted: Audio.defaultMicrophone?.audio?.muted ?? false

  icon: Icons.getMicrophoneIcon(microphoneMuted)
  label: "Microphone Volume"
  value: microphoneVolume
  onValueChange: (value) => {
    Audio.setVolume(Audio.defaultMicrophone, value)
  }
  
  Connections {
    target: root

    function onMicrophoneVolumeChanged(): void {
      root.show();
    }

    function onMicrophoneMutedChanged(): void {
      root.show();
    }
  }
}
