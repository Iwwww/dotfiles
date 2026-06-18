import QtQuick

MouseArea {
  required property var appState
  width: 34
  height: 58
  onClicked: appState.calendarOpen = !appState.calendarOpen

  Column {
    anchors.centerIn: parent
    width: parent.width
    Text { anchors.horizontalCenter: parent.horizontalCenter; text: Qt.formatDateTime(appState.now, "hh"); color: appState.fg; font.family: appState.fontFamily; font.pixelSize: 16; font.bold: true }
    Rectangle { anchors.horizontalCenter: parent.horizontalCenter; width: parent.width - 8; height: 1; color: appState.border }
    Text { anchors.horizontalCenter: parent.horizontalCenter; text: Qt.formatDateTime(appState.now, "mm"); color: appState.fg; font.family: appState.fontFamily; font.pixelSize: 16; font.bold: true }
    Text { anchors.horizontalCenter: parent.horizontalCenter; text: Qt.formatDateTime(appState.now, "dd"); color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 16; font.bold: true }
  }
}
