import QtQuick
import Quickshell

PanelWindow {
  id: popup
  required property var appState
  anchors { bottom: true; right: true }
  margins { right: 54; bottom: 8 }
  implicitWidth: 280
  implicitHeight: 260
  visible: appState.calendarOpen
  aboveWindows: true
  exclusiveZone: 0
  focusable: false
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    radius: 14
    color: appState.surfaceSolid
    border.width: 2
    border.color: appState.border

    Column {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8
      Row {
        width: parent.width
        Text { width: parent.width - close.width; text: Qt.formatDateTime(appState.now, "MMMM yyyy"); color: appState.fg; font.family: appState.fontFamily; font.bold: true }
        TextButton { id: close; appState: popup.appState; text: "x"; onClicked: appState.calendarOpen = false }
      }
      Grid {
        width: parent.width
        columns: 7
        rowSpacing: 4
        columnSpacing: 4
        Repeater {
          model: ["M", "T", "W", "T", "F", "S", "S"]
          delegate: Text { width: 32; height: 18; text: modelData; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 12; horizontalAlignment: Text.AlignHCenter }
        }
        Repeater {
          model: appState.calendarDays(appState.now)
          delegate: Rectangle {
            required property var modelData
            width: 32
            height: 24
            radius: 4
            color: modelData.today ? appState.accent : "transparent"
            Text { anchors.centerIn: parent; text: modelData.text; color: modelData.today ? appState.inverse : appState.fg; font.family: appState.fontFamily; font.pixelSize: 14 }
          }
        }
      }
    }
  }
}
