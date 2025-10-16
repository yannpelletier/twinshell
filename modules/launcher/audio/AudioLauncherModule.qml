import QtQuick
import Quickshell.Io
import "root:/config"
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      id: audioCommand
      name: "Audio Control"
      icon: "speaker"
      description: "Change the audio settings"
      keyword: "audio"

      content: AudioContent {}

      execute: (launcherState) => {
        launcherState.search = `${Config.launcher.actionPrefix}${audioCommand.keyword} `
      }
    }
  ]
}
