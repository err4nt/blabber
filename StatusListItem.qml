import QtQuick 2.4
import QtQuick.Controls 2.2
import org.kde.kirigami 2.0 as Kirigami

Kirigami.SwipeListItem {
    id: statusListItem

    Kirigami.BasicListItem {
        label: content
        icon: account.avatar
    }
}
