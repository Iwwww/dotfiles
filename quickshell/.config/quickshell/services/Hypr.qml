pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// River WM stub replacing Hyprland integration.
// Provides the same interface that the rest of the shell expects
// but backed by ristate / river-tag-switch instead of Hyprland IPC.

Singleton {
    id: root

    // Stubbed collections — empty, but typed so callers don't crash
    readonly property var toplevels: ({ values: [] })
    readonly property var workspaces: ({ values: [] })
    readonly property var monitors: ({ values: [] })
    readonly property bool usingLua: false

    // No active toplevel tracking on River
    readonly property var activeToplevel: null
    readonly property var focusedWorkspace: null
    readonly property var focusedMonitor: null
    readonly property int activeWsId: 1

    // Keyboard state — read from /sys or stubbed
    readonly property bool capsLock: false
    readonly property bool numLock: false
    readonly property string defaultKbLayout: _layout
    readonly property string kbLayoutFull: _layout
    readonly property string kbLayout: _layout

    property string _layout: "??"

    signal configReloaded

    function dispatch(request: string): void {
        console.warn("[Hypr stub] dispatch not available on River:", request);
    }

    function cycleSpecialWorkspace(direction: string): void {}

    function monitorNames(): list<string> {
        return [];
    }

    function monitorFor(screen: ShellScreen): var {
        return null;
    }

    function reloadDynamicConfs(): void {}

    // Read keyboard layout from ristate
    Process {
        id: layoutProc
        running: true
        command: ["ristate", "--layout"]
        stdout: SplitParser {
            onRead: data => {
                try {
                    var obj = JSON.parse(data);
                    if (obj.layout) root._layout = obj.layout;
                } catch(e) {}
            }
        }
        onRunningChanged: if (!running) running = true
    }
}
