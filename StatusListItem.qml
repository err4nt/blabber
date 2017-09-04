import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import org.kde.kirigami 2.0 as Kirigami

Kirigami.SwipeListItem {
    id: statusListItem

    RowLayout{
        spacing: Kirigami.Units.smallSpacing*2
        Kirigami.Icon {
            Layout.minimumHeight: Kirigami.Units.iconSizes.smallMedium
            Layout.maximumHeight: Layout.minimumHeight
            Layout.minimumWidth: height
            source: account.avatar
        }
        Kirigami.Label {
            id: labelItem
            Layout.fillWidth: true
            color: statusListItem.checked || statusListItem.pressed ? statusListItem.activeTextColor : statusListItem.textColor
            text: content
            elide: Text.ElideRight
            font: statusListItem.font
            wrapMode: Text.WordWrap
            onLinkActivated: {
               Qt.openUrlExternally(link)
            }
        }
    }
}
