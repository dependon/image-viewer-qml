import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.3
import Qt.labs.folderlistmodel 2.11
Item {
    id: openwidget

//    anchors.fill: parent
    Button {
        id: openFileBtn
        anchors.centerIn: openwidget
        font.capitalization: Font.MixedCase
        text: qsTr("Open Pictures")
        onClicked: fileDialog.open()
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Select pictures")
        folder: shortcuts.pictures
        selectMultiple: true
        nameFilters: ["Image files (*.jpg *.png *.bmp)"]
        onAccepted: {
            mainView.source = fileDialog.fileUrls[0]

            mainView.sourcePaths = fileControl.getDirImagePath(fileDialog.fileUrls[0]);

            mainView.setThumbnailCurrentIndex(mainView.sourcePaths.indexOf(mainView.source))

            stackView.currentWidgetIndex= 1

//            openFileBtn.visible = false


            var test = fileDialog.fileUrls
            console.log("test1:" + test)
            test.splice(1,1)
            console.log("test2:" + test)


        }
    }

    FolderListModel
    {
        id: foldermodel
        folder: "file://" + platform.picturesLocation()
        showDirs: false
        showDotAndDotDot: false
        nameFilters: ["*.dng", "*.nef", "*.bmp", "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.pbm", "*.pgm","*.png",  "*.pnm", "*.ppm",
                      "*.svg", "*.tga", "*.tif", "*.tiff", "*.wbmp", "*.webp", "*.xbm", "*.xpm", "*.gif"]
        sortField: FolderListModel.Type
        showOnlyReadable: true
        sortReversed: false

        onCountChanged: {
//           if(!root.run){
//              root.fileMonitor()
//           }
        }
    }

}
