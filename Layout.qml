//
// ██       █████  ██    ██  ██████  ██    ██ ████████ 
// ██      ██   ██  ██  ██  ██    ██ ██    ██    ██    
// ██      ███████   ████   ██    ██ ██    ██    ██    
// ██      ██   ██    ██    ██    ██ ██    ██    ██    
// ███████ ██   ██    ██     ██████   ██████     ██    
//

import Quickshell
import QtQuick
import "root:/config"
import "root:/widgets"
import "root:/services"

import "root:/modules/bar"
import "root:/modules/bar/audio"
import "root:/modules/bar/battery"
import "root:/modules/bar/brightness"
import "root:/modules/bar/clientfocus"
import "root:/modules/bar/datetime"
import "root:/modules/bar/keyboardlayout"
import "root:/modules/bar/network"
import "root:/modules/bar/osicon"
import "root:/modules/bar/systemusage"
import "root:/modules/bar/tray"
import "root:/modules/bar/workspaces"
import "root:/modules/bar/screencap"

import "root:/modules/launcher"
import "root:/modules/launcher/apps"
import "root:/modules/launcher/wallpapers"
import "root:/modules/launcher/audio"
import "root:/modules/launcher/system"

import "root:/modules/osd"
import "root:/modules/osd/battery"
import "root:/modules/osd/brightness"
import "root:/modules/osd/keyboardlayout"
import "root:/modules/osd/audio"

import "root:/modules/screenshot"

import "root:/modules/screencap"

import "root:/modules/ocr"

import "root:/modules/notifications"

import "root:/modules/border"

import "root:/modules/wallpaper"

import "root:/modules/lockscreen"


Scope {
  id: root

  required property ShellScreen screen
  required property BarContext barContext
  required property LauncherContext launcherContext
  required property ScreenshotContext screenshotContext
  required property ScreencapContext screencapContext
  required property OcrContext ocrContext
  required property LockscreenContext lockscreenContext
  
  WallpaperWindow {
    screen: root.screen

    function selectWallpaper() {
      launcherContext.visible = true
      launcherContext.search = ":wallpaper "
    }
  }
  
  LauncherWindow {
    screen: root.screen

    context: root.launcherContext

    modules: [
      AppsLauncherModule {},
      AudioLauncherModule {},
      WallpapersLauncherModule {},
      LockLauncherModule {},
      ShutdownLauncherModule {}
    ]
  }

  ScreenshotWindow {
    screen: root.screen

    context: root.screenshotContext
  }

  ScreencapWindow {
    screen: root.screen

    context: root.screencapContext
  }

  OcrWindow {
    screen: root.screen

    context: root.ocrContext
  }

  OsdWindow {
    screen: root.screen

    modules: [
      BatteryOsdModule {},
      BrightnessOsdModule {},
      KeyboardLayoutOsdModule {},
      MicrophoneOsdModule {},
      SpeakerOsdModule {}
    ]
  }

  BorderWindow {
    screen: screen
    bar: bar
  }

  NotificationWindow {
    screen: screen
    bar: bar
  }

  BarWindow {
    id: bar

    context: barContext
    screen: screen

    startModules: [
      OsIconBarModule {},
      WorkspacesBarModule {},
      CpuUsageBarModule {},
      MemoryUsageBarModule {},
      HardDriveUsageBarModule {}
    ]

    centerModules: [
      ClientFocusBarModule {}
    ]

    endModules: [
      ScreencapBarModule {
        context: root.screencapContext
      },
      KeyboardLayoutBarModule {},
      TimeBarModule {},
      DateBarModule {},
      BrightnessBarModule {},
      SpeakerBarModule {},
      // MicrophoneBarModule {},
      BatteryBarModule {},
      NetworkBarModule {},
      BarGroup {
        TrayBarModule {}
      }
    ]
  }

  Lockscreen {
    context: lockscreenContext
  }
}
