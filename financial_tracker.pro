QT += quick \
      sql

SOURCES += \
        main.cpp \
<<<<<<< HEAD
        transaction.cpp \
        transactionmanager.cpp
=======
        transactionmanager.cpp \
        transaction.cpp
>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0

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
<<<<<<< HEAD
    databasemanager.h \
    transaction.h \
    transactionmanager.h
=======
    transactionmanager.h \
    transaction.h

>>>>>>> 3fa0c2d4315cdce955e98c5a24a53f50c8ed2fd0
