import Quickshell
import "root:/widgets"
import "root:/services"
import "root:/modules/areapicker"

AreaPickerWindow {
  id: root

  required property ScreenshotContext context
  areaPickerContext: context

  name: "screenshot"

  function onRegion(x: real, y: real, width: real, height: real, isClient: bool): void {
    root.context.screenshot(x,y,width,height);
  }
}
