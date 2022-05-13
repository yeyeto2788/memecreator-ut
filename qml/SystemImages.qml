import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.folderlistmodel 2.1

Dialog {
    id: dialog
    title: i18n.tr("System Images")

    Label {
		width: parent.width
		wrapMode: Text.WordWrap
        text: i18n.tr("Select image")
    }

    ListView {
        width: parent.width
        height: units.gu(50)
        FolderListModel {
            id: folderModel
            nameFilters: ["*.png", "*.jpg"]
            rootFolder: "/home/phablet/Pictures"
            showDirs: true
            showDotAndDotDot: true
            showFiles: true
        }
        Component {
            id: fileDelegate
            Text { text: fileName }
        }
        model: folderModel
        delegate: fileDelegate
    }

    Button {
        text: i18n.tr("Close")
        onClicked: PopupUtils.close(dialog)
    }
}