import Quickshell.Io

JsonObject {
  id: root

  property JsonObject family: JsonObject {
    property string sans: "IBM Plex Sans"
    property string mono: "JetBrains Mono NF"
    property string material: "Material Symbols Rounded"
  }

  property JsonObject size: JsonObject {
    property int small: 11
    property int smaller: 12
    property int normal: 13
    property int larger: 15
    property int large: 18
    property int extraLarge: 22
  }
}
