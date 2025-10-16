//
// ███████ ██   ██  ██████  ██████  ████████  ██████ ██    ██ ████████ ███████ 
// ██      ██   ██ ██    ██ ██   ██    ██    ██      ██    ██    ██    ██      
// ███████ ███████ ██    ██ ██████     ██    ██      ██    ██    ██    ███████ 
//      ██ ██   ██ ██    ██ ██   ██    ██    ██      ██    ██    ██         ██ 
// ███████ ██   ██  ██████  ██   ██    ██     ██████  ██████     ██    ███████ 
//

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/modules/bar"
import "root:/modules/launcher"
import "root:/modules/screenshot"
import "root:/modules/screencap"
import "root:/modules/ocr"
import "root:/modules/audio"
import "root:/modules/brightness"
import "root:/modules/wallpaper"
import "root:/modules/lockscreen"

Scope {
  id: root

  required property BarContext barContext
  required property LauncherContext launcherContext
  required property ScreenshotContext screenshotContext
  required property ScreencapContext screencapContext
  required property OcrContext ocrContext
  required property LockscreenContext lockscreenContext

  BarShortcuts {
    context: root.barContext
  }
  LauncherShortcuts {
    context: root.launcherContext
  }
  ScreenshotShortcuts {
    context: root.screenshotContext
  }
  ScreencapShortcuts {
    context: root.screencapContext
  }
  OcrShortcuts {
    context: root.ocrContext
  }
  SpeakerShortcuts {}
  MicrophoneShortcuts {}
  BrightnessShortcuts {}
  WallpaperShortcuts {}
  LockscreenShortcuts {
    context: lockscreenContext
  }
}
