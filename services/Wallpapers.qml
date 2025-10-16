pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.platform
import "root:/config"
import "root:/utils/scripts/fuzzysort.js" as Fuzzy
import "root:/utils"

Singleton {
  id: root

  readonly property string currentNamePath: Paths.strip(`${Paths.state}/wallpaper/path.txt`)
  readonly property list<string> extensions: ["jpg", "jpeg", "png", "webp", "tif", "tiff"]

  readonly property list<Wallpaper> list: wallpapers.instances
  property bool showPreview: false
  readonly property string current: showPreview ? previewPath : actualCurrent
  property string previewPath
  property string actualCurrent
  property bool previewColourLock

  readonly property list<var> preppedWalls: list.map(w => ({
    name: Fuzzy.prepare(w.name),
    path: Fuzzy.prepare(w.path),
    wall: w
  }))

  function fuzzyQuery(search: string): var {
    return Fuzzy.go(search, preppedWalls, {
      all: true,
      keys: ["name", "path"],
      scoreFn: r => r[0].score * 0.9 + r[1].score * 0.1
    }).map(r => r.obj.wall);
  }

  function setWallpaper(path: string): void {
    actualCurrent = path;
    wallpaperFile.setText(path);
  }

  function preview(path: string): void {
    previewPath = path;
    showPreview = true;
  }

  function stopPreview(): void {
    showPreview = false;
  }

  reloadableId: "wallpapers"

  FileView {
    id: wallpaperFile
    path: root.currentNamePath
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
      root.actualCurrent = text().trim();
    }
  }

  Process {
    id: getWallsProc

    running: true
    command: ["find", "-L", Paths.expandTilde(Config.paths.wallpaperDir), "-type", "d", "-path", "*/.*", "-prune", "-o", "-not", "-name", ".*", "(", "-type", "f", "-o", "-type", "l", ")", "-print"]
    stdout: StdioCollector {
      onStreamFinished: wallpapers.model = text.trim().split("\n").filter(w => root.extensions.includes(w.slice(w.lastIndexOf(".") + 1))).sort()
    }
  }

  Connections {
    target: Config.paths

    function onWallpaperDirChanged(): void {
      getWallsProc.running = true;
    }
  }

  Variants {
    id: wallpapers

    Wallpaper {}
  }

  component Wallpaper: QtObject {
    required property string modelData
    readonly property string path: modelData
    readonly property string name: Paths.namify(path)
  }
}
