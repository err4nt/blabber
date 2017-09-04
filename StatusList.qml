import QtQuick 2.4
import org.voidptr.qmastodon 1.0
import ork.kde.kirigami 2.0 as Kirigami

Kirigami.Page {
    title: "Timeline"
    Layout.fillWidth: true
    ListView {
        id: statusListView
        anchors.fill: parent
        model: statusListModel
        delegate: StatusListItem {
        }
        onCurrentItemChanged: {
            console.log(statusListModel.get(statusListView.currentIndex))
        }
    }
}
