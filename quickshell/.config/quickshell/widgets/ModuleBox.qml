import QtQuick

Rectangle {
  required property var appState
  property color bg: appState.surface
  property color borderColor: "transparent"
  radius: 6
  color: bg
  border.width: borderColor === "transparent" ? 0 : 1
  border.color: borderColor
}
