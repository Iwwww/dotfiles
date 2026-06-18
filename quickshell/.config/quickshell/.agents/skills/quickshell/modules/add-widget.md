# Add Widget

Добавление UI-компонентов в существующую конфигурацию.

## Clock (через SystemClock)

```qml
// ClockWidget.qml
import QtQuick

Text {
  required property string time
  text: time
  color: "#cdd6f4"
  font.pixelSize: 14
}
```

```qml
// Time.qml — shared singleton
pragma Singleton
import Quickshell
import QtQuick

Singleton {
  readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")
  SystemClock {
    id: clock
    precision: SystemClock.Seconds  // или Minutes для экономии
  }
}
```

Использование: `text: Time.time`

## Workspaces (Hyprland)

```qml
import Quickshell.Hyprland

RowLayout {
  Repeater {
    model: Hyprland.workspaces
    delegate: Rectangle {
      required property HyprlandWorkspace modelData
      implicitWidth: 24; implicitHeight: 24
      color: modelData.active ? "#89b4fa" : "#45475a"
      radius: 6
      Text {
        anchors.centerIn: parent
        text: modelData.id
        color: "#cdd6f4"
      }
      MouseArea {
        anchors.fill: parent
        onClicked: modelData.activate()
      }
    }
  }
}
```

## System Tray

```qml
import Quickshell.Services.SystemTray

RowLayout {
  Repeater {
    model: SystemTray.items
    delegate: IconImage {
      required property SystemTrayItem modelData
      source: modelData.icon
      width: 20; height: 20
    }
  }
}
```

## PopupWindow (дропдаун меню)

```qml
PopupWindow {
  id: popup
  width: 300; height: 200
  color: "#313244"
  Rectangle {
    anchors.fill: parent
    color: parent.color
    Text { text: "menu content"; color: "#cdd6f4" }
  }
}

// открыть:
// popup.open(toggleBtn, PopupAnchor { left: true; right: true })
```

## Mpris (сейчас играет)

```qml
import Quickshell.Services.Mpris

Text {
  text: {
    const player = Mpris.players[0]
    if (!player) return "—"
    return `${player.artist} — ${player.title}`
  }
  color: "#a6adc8"
}
```

## Если API непонятен — см.

- [HyprlandWorkspace](https://quickshell.org/docs/v0.3.0/types/Quickshell.Hyprland/HyprlandWorkspace)
- [SystemClock](https://quickshell.org/docs/v0.3.0/types/Quickshell/SystemClock)
- [PopupWindow](https://quickshell.org/docs/v0.3.0/types/Quickshell/PopupWindow)
- [SystemTray](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.SystemTray/SystemTray)
