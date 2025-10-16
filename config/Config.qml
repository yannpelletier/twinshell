pragma Singleton

import "root:/utils"
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property alias color: adapter.color
  property alias transparency: adapter.transparency
  property alias spacing: adapter.spacing
  property alias padding: adapter.padding
  property alias rounding: adapter.rounding
  property alias font: adapter.font
  property alias animation: adapter.animation
  property alias bar: adapter.bar
  property alias border: adapter.border
  property alias launcher: adapter.launcher
  property alias notifs: adapter.notifs
  property alias osd: adapter.osd
  property alias paths: adapter.paths

  FileView {
    path: `${Paths.config}/shell.json`
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter

      property JsonObject color: ColorConfig {}
      property JsonObject transparency: TransparencyConfig {}
      property JsonObject spacing: SpacingConfig {}
      property JsonObject padding: PaddingConfig {}
      property JsonObject rounding: RoundingConfig {}
      property JsonObject font: FontConfig {}
      property JsonObject animation: AnimationConfig {}
      property JsonObject bar: BarConfig {}
      property JsonObject border: BorderConfig {}
      property JsonObject launcher: LauncherConfig {}
      property JsonObject notifs: NotifsConfig {}
      property JsonObject osd: OsdConfig {}
      property JsonObject paths: UserPaths {}
    }
  }
}
