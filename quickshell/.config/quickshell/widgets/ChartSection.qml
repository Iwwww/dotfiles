import QtQuick

Column {
  required property var appState
  required property string title
  required property var values
  required property color colorBar
  required property string level
  height: 78
  spacing: 2

  Text {
    width: parent.width
    text: title
    color: level === "critical" ? appState.critical : level === "warning" ? appState.accent : appState.muted
    font.family: appState.fontFamily
    font.pixelSize: 13
  }

  Rectangle {
    width: parent.width
    height: 56
    color: appState.surface
    border.width: 1
    border.color: appState.border
    Row {
      anchors.fill: parent
      anchors.topMargin: 1
      spacing: 1
      Repeater {
        model: values
        delegate: Item {
          required property real modelData
          width: Math.max(3, parent.width / Math.max(1, values.length) - 1)
          height: parent.height
          Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
              height: parent.height * appState.clampPercent(modelData) / 100
            radius: 1
            color: colorBar
          }
        }
      }
    }
  }
}
