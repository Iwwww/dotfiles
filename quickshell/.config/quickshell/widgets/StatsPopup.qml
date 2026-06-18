import QtQuick
import Quickshell

PanelWindow {
  id: popup
  required property var appState
  anchors { bottom: true; right: true }
  margins { right: 46; bottom: 0 }
  implicitWidth: 300
  implicitHeight: 420
  visible: appState.statsPopupVisible()
  aboveWindows: true
  exclusiveZone: 0
  focusable: false
  color: "transparent"

  PopupCard {
    appState: popup.appState
    anchors.fill: parent

    MouseArea { anchors.fill: parent; hoverEnabled: true; acceptedButtons: Qt.NoButton; onEntered: appState.statsPopupHovered = true; onExited: appState.closeStatsPopupIfUnpinned() }

    Column {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 8
      Row {
        width: parent.width
        height: 22
        Text { width: parent.width - closeStats.width; text: "System Stats"; color: appState.fg; font.family: appState.fontFamily; font.bold: true }
        TextButton { id: closeStats; appState: popup.appState; visible: appState.statsPopupPinned; text: "x"; onClicked: { appState.statsPopupPinned = false; appState.statsPopupHovered = false; } }
      }

      ChartSection { appState: popup.appState; width: parent.width; title: " CPU " + Math.round(appState.stats.cpuNow) + "%"; values: appState.stats.cpu; colorBar: appState.accent; level: appState.metricClass(appState.stats.cpuNow) }
      ChartSection { appState: popup.appState; width: parent.width; title: " RAM " + Math.round(appState.stats.ramNow) + "%"; values: appState.stats.ram; colorBar: appState.accent; level: appState.metricClass(appState.stats.ramNow) }
      ChartSection { appState: popup.appState; width: parent.width; title: " Temp " + Math.round(appState.stats.tempNow) + "°"; values: appState.stats.temp; colorBar: appState.critical; level: appState.stats.tempClass }

      Rectangle {
        width: parent.width
        height: 112
        radius: 8
        color: appState.surface
        Column {
          anchors.fill: parent
          anchors.margins: 8
          spacing: 3
          Row {
            width: parent.width
            Text { width: parent.width - 104; text: "Top"; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 13 }
            Text { width: 52; text: "cpu"; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; horizontalAlignment: Text.AlignRight }
            Text { width: 52; text: "mem"; color: appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; horizontalAlignment: Text.AlignRight }
          }
          Repeater {
            model: appState.stats.top
            delegate: Row {
              required property var modelData
              width: parent.width
              Text { width: parent.width - 104; text: modelData.name; color: appState.fg; font.family: appState.fontFamily; font.pixelSize: 13; elide: Text.ElideRight }
              Text { width: 52; text: modelData.cpu + "%"; color: modelData.cpu >= 60 ? appState.critical : modelData.cpu >= 25 ? appState.accent : appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; horizontalAlignment: Text.AlignRight }
              Text { width: 52; text: modelData.ram + "%"; color: modelData.ram >= 60 ? appState.critical : modelData.ram >= 25 ? appState.accent : appState.muted; font.family: appState.fontFamily; font.pixelSize: 13; horizontalAlignment: Text.AlignRight }
            }
          }
        }
      }
    }
  }
}
