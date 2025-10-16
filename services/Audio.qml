pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
  id: root

  property real minVolume: 0.0;
  property real maxVolume: 1.5;

  readonly property PwNode defaultSpeaker: Pipewire.defaultAudioSink
  readonly property PwNode defaultMicrophone: Pipewire.defaultAudioSource
  readonly property list<PwNode> devices: Pipewire.nodes.values.filter((n) => {
    const type = PwNodeType.toString(n.type);
    return n.audio && (type === "AudioSink" || type === "AudioSource");
  }).sort((a, b) => {
    return b.type - a.type
  })

  function setDefaultSpeaker(node: PwNode) {
    Pipewire.preferredDefaultAudioSink = node;
  }

  function setDefaultMicrophone(node: PwNode) {
    Pipewire.preferredDefaultAudioSource = node;
  }

  function setVolume(node: PwNode, volume: real) {
    if (node?.ready && node?.audio) {
      node.audio.muted = false;
      node.audio.volume = Math.max(minVolume, Math.min(maxVolume, volume))
    }
  }

  function shiftVolume(node: PwNode, amount: real) {
    if (node?.ready && node?.audio) {
      node.audio.muted = false;
      node.audio.volume = Math.max(minVolume, Math.min(maxVolume, node.audio.volume + amount))
    }
  }

  function setMuted(node: PwNode, muted: bool) {
    if (node?.ready && node?.audio) {
      node.audio.muted = muted
    }
  }

  function toggleMuted(node: PwNode) {
    if (node?.ready && node?.audio) {
      node.audio.muted = !node.audio.muted
    }
  }

  // Function to play a sound given a file path
  function play(soundPath: string) {
    let absolutePath = Qt.resolvedUrl(soundPath).toString()
    if (absolutePath.startsWith("file://")) {
      absolutePath = absolutePath.substring(7) // Remove file://
    }

    if (soundPath) {
      playAudio.command = ["pw-play", absolutePath]
      playAudio.startDetached();
    } else {
      console.log("Error: No sound path provided")
    }
  }

 Process {
    id: playAudio 
    command: ["pw-play"]
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }
}
