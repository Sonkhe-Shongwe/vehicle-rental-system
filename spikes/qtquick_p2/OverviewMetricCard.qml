import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Read-only operational metric tile. The C++ model computes quantities;
 // no lifecycle or money math is performed in QML.
Rectangle {
    id: card
    property string metricLabel: ""
    property string value: ""
    property string note: ""
    property color accent: tokens.navy
    DesignTokens { id: tokens }
    Layout.fillWidth: true
    Layout.minimumWidth: 180
    Layout.preferredHeight: 134
    radius: 12
    color: tokens.surface
    border.color: tokens.border
    Accessible.role: Accessible.StaticText
    Accessible.name: metricLabel + ": " + value + ". " + note
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8
        Label {
            text: card.metricLabel
            color: tokens.ink
            font.pixelSize: 13
            font.bold: true
            Layout.fillWidth: true
        }
        Label {
            objectName: "overviewMetricValue"
            text: card.value
            color: card.accent
            font.pixelSize: 28
            font.bold: true
            Layout.fillWidth: true
        }
        Label {
            text: card.note
            color: tokens.ink
            font.pixelSize: 11
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
        }
    }
}
