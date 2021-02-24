import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebView 1.14
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Quick Browser")

    property var topBarHeight: 30
    property var topBarBtnWidth: 30

    Button {

        text: "<"
        width: topBarBtnWidth
        height: topBarHeight
        onClicked: function() {
            browser.goBack()
        }
    }

    Button {
        text: ">"
        x: topBarBtnWidth
        width: topBarBtnWidth
        height: topBarHeight
        onClicked: function() {
            browser.goForward()
        }
    }

    TextInput {
        id: urlInput
        x: topBarBtnWidth * 2
        padding: 5
        width: parent.width - topBarBtnWidth * 3
        height: topBarHeight
        selectByMouse: true

        onAccepted: function(){
            goBtn.clicked()
        }
    }

    Button {
        id: goBtn
        state: "2"
        visible: true
        x: parent.width - topBarBtnWidth
        width: topBarBtnWidth
        height: topBarHeight

        property var gotopage: function(){
            urlInput.text = urlInput.text.replace(/^(?!http?)(.*)/, 'http://$1')
            browser.url = urlInput.text
        }

        property var stopgoing: function(){
            browser.stop()
            this.state = "2"
        }

        states: [
            State {
                name: "0"
                PropertyChanges {
                    target: goBtn
                    text: "0"

                    onClicked: function(){
                        goBtn.gotopage()
                    }
                }
                PropertyChanges {
                    target: indicator
                    visible: true
                }
            },
            State {
                name: "1"
                PropertyChanges {
                    target: goBtn
                    state: "1"

                    onClicked: function(){
                        goBtn.stopgoing()
                    }
                }
            },
            State {
                name: "2"
                PropertyChanges {
                    target: goBtn
                    text: "2"

                    onClicked: function(){
                        goBtn.gotopage()
                    }
                }
                PropertyChanges {
                    target: indicator
                    visible: false
                }
            },
            State {
                name: "3"
                PropertyChanges {
                    target: goBtn
                    text: "3"

                    onClicked: function(){
                        goBtn.gotopage()
                    }
                }
                PropertyChanges {
                    target: indicator
                    visible: true
                }
            },
            State {
                name: "4"
                PropertyChanges {
                    target: goBtn
                    text: "4"

                    onClicked: function(){
                        goBtn.gotopage()
                    }
                }
                PropertyChanges {
                    target: indicator
                    visible: false
                }
            },
            State {
                name: "5"
                PropertyChanges {
                    target: goBtn
                    text: "5"

                    onClicked: function(){
                        goBtn.gotopage()
                    }
                }
                PropertyChanges {
                    target: indicator
                    visible: false
                }
            }
        ]

        BusyIndicator {
            id: indicator
            visible: false
            width: parent.width
            height: parent.height
        }
    }

    WebView {
        id: browser
        y: topBarHeight
        width: parent.width
        height: parent.height - topBarHeight
        onLoadingChanged: function(){
            goBtn.state = String(loadRequest.status < 6 ? loadRequest.status : 5).charAt(0)
            urlInput.text = browser.url
        }
    }
}
