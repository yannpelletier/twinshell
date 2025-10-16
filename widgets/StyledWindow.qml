import "root:/utils"
import "root:/config"
import Quickshell
import Quickshell.Wayland

PanelWindow {
  required property string name

  WlrLayershell.namespace: `twinshell-${name}`
  color: "transparent"
}
