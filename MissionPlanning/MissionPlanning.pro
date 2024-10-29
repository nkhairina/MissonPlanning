QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    ui/assests/Map/10.jpg \
    ui/assests/Map/11.jpg \
    ui/assests/Map/12.jpg \
    ui/assests/Map/13.jpg \
    ui/assests/Map/14.jpg \
    ui/assests/Map/15.jpg \
    ui/assests/Map/16.jpg \
    ui/assests/Map/17.jpg \
    ui/assests/Map/18.jpg \
    ui/assests/Map/19.jpg \
    ui/assests/Map/20.jpg \
    ui/assests/Map/21.jpg \
    ui/assests/Map/22.jpg \
    ui/assests/Map/23.jpg \
    ui/assests/Map/24.jpg \
    ui/assests/Map/25.jpg \
    ui/assests/Map/26.jpg \
    ui/assests/Map/27.jpg \
    ui/assests/Map/28.jpg \
    ui/assests/Map/29.jpg \
    ui/assests/Map/30.jpg \
    ui/assests/Map/31.jpg \
    ui/assests/Map/32.jpg \
    ui/assests/Map/33.jpg \
    ui/assests/Map/34.jpg \
    ui/assests/Map/35.jpg \
    ui/assests/Map/36.jpg \
    ui/assests/Map/37.jpg \
    ui/assests/Map/38.jpg \
    ui/assests/Map/39.jpg \
    ui/assests/Map/40.jpg \
    ui/assests/Map/41.jpg \
    ui/assests/Map/42.jpg \
    ui/assests/Map/43.jpg \
    ui/assests/Map/44.jpg \
    ui/assests/Map/45.jpg \
    ui/assests/Map/46.jpg \
    ui/assests/Map/47.jpg \
    ui/assests/Map/48.jpg \
    ui/assests/Map/49.jpg \
    ui/assests/Map/50.jpg \
    ui/assests/Map/51.jpg \
    ui/assests/Map/52.jpg \
    ui/assests/Map/53.jpg \
    ui/assests/Map/54.jpg \
    ui/assests/Map/55.jpg \
    ui/assests/Map/56.jpg \
    ui/assests/Map/57.jpg \
    ui/assests/Map/58.jpg \
    ui/assests/Map/60.jpg \
    ui/assests/Map/61.jpg \
    ui/assests/Map/62.jpg \
    ui/assests/Map/63.jpg \
    ui/assests/Map/7.jpg \
    ui/assests/Map/8.jpg \
    ui/assests/Map/9.jpg \
    ui/assests/help.png
