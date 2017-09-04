import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.voidptr.qmastodon 1.0
import org.kde.kirigami 2.0 as Kirigami

Kirigami.Page {
    id: page
    title: "Enter instance URL"
    Layout.fillWidth: true

    actions {
        right: Kirigami.Action {
            id: nextAction
            text: 'Get Code'
            iconName: 'go-next'
            enabled: false
            onTriggered:
            {
                mastodon.instanceURL = instanceUrlField.text;
                mastodon.getClientTokens()
            }
        }
    }

    ColumnLayout {
        width: page.width
        spacing: Kirigami.Units.smallSpacing
        TextField {
            id: instanceUrlField
            placeholderText: "https://mastodon.social"
            onTextChanged: {
                nextAction.enabled = true
            }
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
