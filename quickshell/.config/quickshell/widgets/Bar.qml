import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

PanelWindow {
  id: bar
  required property var appState

  anchors { top: true; bottom: true; right: true }
  implicitWidth: 46
  exclusiveZone: 46
  focusable: false
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    gradient: Gradient {
      orientation: Gradient.Vertical
      GradientStop { position: 0.0; color: appState.bg }
      GradientStop { position: 0.95; color: appState.bgSoft }
      GradientStop { position: 1.0; color: appState.bg }
    }

    Item {
      anchors.fill: parent
      anchors.margins: 6

      Column {
        anchors.top: parent.top
        width: parent.width
        spacing: 6

        ModuleBox {
          appState: bar.appState
          width: parent.width
          height: 18
          Text {
            anchors.centerIn: parent
            text: appState.layoutName.slice(0, 4)
            color: appState.fg
            font.family: appState.fontFamily
            font.pixelSize: 10
            font.bold: true
          }
        }

        Column {
          width: parent.width
          spacing: 3
          Repeater {
            model: appState.tags
            delegate: Rectangle {
              required property string tagId
              required property string tagClass
              readonly property string tagClassResolved: tagClass || "tag"
              width: parent.width
              height: 28
              radius: 6
              border.width: 1
              border.color: tagClassResolved.indexOf("focused") >= 0 ? appState.accent : tagClassResolved.indexOf("urgent") >= 0 ? appState.critical : appState.border
              color: tagClassResolved.indexOf("focused") >= 0 ? appState.accent : tagClassResolved.indexOf("urgent") >= 0 ? appState.dangerBg : appState.surface

              Text {
                anchors.centerIn: parent
                text: tagId
                color: tagClassResolved.indexOf("focused") >= 0 ? appState.inverse : tagClassResolved.indexOf("occupied") >= 0 || tagClassResolved.indexOf("urgent") >= 0 ? appState.fg : appState.muted
                font.family: appState.fontFamily
                font.pixelSize: 13
                font.weight: tagClassResolved.indexOf("focused") >= 0 ? Font.Black : Font.Bold
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = tagClassResolved.indexOf("focused") >= 0 ? appState.accent : appState.hover
                onExited: parent.color = tagClassResolved.indexOf("focused") >= 0 ? appState.accent : tagClassResolved.indexOf("urgent") >= 0 ? appState.dangerBg : appState.surface
                onClicked: appState.switchTag(tagId)
              }
            }
          }
        }
      }

      Column {
        anchors.bottom: parent.bottom
        width: parent.width
        spacing: 6

        ModuleBox {
          appState: bar.appState
          visible: appState.media.class !== "stopped"
          width: parent.width
          height: visible ? 30 : 0
          Text {
            anchors.centerIn: parent
            text: appState.media.class === "playing" ? "󰎈" : appState.media.class === "paused" ? "󰏤" : "󰐊"
            color: appState.media.class === "playing" ? appState.success : appState.muted
            font.family: appState.fontFamily
            font.pixelSize: 15
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onEntered: appState.mediaPopupHovered = true
            onExited: appState.closeMediaPopupIfUnpinned()
            onClicked: function(mouse) {
              if (mouse.button === Qt.RightButton) appState.playerctl("play-pause");
              else appState.mediaPopupPinned = !appState.mediaPopupPinned;
            }
          }
        }

        Column {
          width: parent.width
          spacing: 4
          MouseArea {
            width: parent.width
            height: statsColumn.height
            hoverEnabled: true
            onEntered: appState.statsPopupHovered = true
            onExited: appState.closeStatsPopupIfUnpinned()
            onClicked: appState.statsPopupPinned = !appState.statsPopupPinned
            Column {
              id: statsColumn
              width: parent.width
              spacing: 4
              StatPill { appState: bar.appState; width: parent.width; label: " " + appState.fmt2(appState.stats.cpuNow); value: appState.stats.cpuNow }
              StatPill { appState: bar.appState; width: parent.width; label: " " + appState.fmt2(appState.stats.ramNow); value: appState.stats.ramNow }
              StatPill { appState: bar.appState; width: parent.width; visible: appState.stats.tempClass !== "normal"; label: Math.round(appState.stats.tempNow) + "°"; value: appState.stats.tempNow }
            }
          }
        }

        Rectangle {
          width: 10
          height: 24
          radius: 6
          anchors.horizontalCenter: parent.horizontalCenter
          color: appState.volume.muted ? appState.surface : "transparent"
          clip: true
          Rectangle {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height * appState.clampPercent(appState.volume.value) / 100
            radius: appState.volume.value >= 100 ? 6 : 0
            color: appState.volume.muted ? appState.muted : appState.accent
          }
          Text {
            anchors.centerIn: parent
            text: appState.volume.muted ? "󰝟" : appState.volume.text
            color: appState.volume.muted ? appState.muted : appState.inverse
            font.family: appState.fontFamily
            font.pixelSize: appState.volume.muted ? 16 : 14
            font.bold: true
          }
          MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: function(mouse) { mouse.button === Qt.RightButton ? appState.run(["pavucontrol"]) : appState.toggleMute(); }
            onWheel: function(wheel) { appState.volumeScroll(wheel.angleDelta.y > 0); }
          }
        }

        ModuleBox {
          appState: bar.appState
          visible: appState.powerProfile.available
          width: parent.width
          height: visible ? 30 : 0
          bg: appState.powerProfile.class === "performance" ? appState.dangerBg : appState.powerProfile.class === "power-saver" ? appState.success : appState.hover
          borderColor: appState.powerProfile.class === "performance" ? appState.critical : "transparent"
          Text {
            anchors.centerIn: parent
            text: appState.powerProfile.text
            color: appState.powerProfile.class === "power-saver" ? appState.inverse : appState.fg
            font.family: appState.fontFamily
            font.pixelSize: 14
          }
        }

        Column {
          width: parent.width
          spacing: 6
          Repeater {
            model: SystemTray.items
            delegate: Item {
              required property var modelData
              width: parent.width
              height: 23
              IconImage { anchors.centerIn: parent; width: 21; height: 21; source: modelData.icon }
              MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: function(mouse) {
                  if (mouse.button === Qt.RightButton || modelData.onlyMenu) modelData.display(bar, 0, height);
                  else if (mouse.button === Qt.MiddleButton) modelData.secondaryActivate();
                  else modelData.activate();
                }
                onWheel: function(wheel) { modelData.scroll(wheel.angleDelta.y, false); }
              }
            }
          }
        }

        ClockWidget { appState: bar.appState; width: parent.width }
      }
    }
  }
}
