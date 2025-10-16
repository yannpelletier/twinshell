pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "root:/config"
import "root:/widgets"
import "root:/services"
import "../"

BarModule {
  id: root

  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  RowLayout {
    id: layout

    spacing: 0
    layer.enabled: true
    layer.smooth: true

    Repeater {
      model: Config.bar.workspaces.shown

      WorkspaceItem {
        isFocused: Hyprland.focusedWorkspaceId === (index + 1)
        hasWindows: Hyprland.isWorkspaceOccupied(index + 1);
      }
    }
  }

  MouseArea {
    anchors.fill: parent

    onPressed: event => {
      const ws = layout.childAt(event.x, event.y).index + 1;
      if (Hyprland.focusedWorkspaceId !== ws)
        Hyprland.dispatch(`workspace ${ws}`);
    }
  }
}
