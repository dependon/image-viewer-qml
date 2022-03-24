import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
Rectangle {

    // Indicates the minimum number of zooms
    property int minScaleLevel: 10
    // Indicates the maximum number of zooms
    property int maxScaleLevel: 30
    // Indicates the current scaleLevel of zooms
    property int currentScaleLevel: 0
    //current rotate
    property int currentRotate: 0

    // Indicates the current image path
    property var source
    /*: showImg.source*/
    property var sourcePaths
    property int index: 0
    property alias swipeIndex: view.currentIndex
    function zoomIn(x, y) {
        view.currentItem.scale = view.currentItem.scale / 0.9
    }

    function zoomOut(x, y) {
        view.currentItem.scale = view.currentItem.scale * 0.9
    }

    function fitImage() {
        view.currentItem.scale = 1.0
    }

    function fitWindow() {
        view.currentItem.scale = 1.0
    }
    function rotateImage(x) {
//        rotation = currentRotate + x
        currentRotate = currentRotate + x
        view.currentItem.rotation=currentRotate
    }
    function deleteItem (item, list) {
      // 先遍历list里面的每一个元素，对比item与每个元素的id是否相等，再利用splice的方法删除
      for (var key in fileList) {
        if (list[key].id === item) {
          list.splice(key, 1)
        }
      }
    }

    MouseArea{
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            console.log("right menu");
            if (mouse.button === Qt.RightButton) {
                option_menu.popup()
            }
        }

        onWheel: {
            var datla = wheel.angleDelta.y / 120
            if (datla > 0) {
                view.currentItem.scale = view.currentItem.scale/0.9
            } else {
                view.currentItem.scale = view.currentItem.scale * 0.9
            }
        }
    }
    Menu {
        id: option_menu

        MenuItem {
            text: "Fullscreen"

            onTriggered: {}
        }

        MenuItem {
            text: "Exit fullscreen"
            onTriggered: {}
        }

        MenuItem {
            text: "Print"

            onTriggered: {}
        }

        MenuItem {
            text: "Extract text"
            onTriggered: {
            fileControl.ocrImage(source)
            }
        }

        MenuItem {
            text: "Slide show"
            onTriggered: {}
        }


        MenuSeparator { }
        MenuItem {
            text: "Copy"
            onTriggered: {}
        }

        MenuItem {
            text: "Rename"
            onTriggered: {}
        }


        MenuItem {
            text: "Delete"
            shortcut:"Delete"
//            Shortcut{
//                sequence: "Delete"
//                onActivated:{
//                    thumbnailListView.deleteCurrentImage()
//                }
//            }

            onTriggered: {
            thumbnailListView.deleteCurrentImage()
            }
        }


        MenuSeparator { }

        MenuItem {
            text: "Rotate counterclockwise"
            onTriggered: {
            imageViewer.rotateImage(-90)
            }
        }

        MenuItem {
            text: "Rotate clockwise"
            onTriggered: {
            imageViewer.rotateImage(90)
            }
        }
        MenuItem {
            text: "Show navigation window"
            onTriggered: {}
        }

        MenuItem {
            text: "Hide navigation window"
            onTriggered: {}
        }

        MenuItem {
            text: "Set as wallpaper"
            onTriggered: {
            fileControl.setWallpaper(source)
            }
        }

        MenuItem {
            text: "Display in file manager"

            onTriggered: {
            fileControl.displayinFileManager(source)
            }
        }

        MenuItem {
            text: "Image info"
            onTriggered: {}
        }
    }


    SwipeView {
        id: view
        currentIndex: sourcePaths.indexOf(source)
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        clip: true

        Repeater {
            model: sourcePaths.length
            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem
                        || SwipeView.isPreviousItem
                sourceComponent: Rectangle {
                    width: parent.width
                    height: parent.height

                    color: "black"

                    AnimatedImage {
                        id: showImg
                        width: parent.width
                        height: parent.height

                        source: sourcePaths[index]
                        anchors.centerIn: parent
                        asynchronous: true
                        cache: true
                        clip: true
                        scale: 1.0
                        onWidthChanged: {
                            if (view.width > 0) {
                                if (view.width > root.width
                                        || view.height > root.height) {
                                    fitWindow()
                                } else {
                                    fitImage()
                                }
                            }
                        }
                    }

                }
            }
        }
        onCurrentItemChanged: {
            currentRotate=0
        }
    }
}
