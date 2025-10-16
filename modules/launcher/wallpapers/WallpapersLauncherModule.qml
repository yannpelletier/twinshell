import QtQuick
import Quickshell
import "root:/config"
import "root:/services"
import "../"

LauncherModule {
  commands: [
    LauncherCommand {
      id: wallpaperCommand
      name: "Wallpaper"
      icon: "wallpaper"
      description: "Change the current wallpaper"
      keyword: "wallpaper"

      content: WallpapersContent {
        keyword: wallpaperCommand.keyword
      }

      execute: (launcherState) => {
        launcherState.search = `${Config.launcher.actionPrefix}${keyword} `
      }
    }
  ]
}
