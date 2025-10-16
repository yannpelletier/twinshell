import Quickshell.Io

JsonObject {
  property int maxShown: 8
  property int maxWallpapers: 5 // Warning: even numbers look bad
  property string actionPrefix: ":"

  property JsonObject sizes: JsonObject {
    property int itemWidth: 750
    property int itemHeight: 57
    property int iconSize: 32
    property int wallpaperWidth: 280
    property int wallpaperHeight: 200
  }
}
