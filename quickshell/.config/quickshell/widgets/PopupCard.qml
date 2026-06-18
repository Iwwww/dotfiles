import QtQuick

Rectangle {
  required property var appState
  radius: 14
  color: appState.bgSoft
  border.width: 2
  border.color: appState.border
  gradient: Gradient {
    orientation: Gradient.Horizontal
    GradientStop { position: 0.0; color: "#d91e1e1e" }
    GradientStop { position: 1.0; color: appState.bgSoft }
  }
}
