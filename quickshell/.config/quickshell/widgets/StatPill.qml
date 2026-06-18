import QtQuick

ModuleBox {
  required property string label
  required property real value
  height: 27
  bg: appState.metricBg(value)
  borderColor: appState.metricBorder(value)

  Text {
    anchors.centerIn: parent
    text: label
    color: appState.fg
    font.family: appState.fontFamily
    font.pixelSize: 13
    font.bold: true
  }
}
