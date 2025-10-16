import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
  property bool visible:  false 
  property bool freeze: false
  property bool closing: false

  function open() {
    freeze = false;
    closing = false;
    visible = true;
  }

  function openFreeze() {
    freeze = true;
    closing = false;
    visible = true;
  }
}
