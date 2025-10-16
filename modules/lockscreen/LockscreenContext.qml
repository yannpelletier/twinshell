import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
	id: root

	property string currentText: ""
  property bool locked: false
	property bool unlockInProgress: false
	property bool showFailure: false

	onCurrentTextChanged: showFailure = false;

  function lock() {
    locked = true;
  }

	function tryUnlock() {
		if (currentText === "") return;

		root.unlockInProgress = true;
		pam.start();
	}

	PamContext {
		id: pam

		configDirectory: "pam"
		config: "password.conf"

		onPamMessage: {
			if (this.responseRequired) {
				this.respond(root.currentText);
			}
		}

		onCompleted: result => {
			if (result == PamResult.Success) {
        locked = false;
			} else {
				root.currentText = "";
				root.showFailure = true;
			}

			root.unlockInProgress = false;
		}
	}
}
