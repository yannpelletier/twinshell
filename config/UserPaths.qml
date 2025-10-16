import Quickshell.Io
import "root:/utils"

JsonObject {
  // property string sessionGif: "root:/assets/kurukuru.gif"
  // property string mediaGif: "root:/assets/bongocat.gif"
  property string wallpaperDir: Paths.strip(`${Paths.pictures}/Wallpapers`)
  property string soundCheck: "root:/assets/sound-check.mp3"
  property string batteryNotify: "root:/assets/battery-notify.mp3"
  property string batteryCharging: "root:/assets/battery-charging.mp3"
  property string batteryCritical: "root:/assets/battery-low.mp3"
  property string batteryLow: "root:/assets/battery-low.mp3"
}
