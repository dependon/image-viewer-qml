import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

SwipeView {
    id: stackView

    property int currentWidgetIndex: 0

//    property alias source: imageViewer.source
//    initialItem: rect
    anchors.fill: parent
    OpenImageWidget{

    }
    FullThumbnail{
        id :mainView
    }

//    interactive: false
    currentIndex: currentWidgetIndex

}
