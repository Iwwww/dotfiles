pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Caelestia.Config
import qs.components
import qs.services

StyledClippingRect {
    id: root

    required property ShellScreen screen
    required property bool fullscreen

    property var tags: []

    implicitWidth: Tokens.sizes.bar.innerWidth
    implicitHeight: layout.implicitHeight + Tokens.padding.small

    color: "transparent"

    function parseTags(text) {
        try {
            var trimmed = String(text).trim();
            if (trimmed.length > 0) root.tags = JSON.parse(trimmed);
        } catch(e) {}
    }

    Process {
        id: tagsProc
        running: true
        command: ["sh", Quickshell.shellPath("scripts/river-tags-stream")]
        onRunningChanged: if (!running) running = true
    }

    FileView {
        id: tagsFile
        path: "/tmp/quickshell-tags.json"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.parseTags(text())
    }

    ColumnLayout {
        id: layout

        anchors.centerIn: parent
        spacing: 3

        Repeater {
            model: root.tags

            delegate: ColumnLayout {
                id: tagDelegate

                required property var modelData
                required property int index

                readonly property string tagId: modelData.id
                readonly property string tagClass: modelData.class || "tag"
                readonly property bool isFocused: tagClass.indexOf("focused") >= 0
                readonly property bool isOccupied: tagClass.indexOf("occupied") >= 0
                readonly property bool isUrgent: tagClass.indexOf("urgent") >= 0

                Layout.alignment: Qt.AlignHCenter

                property string _prevClass: ""

                onTagClassChanged: {
                    var wasUrgent = _prevClass.indexOf("urgent") >= 0;
                    _prevClass = tagClass;
                    if (isUrgent && !wasUrgent) urgentFlash.restart();
                }
                Component.onCompleted: _prevClass = tagClass

                Rectangle {
                    id: tagBg
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: Tokens.sizes.bar.innerWidth - 4
                    Layout.preferredHeight: 28

                    radius: 6
                    border.width: 1
                    border.color: tagDelegate.isFocused ? "#f3a131"
                               : tagDelegate.isUrgent ? "#f56c7c"
                               : "#bd586e75"
                    color: tagDelegate.isFocused ? "#f3a131"
                         : tagDelegate.isUrgent ? "#f0661c20"
                         : "#a3151a1f"

                    Behavior on color { ColorAnimation { duration: 200 } }
                    Behavior on border.color { ColorAnimation { duration: 200 } }

                    StyledText {
                        id: tagText
                        anchors.centerIn: parent
                        z: 1
                        text: tagDelegate.tagId
                        color: tagDelegate.isFocused ? "#000000"
                             : tagDelegate.isOccupied || tagDelegate.isUrgent ? "#fdf6e3"
                             : "#b8b8b8"
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                        font.weight: tagDelegate.isFocused ? Font.Black : Font.Bold
                        font.pixelSize: 13

                        Behavior on color { ColorAnimation { duration: 300 } }
                    }

                    Rectangle {
                        id: flashOverlay
                        anchors.fill: parent
                        radius: parent.radius
                        color: "#f56c7c"
                        opacity: 0
                    }

                    SequentialAnimation {
                        id: urgentFlash
                        PropertyAction { target: flashOverlay; property: "opacity"; value: 0.85 }
                        PropertyAction { target: tagText; property: "color"; value: "#000000" }
                        PauseAnimation { duration: 1000 }
                        ParallelAnimation {
                            NumberAnimation { target: flashOverlay; property: "opacity"; to: 0.25; duration: 600; easing.type: Easing.OutCubic }
                            ColorAnimation { target: tagText; property: "color"; to: "#fdf6e3"; duration: 600 }
                        }
                        NumberAnimation { target: flashOverlay; property: "opacity"; to: 0; duration: 400; easing.type: Easing.OutCubic }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: if (!tagDelegate.isFocused) tagBg.color = "#f52c6285"
                        onExited: tagBg.color = tagDelegate.isFocused ? "#f3a131"
                                              : tagDelegate.isUrgent ? "#f0661c20"
                                              : "#a3151a1f"
                        onClicked: commandRunner.exec(["riverctl", "set-focused-tags", String(1 << (parseInt(tagDelegate.tagId) - 1))])
                    }
                }
            }
        }
    }

    Process {
        id: commandRunner
    }
}
