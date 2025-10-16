import QtQuick
import Quickshell

QtObject {
  required property string name
  required property string icon 
  required property string description
  required property string keyword
  property Component content
  property var execute
}
