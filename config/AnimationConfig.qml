
import Quickshell.Io

JsonObject {
  id: root

  property JsonObject curves: JsonObject {
    property var emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    property var emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    property var emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    property var standard: [0.2, 0, 0, 1, 1, 1]
    property var standardAccel: [0.3, 0, 1, 1, 1, 1]
    property var standardDecel: [0, 0, 0, 1, 1, 1]
    property var expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
    property var expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
    property var expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
  }
  property JsonObject durations: JsonObject {
    property int small: 200
    property int normal: 400
    property int large: 600
    property int extraLarge: 1000
    property int expressiveFastSpatial: 350
    property int expressiveDefaultSpatial: 500
    property int expressiveEffects: 200
  }
}
