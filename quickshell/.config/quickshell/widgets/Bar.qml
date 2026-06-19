import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.SystemTray
import Quickshell.Widgets

PanelWindow {
  id: bar
  required property var appState

  anchors { top: true; bottom: true; right: true }
  implicitWidth: 50
  exclusiveZone: 50
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
      anchors.margins: 0, 4

      // layout indicator
      Column {
        anchors.top: parent.top
        width: parent.width
        spacing: 4

        ModuleBox {
          appState: bar.appState
          width: parent.width
          height: 18
          Text {
            anchors.centerIn: parent
            text: appState.layoutName.slice(0, 6)
            color: appState.fg
            font.family: appState.fontFamily
            font.pixelSize: 12
            font.bold: true
          }
        }

        // tags
        Column {
          width: parent.width
          spacing: 3
          Repeater {
            model: appState.tags
            delegate: Rectangle {
              id: tagDelegate
              required property string tagId
              required property string tagClass
              readonly property string tagClassResolved: tagClass || "tag"
              readonly property bool isUrgent: tagClassResolved.indexOf("urgent") >= 0
              readonly property bool isFocused: tagClassResolved.indexOf("focused") >= 0
              property string _prevClass: ""
              width: parent.width
              height: 28
              radius: 6
              border.width: 1
              border.color: isFocused ? appState.accent : isUrgent ? appState.critical : appState.border
              color: isFocused ? appState.accent : isUrgent ? appState.dangerBg : appState.surface

              onTagClassChanged: {
                var wasUrgent = _prevClass.indexOf("urgent") >= 0;
                _prevClass = tagClassResolved;
                if (isUrgent && !wasUrgent) urgentFlash.restart();
              }
              Component.onCompleted: _prevClass = tagClassResolved

              Rectangle {
                id: flashOverlay
                anchors.fill: parent
                radius: parent.radius
                color: appState.critical
                opacity: 0
              }

              SequentialAnimation {
                id: urgentFlash
                PropertyAction { target: flashOverlay; property: "opacity"; value: 0.85 }
                PauseAnimation { duration: 1000 }
                NumberAnimation { target: flashOverlay; property: "opacity"; to: 0.25; duration: 600; easing.type: Easing.OutCubic }
                NumberAnimation { target: flashOverlay; property: "opacity"; to: 0; duration: 400; easing.type: Easing.OutCubic }
              }

              Text {
                anchors.centerIn: parent
                z: 1
                text: tagId
                color: isFocused ? appState.inverse : tagClassResolved.indexOf("occupied") >= 0 || isUrgent ? appState.fg : appState.muted
                font.family: appState.fontFamily
                font.pixelSize: 13
                font.weight: isFocused ? Font.Black : Font.Bold
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: tagDelegate.color = isFocused ? appState.accent : appState.hover
                onExited: tagDelegate.color = isFocused ? appState.accent : isUrgent ? appState.dangerBg : appState.surface
                onClicked: appState.switchTag(tagId)
              }
            }
          }
        }
      }

      // media
      Column {
        anchors.bottom: parent.bottom
        width: parent.width
        spacing: 6

        ModuleBox {
          id: mediaBox
          appState: bar.appState
          width: parent.width
          height: 30
          readonly property var activePlayer: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
          readonly property bool isPlaying: activePlayer && activePlayer.playbackState === MprisPlaybackState.Playing
          readonly property real progress: activePlayer && activePlayer.length > 0 ? activePlayer.position / activePlayer.length : 0

          Timer {
            running: mediaBox.isPlaying
            interval: 1000
            repeat: true
            onTriggered: if (mediaBox.activePlayer) mediaBox.activePlayer.positionChanged()
          }

          Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            height: parent.height
            width: parent.width * mediaBox.progress
            radius: parent.radius
            color: appState.accent
            opacity: 0.15
          }

          Text {
            anchors.centerIn: parent
            text: mediaBox.isPlaying ? "󰏤" : mediaBox.activePlayer ? "󰐊" : "󰎈"
            color: mediaBox.isPlaying ? appState.success : appState.muted
            font.family: appState.fontFamily
            font.pixelSize: 15
          }
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton | Qt.BackButton | Qt.ForwardButton
            onEntered: appState.mediaPopupHovered = true
            onExited: appState.closeMediaPopupIfUnpinned()
            onClicked: function(mouse) {
              if (mouse.button === Qt.MiddleButton) { if (mediaBox.activePlayer) mediaBox.activePlayer.togglePlaying(); }
              else if (mouse.button === Qt.RightButton || mouse.button === Qt.ForwardButton) { if (mediaBox.activePlayer) mediaBox.activePlayer.next(); }
              else if (mouse.button === Qt.BackButton) { if (mediaBox.activePlayer) mediaBox.activePlayer.previous(); }
              else appState.mediaPopupPinned = !appState.mediaPopupPinned;
            }
          }
        }

        // stats
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
          width: parent.width
          height: 24
          radius: 6
          color: appState.volume.muted ? appState.surface : "transparent"
          clip: true
          Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            height: parent.height
            width: parent.width * appState.clampPercent(appState.volume.value) / 100
            radius: 6
            color: appState.volume.muted ? appState.muted : appState.accent
          }
          Text {
            anchors.centerIn: parent
            text: appState.volume.muted ? "󰝟" : appState.volume.text
            color: appState.inverse
            font.family: appState.fontFamily
            font.pixelSize: appState.volume.muted ? 16 : 14
            font.bold: true

            layer.enabled: true
            layer.effect: MultiEffect {
              shadowEnabled: true
              shadowColor: appState.volume.muted ? appState.muted : appState.accent
              shadowBlur: 0.3
              shadowScale: 1.1
              shadowOpacity: 1.0
              shadowHorizontalOffset: 0
              shadowVerticalOffset: 0
            }
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
              height: 24
              IconImage { anchors.centerIn: parent; width: 22; height: 22; source: modelData.icon }
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
