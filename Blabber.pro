QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    kwalletinterface.cpp

RESOURCES += qml.qrc

LIBS += -lKF5Wallet

INCLUDEPATH += /usr/include/KDE

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/kirigami.2/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = /usr/lib/x86_64-linux-gnu/qt5/qml/org/kde/kirigami.2/

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../build-libmastodon-Desktop-Debug/release/ -llibmastodon
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../build-libmastodon-Desktop-Debug/debug/ -llibmastodon
else:unix: LIBS += -L$$PWD/../build-libmastodon-Desktop-Debug/ -llibmastodon

INCLUDEPATH += $$PWD/../libmastodon
DEPENDPATH += $$PWD/../build-libmastodon-Desktop-Debug

HEADERS += \
    kwalletinterface.h
