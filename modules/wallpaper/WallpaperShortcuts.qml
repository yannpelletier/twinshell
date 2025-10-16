import Quickshell
import Quickshell.Io
import QtQuick
import "root:/widgets"
import "root:/services"

Scope {
  IpcHandler {
    target: "wallpaper"

    function get(): string {
      return Wallpapers.actualCurrent;
    }

    function set(path: string): void {
      Wallpapers.setWallpaper(path);
    }

    function list(): string {
      return Wallpapers.list.map(w => w.path).join("\n");
    }
  }

}
