import QtQuick
import Quickshell

import "root:/modules/bar"
import "root:/modules/launcher"
import "root:/modules/screenshot"
import "root:/modules/screencap"
import "root:/modules/ocr"
import "root:/modules/lockscreen"

ShellRoot {
  id: root

  property BarContext barContext: BarContext {}
  property LauncherContext launcherContext: LauncherContext {}
  property ScreenshotContext screenshotContext: ScreenshotContext {}
  property ScreencapContext screencapContext: ScreencapContext {}
  property OcrContext ocrContext: OcrContext {}
  property LockscreenContext lockscreenContext: LockscreenContext {}

  Variants {
    model: Quickshell.screens

    Layout {
      property var modelData

      screen: modelData
      barContext: root.barContext
      launcherContext: root.launcherContext
      screenshotContext: root.screenshotContext
      screencapContext: root.screencapContext
      ocrContext: root.ocrContext
      lockscreenContext: root.lockscreenContext
    }
  }

  Shortcuts {
    barContext: root.barContext
    launcherContext: root.launcherContext
    screenshotContext: root.screenshotContext
    screencapContext: root.screencapContext
    ocrContext: root.ocrContext
    lockscreenContext: root.lockscreenContext
  }
}
