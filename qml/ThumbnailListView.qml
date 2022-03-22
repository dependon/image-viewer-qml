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


    RowLayout {
        id: thumbnaillayout

        anchors.left: parent.left
        anchors.leftMargin: 15

        anchors.top: parent.top
        anchors.topMargin: (parent.height - height) / 2

//        ThumbnailButton {
//            img_src: "qrc:/res/dcc_back_36px.svg"
//            onClickedLeft: closeFullThumbnail()
//        }
        ThumbnailButton {
            img_src: "qrc:/res/dcc_previous_36px.svg"
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
            img_src: "qrc:/res/dcc_next_36px.svg"
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
            img_src: "qrc:/res/dcc_11_36px.svg"
            onClickedLeft: {
                imageViewer.fitImage()
            }
        }
        ThumbnailButton {
            img_src: "qrc:/res/dcc_fit_36px.svg"
            onClickedLeft: {
                imageViewer.fitWindow()
            }
        }
        ThumbnailButton {
            img_src: "qrc:/res/dcc_ocr_36px.svg"
            onClickedLeft: {

            }
        }
        ThumbnailButton {
            img_src: "qrc:/res/dcc_left_36px.svg"
            onClickedLeft: {
                imageViewer.rotateImage(-90)
            }
        }
        ThumbnailButton {
            img_src: "qrc:/res/dcc_right_36px.svg"
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

        img_src: "qrc:/res/dcc_delete_36px.svg"
        onClickedLeft: {
            if (mainView.sourcePaths.length - 1 > bottomthumbnaillistView.currentIndex) {

                //                bottomthumbnaillistView.currentIndex++
                //                source = thumbnail.imgPaths[bottomthumbnaillistView.currentIndex]
                //                thumbnail.imgPaths.splice(bottomthumbnaillistView.currentIndex-1,1);
            }
        }
    }
}
