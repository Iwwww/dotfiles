import QtQuick
import Quickshell
import Quickshell.Io

Item {
  id: state

  ListModel { id: tagModel }

  readonly property string fontFamily: "JetBrainsMono Nerd Font"
  readonly property string configDir: "/home/mikhail/.config/quickshell"
  readonly property color bg: "#000000"
  readonly property color bgSoft: "#25282b"
  readonly property color surface: "#a3151a1f"
  readonly property color surfaceSolid: "#151a1f"
  readonly property color hover: "#f52c6285"
  readonly property color border: "#586e75"
  readonly property color fg: "#fdf6e3"
  readonly property color muted: "#b8b8b8"
  readonly property color inverse: "#000000"
  readonly property color accent: "#f3a131"
  readonly property color critical: "#f56c7c"
  readonly property color dangerBg: "#f0661c20"
  readonly property color warningBg: "#f0663e0c"
  readonly property color success: "#859900"

  property alias tags: tagModel
  property string layoutName: "river"
  property string _rawLayout: ""
  property string mediaActivePlayer: ""
  property var media: ({ class: "stopped", text: "", title: "", artist: "", album: "", art: "", player: "", length: 0, position: 0, progress: 0, players: [] })
  property var volume: ({ muted: false, text: "?", value: 0 })
  property var powerProfile: ({ available: false, class: "missing", profile: "", text: "" })
  property var stats: ({ cpu: [], ram: [], temp: [], top: [], cpuNow: 0, ramNow: 0, tempNow: 0, tempClass: "normal" })
  property bool mediaPopupPinned: false
  property bool mediaPopupHovered: false
  property bool statsPopupPinned: false
  property bool statsPopupHovered: false
  property bool calendarOpen: false
  property date now: new Date()

  function safeJson(text, fallback) {
    try {
      var trimmed = String(text).trim();
      return trimmed.length ? JSON.parse(trimmed) : fallback;
    } catch (e) {
      console.log("json parse failed: " + e + ": " + text);
      return fallback;
    }
  }

  function updateTags(next) {
    tags.clear();
    if (!next || next.length === 0) return;
    for (var i = 0; i < next.length; i++) {
      var tag = next[i];
      tags.append({ tagId: String(tag.id), tagClass: String(tag.class || "tag") });
    }
    console.log("tags updated: " + next.length);
  }

  function run(args) { commandRunner.exec(args); }
  function runShell(command) { run(["sh", "-c", command]); }
  function clampPercent(v) { return Math.max(0, Math.min(100, Number(v) || 0)); }
  function metricClass(v) { return v >= 90 ? "critical" : v >= 75 ? "warning" : "normal"; }
  function metricBg(v) { return metricClass(v) === "critical" ? dangerBg : metricClass(v) === "warning" ? warningBg : surface; }
  function metricBorder(v) { return metricClass(v) === "critical" ? critical : metricClass(v) === "warning" ? accent : border; }
  function fmt2(n) { var v = Math.round(Number(n) || 0); return v >= 100 ? "00" : (v < 10 ? "0" + v : String(v)); }
  function mediaPopupVisible() { return media.class !== "stopped" && (mediaPopupPinned || mediaPopupHovered); }
  function statsPopupVisible() { return statsPopupPinned || statsPopupHovered; }
  function closeMediaPopupIfUnpinned() { if (!mediaPopupPinned) mediaPopupHovered = false; }
  function closeStatsPopupIfUnpinned() { if (!statsPopupPinned) statsPopupHovered = false; }

  function calendarDays(date) {
    var year = date.getFullYear();
    var month = date.getMonth();
    var first = new Date(year, month, 1);
    var firstDay = (first.getDay() + 6) % 7;
    var daysInMonth = new Date(year, month + 1, 0).getDate();
    var out = [];
    for (var i = 0; i < firstDay; i++) out.push({ text: "", today: false });
    for (var d = 1; d <= daysInMonth; d++) out.push({ text: String(d), today: d === now.getDate() && month === now.getMonth() && year === now.getFullYear() });
    while (out.length % 7 !== 0) out.push({ text: "", today: false });
    return out;
  }

  function switchTag(id) {
    run(["river-tag-switch", String(id)]);
  }

  function playerctl(action, player) {
    var args = ["playerctl"];
    var p = player || mediaActivePlayer || media.player;
    if (p && p.length > 0) args.push("-p", p);
    args.push(action);
    run(args);
  }

  function switchMediaPlayer(player) {
    mediaActivePlayer = player;
    refreshMedia();
  }

  function refreshMedia() {
    mediaProcess.exec({
      command: ["sh", configDir + "/scripts/media-state"],
      environment: ({ ACTIVE_PLAYER: mediaActivePlayer })
    });
  }

  function refreshVolume() { volumeProcess.exec(["sh", configDir + "/scripts/volume-state"]); }
  function volumeScroll(up) { run(["pamixer", up ? "--increase" : "--decrease", "5"]); refreshVolume(); }
  function toggleMute() { run(["pamixer", "--toggle-mute"]); refreshVolume(); }

  Process { id: commandRunner }

  Process {
    id: layoutProcess
    running: true
    command: ["sh", state.configDir + "/scripts/river-layout-stream"]
    onRunningChanged: if (!running) running = true
  }
  FileView {
    id: layoutFile
    path: "/tmp/quickshell-layout.txt"
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
      var l = String(text()).trim();
      state._rawLayout = l;
      if (l.length > 0) state.layoutName = l;
    }
  }

  Process {
    id: tagsProcess
    running: true
    command: ["sh", state.configDir + "/scripts/river-tags-stream"]
    onStarted: console.log("tags stream started")
    onRunningChanged: if (!running) running = true
  }
  FileView {
    id: tagsFile
    path: "/tmp/quickshell-tags.json"
    watchChanges: true
    onFileChanged: reload()
    onLoaded: { console.log("tags loaded"); state.updateTags(state.safeJson(text(), [])); }
  }

  Process {
    id: mediaProcess
    onExited: mediaFile.reload()
  }
  FileView {
    id: mediaFile
    path: "/tmp/quickshell-media.json"
    onLoaded: state.media = state.safeJson(text(), state.media)
  }

  Process {
    id: volumeProcess
    onExited: volumeFile.reload()
  }
  FileView {
    id: volumeFile
    path: "/tmp/quickshell-volume.json"
    onLoaded: state.volume = state.safeJson(text(), state.volume)
  }

  Process {
    running: true
    command: ["sh", state.configDir + "/scripts/stats-state"]
    onRunningChanged: if (!running) running = true
  }
  FileView {
    id: statsFile
    path: "/tmp/quickshell-stats.json"
    watchChanges: true
    onFileChanged: reload()
    onLoaded: { console.log("stats loaded"); state.stats = state.safeJson(text(), state.stats); }
  }

  Process {
    id: powerProcess
    onExited: powerFile.reload()
  }
  FileView {
    id: powerFile
    path: "/tmp/quickshell-power.json"
    onLoaded: state.powerProfile = state.safeJson(text(), state.powerProfile)
  }

  Timer { running: true; repeat: true; interval: 1000; triggeredOnStart: true; onTriggered: refreshMedia() }
  Timer { running: true; repeat: true; interval: 1500; triggeredOnStart: true; onTriggered: refreshVolume() }
  Timer { running: true; repeat: true; interval: 30000; triggeredOnStart: true; onTriggered: powerProcess.exec(["sh", state.configDir + "/scripts/power-profile-state"]) }


  SystemClock { precision: SystemClock.Minutes; onDateChanged: state.now = date }
}
