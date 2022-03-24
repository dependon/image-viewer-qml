import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0

Item {
    property int currentIndex: 0
//      property alias currentIndex :bottomthumbnaillistView.currentIndex

    onCurrentIndexChanged: {
       bottomthumbnaillistView.currentIndex = currentIndex
       bottomthumbnaillistView.forceActiveFocus()
    }

//    Timer{
//        interval: 200
//        running: true
//        repeat: true
//        onTriggered: {
//           bottomthumbnaillistView.forceActiveFocus()
//        }
//    }
    function deleteCurrentImage(){

        if (mainView.sourcePaths.length - 1 > bottomthumbnaillistView.currentIndex) {

            bottomthumbnaillistView.currentIndex++
            source = sourcePaths[bottomthumbnaillistView.currentIndex]
            fileControl.deleteImagePath(sourcePaths[bottomthumbnaillistView.currentIndex-1])
            sourcePaths = fileControl.removeList(sourcePaths,bottomthumbnaillistView.currentIndex-1)

        }else if(mainView.sourcePaths.length - 1 == 0){
            stackView.currentWidgetIndex=0
            fileControl.deleteImagePath(sourcePaths[0])

        }else{
            bottomthumbnaillistView.currentIndex--
            source = sourcePaths[bottomthumbnaillistView.currentIndex]
            fileControl.deleteImagePath(sourcePaths[bottomthumbnaillistView.currentIndex+1])
            sourcePaths = fileControl.removeList(sourcePaths,bottomthumbnaillistView.currentIndex+1)
        }
    }

    RowLayout {
        id: thumbnaillayout

        anchors.left: parent.left
        anchors.leftMargin: 15

        anchors.top: parent.top
        anchors.topMargin: (parent.height - height) / 2

//        ThumbnailButton {
//            icon.source: "qrc:/res/dcc_back_36px.svg"
//            onClickedLeft: closeFullThumbnail()
//        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_previous_36px.svg"
            onClickedLeft: {
                if (bottomthumbnaillistView.currentIndex > 0) {
                    bottomthumbnaillistView.currentIndex--
                    source = mainView.sourcePaths[bottomthumbnaillistView.currentIndex]
                    imageViewer.index = currentIndex
                    bottomthumbnaillistView.forceActiveFocus()
                }
            }
        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_next_36px.svg"
            onClickedLeft: {
                if (mainView.sourcePaths.length - 1 > bottomthumbnaillistView.currentIndex) {
                    bottomthumbnaillistView.currentIndex++
                    source = mainView.sourcePaths[bottomthumbnaillistView.currentIndex]
                    imageViewer.index = currentIndex
                    bottomthumbnaillistView.forceActiveFocus()
                }
            }
        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_11_36px.svg"

            onClickedLeft: {
                imageViewer.fitImage()
            }

        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_fit_36px.svg"
            onClickedLeft: {
                imageViewer.fitWindow()
            }
        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_ocr_36px.svg"
            onClickedLeft: {
                fileControl.ocrImage(source)
            }
        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_left_36px.svg"
            onClickedLeft: {
                imageViewer.rotateImage(-90)
            }
        }
        ThumbnailButton {
            icon.source: "qrc:/res/dcc_right_36px.svg"
            onClickedLeft: {
                imageViewer.rotateImage(90)
            }
        }
    }

    ListView {
        id: bottomthumbnaillistView

        anchors.left: thumbnaillayout.right
        anchors.leftMargin: 15

        anchors.right: deleteButton.left
        anchors.rightMargin: 15

        anchors.top: parent.top

        height: parent.height
        width: parent.width - thumbnaillayout.width - deleteButton.width - 60

        clip: true
        spacing: 10
        focus: true
        Connections {
            target: imageViewer
            onSwipeIndexChanged: {
                bottomthumbnaillistView.currentIndex = imageViewer.swipeIndex
                currentIndex= imageViewer.swipeIndex
                bottomthumbnaillistView.forceActiveFocus()
            }
        }

        orientation: Qt.Horizontal

        cacheBuffer: 200
        model: mainView.sourcePaths.length
        delegate: ListViewDelegate {
        }

        Behavior on y {
            NumberAnimation {
                duration: 50
                easing.type: Easing.OutQuint
            }
        }

        Keys.enabled: true
        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Left:
                if (currentIndex > 0) {
                    currentIndex--
                    source = mainView.sourcePaths[currentIndex]
                }
                break
            case Qt.Key_Right:
                if (mainView.sourcePaths.length - 1 > currentIndex) {
                    currentIndex++
                    source = mainView.sourcePaths[currentIndex]
                }
                break
            }
            event.accepted = true
        }

//        Component.onCompleted: {
//            console.log("123456")
//            bottomthumbnaillistView.currentIndex = 0
//            bottomthumbnaillistView.forceActiveFocus();
//        }
    }
    ThumbnailButton {
        id: deleteButton

        anchors.right: parent.right
        anchors.rightMargin: 15

        anchors.top: parent.top
        anchors.topMargin: (parent.height - height) / 2

        icon.source: "qrc:/res/dcc_delete_36px.svg"
        icon.color: enabled ? "red" :"ffffff"
        onClickedLeft: {
            deleteCurrentImage()
        }
//        visible: fileControl.isCanDelete(source) ? true :false

        enabled: fileControl.isCanDelete(source) ? true :false

        shortcut:  "Ctrl+O"
    }
}
