import QtQuick 2.11
import QtQuick.Controls 2.4
Rectangle {


    id: rec

    property alias img_src: icon.source
    property alias btn_txt: button.text

    property color clr_enter: "#dcdcdc"
    property color clr_exit: "#ffffff"
    property color clr_click: "#aba9b2"
    property color clr_release: "#ffffff"

    //自定义点击信号
    signal clickedLeft()
    signal clickedRight()
    signal release()

    height: 50
    width: 50
    radius :8
        Image {
            id: icon
            width: parent.width
            height: parent.height
            source: ""
            fillMode: Image.PreserveAspectFit
            clip: true
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 0
            smooth: true
        }
        Text {
            id: button
    //        text: qsTr("button")

            anchors.top: icon.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: icon.horizontalCenter
            anchors.bottom: icon.bottom
            anchors.bottomMargin: 5

            font.bold: true
            font.pointSize: 14
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            //接受左键和右键输入
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                //左键点击
                if (mouse.button === Qt.LeftButton)
                {
                    parent.clickedLeft()
    //                console.log(button.text + " Left button click")
                }
                else if(mouse.button === Qt.RightButton)
                {
                    parent.clickedRight()
    //                console.log(button.text + " Right button click")
                }
            }

            //按下
            onPressed: {
                color = clr_click
            }

            //释放
            onReleased: {
                color = clr_enter
                parent.release()
            }

            //指针进入
            onEntered: {
                color = clr_enter

            }

            //指针退出
            onExited: {
                color = clr_exit

            }
        }
    }




