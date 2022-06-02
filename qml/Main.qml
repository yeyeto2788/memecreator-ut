/*
 * Copyright (C) 2022  Juan Biondi
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * memecreator is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import Ubuntu.Content 1.3

// import FileMngt 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'memecreator.yeyeto2788'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property string myImportedImgFolder: ""
    property string myImageUrl: "test.png"
    Component.onCompleted: mainPageStack.push(mainPage)
    
    Component {
        id: aboutDialog
        AboutDialog {}
    }

    Component{
        id: imageSelector
        SystemImages {}
    }

    PageStack{
        id: mainPageStack
        anchors.fill: parent

    }

    Page {
        id: mainPage
        anchors.fill: parent
        visible: false

        header: PageHeader {
            id: header
            title: i18n.tr('Meme creator')
            subtitle: i18n.tr('Create you meme easily')
            StyleHints {
                foregroundColor: UbuntuColors.orange
            }

            ActionBar {
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: units.gu(1)
                    rightMargin: units.gu(1)
                }
                numberOfSlots: 1
                actions: [
                    Action {
                        iconName: "settings"
                        text: i18n.tr("Settings")
                    },
                    Action {
                        iconName: "info"
                        text: i18n.tr("About")
                        onTriggered: PopupUtils.open(aboutDialog)
                    }
                ]
            }
        }

        Label {
            width: parent.width - units.gu(4)
            wrapMode: Text.Wrap
            text: {
                if (myImportedImgFolder == "")
                    return (i18n.tr("Click button to select an image"))
                else
                    return (i18n.tr("<b>Image file path:</b><br>") + "<i>" + myImageUrl + "</i>")
            }

        }

        Button {
            id: imageChoose
            anchors {
                top: header.bottom
                right: parent.right
                topMargin: units.gu(2)
                rightMargin: units.gu(2)
            }
            text: i18n.tr('Choose image')
            onClicked: {
                var importPage = mainPageStack.push(Qt.resolvedUrl("SystemImages.qml"),{"contentType": ContentType.Pictures, "handler": ContentHandler.Source})
                importPage.imported.connect(function(fileUrl) {
                    // Resource optimizations for low-end devices
                    mainPageStack.pop()
                    myImageUrl = fileUrl
                    //mainPageStack.push(mainPage)
                })
                
            }
                        

        }

        TextField {
            id: textFieldInput
            anchors {
                top: header.bottom
                left: parent.left
                topMargin: units.gu(2)
                leftMargin: units.gu(2)
            }
            placeholderText: i18n.tr('Meme text')
        }

        Image {
            id: myimage
            anchors{
                top: imageCreate.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            fillMode: Image.PreserveAspectFit
            source: {
                if (myImageUrl == "")
                    return ("")
                else
                    return (myImageUrl)
            }
        }


        Button {
            id: imageCreate
            anchors {
                top: imageChoose.bottom
                right: parent.right
                topMargin: units.gu(2)
                rightMargin: units.gu(2)
            }
            text: i18n.tr('Save image')
            onClicked: {
                python.call('main.execute', ['Hello World!'], function(returnValue) {
                    console.log('main.execute returned ' + returnValue);
                })
            }
        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));

            importModule('main', function() {
                console.log('module imported');
                python.call('main.execute', ['Hello World!'], function(returnValue) {
                    console.log('main.execute returned ' + returnValue);
                })
            });

            
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
