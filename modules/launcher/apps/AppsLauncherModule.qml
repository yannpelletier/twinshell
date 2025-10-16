import QtQuick
import Quickshell
import "root:/services"
import "../"

LauncherModule {
  function query(search: string): list<var> {
    const results = Apps.fuzzyQuery(search);
    return results.map((r) => {
      return {
        name: r.name,
        description: r.comment,
        icon: {
          type: "app",
          value: r.icon,
        },

        execute: (launcherState) => {
          Apps.launch(r);

          launcherState.search = "";
          launcherState.visible = false;
        }
      }
    });
  }
}
