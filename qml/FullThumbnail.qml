import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11
import QtGraphicalEffects 1.0

Item {
    property alias source: imageViewer.source
    property alias sourcePaths: imageViewer.sourcePaths
    property alias currentIndex: imageViewer.swipeIndex

    signal closeFullThumbnail

//    anchors.fill: rootItem

    function setThumbnailCurrentIndex(index) {
        thumbnailListView.currentIndex = index
    }

    ImageViewer {
        id: imageViewer
        anchors.fill: parent
//        sourcePaths: thumbnailIconView.imgPaths
    }

//    ViewTitle {
//        id: tittle
//        anchors.top: parent.top
//        width: parent.width
//        height: 50
//    }

    // thumbnailView BackGround
    Rectangle {
        id: thumbnailViewBackGround
        width: parent.width - 30
        anchors.right: parent.right
        anchors.rightMargin: 15
        height: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        radius: 10
        opacity: 0.5
        color: "grey"
    }

    // thumbnailView Blur
    FastBlur {
        anchors.fill: thumbnailViewBackGround
        source: thumbnailViewBackGround
        opacity: 0.5
    }

    ThumbnailListView {
        id: thumbnailListView
        anchors.fill: thumbnailViewBackGround

//         property int currentIndex: 0
    }
}
