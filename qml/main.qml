import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

Window {
    GlobalVar{
        id: global
    }

    id: root
    title: qsTr("看图")

    visible: true
    width: 800
    height: 600

    Rectangle{
        id: rect
        width: root.width;
        height: root.height;
        anchors.centerIn: parent
//        color: "red"
//        onColorChanged: {
//            stackView.pop()
//            stackView.push()
//        }

        MainStack{
            anchors.fill: parent
            interactive: false
        }
    }




}



