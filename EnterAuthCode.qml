import QtQuick 2.4
import QtQuick.Controls 2.2
import org.kde.kirigami 2.0 as Kirigami
import org.voidptr.qmastodon 1.0


Kirigami.Page {
    title: "Enter code"
    property alias completeButton: completeButton
    property alias authCodeField: authCodeField

    actions {
        main: Kirigami.Action {
            text: 'Log In'
        }
    }

    TextField {
        id: authCodeField
        x: 44
        y: 180
        width: 312
        height: 40
        text: qsTr("")
        renderType: Text.QtRendering
    }

    Button {
        id: completeButton
        x: 256
        y: 226
        text: qsTr("Complete")
		onClicked: {
			mastodon.getAccessToken(authCodeField.text);
		}
    }

    Label {
        id: label
        x: 44
        y: 154
        text: qsTr("Code from website:")
    }
}
