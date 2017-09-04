import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQml 2.2
import org.kde.kirigami 2.0 as Kirigami
import org.voidptr.qmastodon 1.0

Kirigami.ApplicationWindow {
    property alias mastodon: mastodon

    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Blabber")

    header: Kirigami.ToolBarApplicationHeader {}

    globalDrawer: Kirigami.GlobalDrawer {

    }

    pageStack.initialPage: loginForm

    Component.onCompleted:
    {
        wallet.openWallet()
    }

    QMastodon {
        id: mastodon
        clientName: "Blabber"
        clientWebsite: "https://voidptr.org/blabber"
        clientScopes: "read write follow"
        onShowAuthorizationPage:
        {
            var reqURL = mastodon.getAuthRequestUrl()
            console.log(reqURL)
            Qt.openUrlExternally(reqURL)
            pageStack.push(EnterAuthCode)
            mainStack.currentIndex = 1
        }
        onAuthenticationComplete:
        {
            wallet.storeCredentials(mastodon.instanceURL,
                                    mastodon.clientId,
                                    mastodon.clientSecret,
                                    mastodon.clientToken,
                                    mastodon.refreshToken,
                                    mastodon.refreshTokenExpire)
            pageStack.replace(mainApplicationForm)
        }
        onAuthenticationError:
        {

        }
        onTimelineRequestComplete:
        {
            for(var status in statuses)
            {
                statusListModel.append(statuses[status])
            }
            console.log("stop")
        }
    }

    //Experiment: custom animation for layers
    pageStack.layers.popEnter: Transition {
        PauseAnimation {
            duration: Kirigami.Units.longDuration
        }
    }
    
    pageStack.layers.popExit: Transition {
        YAnimator {
            from: 0
            to: pageStack.layers.height
            duration: Kirigami.Units.longDuration
            easing.type: Easing.OutCubic
        }
    }

    pageStack.layers.pushEnter: Transition {
        YAnimator {
            from: pageStack.layers.height
            to: 0
            duration: Kirigami.Units.longDuration
            easing.type: Easing.OutCubic 
        }
    }

    pageStack.layers.pushExit: Transition {
        PauseAnimation {
            duration: Kirigami.Units.longDuration
        }
    }

    pageStack.layers.replaceEnter: Transition {
        YAnimator {
            from: pageStack.layers.width
            to: 0
            duration: Kirigami.Units.longDuration
            easing.type: Easing.OutCubic
        }
    }

    pageStack.layers.replaceExit: Transition {
        PauseAnimation {
            duration: Kirigami.Units.longDuration
        }
    }

    ListModel {
        id: statusListModel
    }

    Component {
        id: mainApplicationForm
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
    }

    Component {
        id: loginForm
        InitialLogin {

        }
    }

    Component {
        id: enterAuthForm
        EnterAuthCode {

        }
    }

    Connections
    {
        target: wallet
        onWalletReady:
        {
            wallet.loadCredentials()
        }
        onKeysNotFound:
        {
        }
        onKeysLoaded: {
            mastodon.clientId = clientId;
            mastodon.clientSecret = clientSecret;
            mastodon.clientToken = clientToken;
            mastodon.instanceURL = instanceUrl;
            mastodon.refreshToken = refreshToken;
            mastodon.refreshTokenExpire = expires;
            pageStack.replace(mainApplicationForm)
            mastodon.timeline('home', 20)
        }
    }
}
