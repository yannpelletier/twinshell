import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "root:/widgets"

LazyLoader {
  id: root

  required property string name
  required property AreaPickerContext areaPickerContext
  required property ShellScreen screen

  function onRegion(x: real, y: real, width: real, height: real, isClient: bool): void {
    // Empty
  }

  activeAsync: root.areaPickerContext.visible

  StyledWindow {
    id: win

    screen: root.screen
    name: root.name
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: root.areaPickerContext.closing ? WlrKeyboardFocus.None : WlrKeyboardFocus.Exclusive
    mask: root.areaPickerContext.closing ? empty : null

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    Region {
      id: empty
    }

    AreaPicker {
      screen: win.screen
      context: root.areaPickerContext
      onRegion: root.onRegion
    }
  }
}
