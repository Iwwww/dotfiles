import QtQuick
import Quickshell

PanelWindow {
  id: popup
  required property var appState
  anchors { top: true; bottom: true; right: true }
  implicitWidth: 280
  visible: appState.mediaPopupVisible()
  aboveWindows: true
  exclusiveZone: 0
  focusable: false
  color: "transparent"

  PopupCard {
    appState: popup.appState
    width: 280
    height: 320
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter

    MouseArea { anchors.fill: parent; hoverEnabled: true; acceptedButtons: Qt.NoButton; onEntered: appState.mediaPopupHovered = true; onExited: appState.closeMediaPopupIfUnpinned() }

    Column {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8
      Row {
        width: parent.width
        height: 22
        Text { width: parent.width - closeMedia.width; text: appState.media.player; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; elide: Text.ElideRight }
        TextButton { id: closeMedia; appState: popup.appState; visible: appState.mediaPopupPinned; text: "x"; onClicked: { appState.mediaPopupPinned = false; appState.mediaPopupHovered = false; } }
      }
      Image { visible: appState.media.art.length > 0; anchors.horizontalCenter: parent.horizontalCenter; width: 160; height: visible ? 160 : 0; source: appState.media.art.length > 0 ? "file://" + appState.media.art : ""; fillMode: Image.PreserveAspectCrop }
      Column {
        width: parent.width
        spacing: 2
        Text { width: parent.width; horizontalAlignment: Text.AlignHCenter; text: appState.media.title; color: appState.fg; font.family: appState.fontFamily; font.pixelSize: 15; font.bold: true; elide: Text.ElideRight }
        Text { width: parent.width; horizontalAlignment: Text.AlignHCenter; text: appState.media.artist; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; elide: Text.ElideRight }
      }
      Rectangle { visible: appState.media.length > 0; width: parent.width; height: visible ? 4 : 0; radius: 2; color: appState.surface; Rectangle { width: parent.width * appState.clampPercent(appState.media.progress) / 100; height: parent.height; radius: 2; color: appState.accent } }
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 12
        TextButton { appState: popup.appState; text: "󰒮"; big: true; onClicked: appState.playerctl("previous") }
        TextButton { appState: popup.appState; text: appState.media.class === "playing" ? "󰏤" : "󰐊"; bigger: true; onClicked: appState.playerctl("play-pause") }
        TextButton { appState: popup.appState; text: "󰒭"; big: true; onClicked: appState.playerctl("next") }
      }
      Row {
        visible: appState.media.players.length > 0
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 6
        Repeater {
          model: appState.media.players
          delegate: TextButton {
            required property var modelData
            appState: popup.appState
            text: modelData.name
            active: modelData.name === appState.media.player || modelData.name === appState.mediaActivePlayer
            onClicked: appState.switchMediaPlayer(modelData.name)
          }
        }
      }
    }
  }
}
