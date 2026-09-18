import QtQuick

// Stub: GlobalShortcut is Hyprland-only.
// On River, shortcuts are handled by river config directly.
Item {
    property string name: ""
    property string description: ""
    signal pressed
    signal released
    visible: false
}
