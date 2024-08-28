QT += quick \
      sql

SOURCES += \
        main.cpp \
        transactionmanager.cpp \
        transaction.cpp

resources.files = main.qml Page1.qml MainPage.qml Page2.qml Page3.qml Page4.qml
resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Page4.qml

DISTFILES +=

HEADERS += \
    transactionmanager.h \
    transaction.h

