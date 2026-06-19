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

    color: Colours.tPalette.m3surfaceContainer
    radius: Tokens.rounding.full

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
        spacing: Math.floor(Tokens.spacing.extraSmall)

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

                StyledText {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.preferredHeight: Tokens.sizes.bar.innerWidth - Tokens.padding.small

                    text: tagDelegate.tagId
                    color: tagDelegate.isFocused ? Colours.palette.m3onPrimary
                         : tagDelegate.isOccupied ? Colours.palette.m3onSurface
                         : Colours.layer(Colours.palette.m3outlineVariant, 2)
                    verticalAlignment: Qt.AlignVCenter
                    font.family: Tokens.font.workspaces

                    Rectangle {
                        anchors.fill: parent
                        z: -1
                        radius: Tokens.rounding.medium
                        color: tagDelegate.isFocused ? Colours.palette.m3primary
                             : tagDelegate.isUrgent ? Colours.palette.m3error
                             : "transparent"
                        opacity: tagDelegate.isUrgent && !tagDelegate.isFocused ? 0.3 : 1

                        Behavior on color { ColorAnimation { duration: 200 } }
                        Behavior on opacity { NumberAnimation { duration: 200 } }
                    }

                    Rectangle {
                        id: flashOverlay
                        anchors.fill: parent
                        radius: Tokens.rounding.medium
                        color: Colours.palette.m3error
                        opacity: 0
                    }

                    SequentialAnimation {
                        id: urgentFlash
                        PropertyAction { target: flashOverlay; property: "opacity"; value: 0.85 }
                        PauseAnimation { duration: 800 }
                        NumberAnimation { target: flashOverlay; property: "opacity"; to: 0; duration: 600; easing.type: Easing.OutCubic }
                    }

                    MouseArea {
                        anchors.fill: parent
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
