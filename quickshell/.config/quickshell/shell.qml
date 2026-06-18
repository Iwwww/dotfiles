//@ pragma IconTheme Papirus
//@ pragma NativeTextRendering
//@ pragma AppId river-quickshell-bar

import QtQuick
import Quickshell
import "services"
import "widgets"

Scope {
  id: root

  AppState { id: app }

  Variants {
    model: Quickshell.screens

    Bar {
      required property var modelData
      screen: modelData
      appState: app
    }
  }

  MediaPopup { appState: app }
  StatsPopup { appState: app }
  CalendarPopup { appState: app }
}
