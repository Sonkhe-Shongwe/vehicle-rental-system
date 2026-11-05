import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Direction A: compact contract/fleet facts, not navigation shortcuts.
Rectangle {
    id: card
    property string metricLabel: ""
    property string value: ""
    property string note: ""
    property string metricIcon: ""
    property color accent: colors.navy
    property bool compact: false
    DesignTokens { id: colors }
    Layout.fillWidth: true
    Layout.minimumWidth: 130
    radius: 13
    color: colors.surface
    border.color: colors.border
    border.width: 1
    Accessible.role: Accessible.StaticText
    Accessible.name: metricLabel + ": " + value + ". " + note
    Rectangle {
        x: 14
        y: 14
        width: 3
        height: parent.height - 28
        radius: 1.5
        color: card.accent
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: card.compact ? 27 : 31
        anchors.rightMargin: 13
        anchors.topMargin: card.compact ? 7 : 10
        anchors.bottomMargin: card.compact ? 7 : 9
        spacing: 1
        Label {
            text: card.metricLabel.toUpperCase()
            color: colors.ink
            font.pixelSize: 10
            font.weight: Font.DemiBold
            font.letterSpacing: 0.8
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        Label {
            objectName: "overviewMetricValue"
            text: card.value
            color: card.accent
            font.pixelSize: card.compact ? 21 : 28
            font.weight: Font.DemiBold
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        Label {
            text: card.note
            color: colors.ink
            font.pixelSize: card.compact ? 10 : 11
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }
}
