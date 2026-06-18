import QtQuick

Rectangle {
  id: button
  required property var appState
  signal clicked()
  property alias text: label.text
  property bool active: false
  property bool big: false
  property bool bigger: false
  width: Math.max(24, label.implicitWidth + 16)
  height: bigger ? 34 : 28
  radius: 8
  color: "transparent"

  Text {
    id: label
    anchors.centerIn: parent
    color: button.active ? appState.accent : appState.fg
    font.family: appState.fontFamily
    font.pixelSize: button.bigger ? 20 : button.big ? 16 : 13
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: button.color = appState.hover
    onExited: button.color = "transparent"
    onClicked: button.clicked()
  }
}
