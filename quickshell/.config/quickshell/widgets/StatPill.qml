import QtQuick

ModuleBox {
  id: pill
  required property string label
  required property real value
  property bool _wasCritical: false
  height: 27
  bg: appState.metricBg(value)
  borderColor: appState.metricBorder(value)

  onValueChanged: {
    var isCritical = value >= 90;
    if (isCritical && !_wasCritical) criticalPulse.restart();
    _wasCritical = isCritical;
  }

  Rectangle {
    id: pulseOverlay
    anchors.fill: parent
    radius: parent.radius
    color: appState.critical
    opacity: 0
  }

  SequentialAnimation {
    id: criticalPulse
    loops: 5
    NumberAnimation { target: pulseOverlay; property: "opacity"; from: 0; to: 0.4; duration: 300; easing.type: Easing.InOutQuad }
    NumberAnimation { target: pulseOverlay; property: "opacity"; from: 0.4; to: 0; duration: 700; easing.type: Easing.InOutQuad }
  }

  Text {
    anchors.centerIn: parent
    z: 1
    text: pill.label
    color: appState.fg
    font.family: appState.fontFamily
    font.pixelSize: 13
    font.bold: true
  }
}
