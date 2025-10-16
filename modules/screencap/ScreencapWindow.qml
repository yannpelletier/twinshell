import Quickshell
import "root:/widgets"
import "root:/services"
import "root:/modules/areapicker"

AreaPickerWindow {
  id: root

  required property ScreencapContext context
  areaPickerContext: context

  name: "screencap"

  function onRegion(x: real, y: real, width: real, height: real, isClient: bool): void {
    root.context.startRecording(x,y,width,height);
  }
}
