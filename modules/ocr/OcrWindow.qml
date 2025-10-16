import Quickshell
import "root:/widgets"
import "root:/services"
import "root:/modules/areapicker"

AreaPickerWindow {
  id: root

  required property OcrContext context
  areaPickerContext: context

  name: "ocr"

  function onRegion(x: real, y: real, width: real, height: real, isClient: bool): void {
    root.context.ocr(x,y,width,height);
  }
}
