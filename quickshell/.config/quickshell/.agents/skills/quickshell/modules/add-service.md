# Add Service

Интеграция системных сервисов. Все сервисы выносить в `Singleton`.

## Pipewire (аудио)

```qml
// Audio.qml
pragma Singleton
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
  property var defaultSource: Pipewire.defaultAudioSource
  property var defaultSink: Pipewire.defaultAudioSink
  readonly property real volume: defaultSink?.audio?.volume ?? 0
  readonly property bool muted: defaultSink?.audio?.muted ?? true

  function refreshDefaults() {
    defaultSource = Pipewire.defaultAudioSource
    defaultSink = Pipewire.defaultAudioSink
  }

  function setVolume(v) { if (defaultSink?.audio) defaultSink.audio.volume = v }
  function toggleMute() { if (defaultSink?.audio) defaultSink.audio.muted = !defaultSink.audio.muted }

  Connections {
    target: Pipewire
    function onDefaultAudioSourceChanged() { refreshDefaults() }
    function onDefaultAudioSinkChanged() { refreshDefaults() }
  }
}
```

## UPower (батарея)

```qml
// Battery.qml
pragma Singleton
import Quickshell.Services.UPower
import QtQuick

Singleton {
  property var battery: null

  Component.onCompleted: {
    for (const d of UPower.devices) {
      if (d.kind === UPowerDeviceType.Battery) {
        battery = d
        break
      }
    }
  }

  readonly property real percent: battery?.percentage ?? -1
  readonly property bool charging: battery?.state === UPowerDeviceState.Charging
  readonly property bool pluggedIn: battery?.state === UPowerDeviceState.PluggedIn
}
```

## NetworkManager

```qml
// Network.qml
pragma Singleton
import Quickshell.Networking
import QtQuick

Singleton {
  readonly property var primary: Networking.primaryDevice
  readonly property bool online: Networking.connectivity === NetworkConnectivity.Full
  readonly property string ssid: {
    const wifi = primary
    return wifi?.ssid ?? ""
  }
}
```

## Bluetooth

```qml
// Bluetooth.qml
pragma Singleton
import Quickshell.Bluetooth
import QtQuick

Singleton {
  readonly property bool powered: Bluetooth.adapters[0]?.powered ?? false
  readonly property var devices: Bluetooth.devices

  function toggle() {
    const a = Bluetooth.adapters[0]
    if (a) a.powered = !a.powered
  }
}
```

## Notifications (нотификации)

```qml
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

PopupWindow {
  id: notifPopup
  Repeater {
    model: NotificationServer.activeNotifications
    delegate: Rectangle {
      required property Notification modelData
      width: 300; height: 60
      color: "#313244"
      Text {
        text: `${modelData.summary}: ${modelData.body}`
        color: "#cdd6f4"
        wrapMode: Text.WordWrap
      }
    }
  }
}
```

## Если API непонятен — см.

- [Pipewire](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Pipewire/Pipewire)
- [PwNode](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Pipewire/PwNode)
- [PwNodeAudio](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Pipewire/PwNodeAudio)
- [Notifications](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Notifications)
- [Mpris](https://quickshell.org/docs/v0.3.0/types/Quickshell.Services.Mpris/Mpris)
