import QtQuick
import Quickshell
import "root:/utils"
import "root:/config"
import "root:/services"
import "../"

OsdModule {
  id: root

  readonly property real speakerVolume: Audio.defaultSpeaker?.audio?.volume ?? 0
  readonly property bool speakerMuted: Audio.defaultSpeaker?.audio?.muted ?? false

  icon: Icons.getSpeakerIcon(Math.round(speakerVolume * 100), speakerMuted)
  label: "Speaker Volume"
  value: speakerVolume
  onValueChange: (value) => {
    Audio.setVolume(Audio.defaultSpeaker, value)
  }

  Connections {
    target: root

    function onSpeakerMutedChanged(): void {
      root.show();
    }

    function onSpeakerVolumeChanged(): void {
      root.show();
    }
  }
}
