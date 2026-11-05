import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Light-theme operational KPI: all counters and totals come from C++.
Rectangle {
    id: card
    property string metricLabel: ""
    property string value: ""
    property string note: ""
    property string metricIcon: "Overview"
    property color accent: colors.navy
    property bool compact: false
    DesignTokens { id: colors }
    Layout.fillWidth: true
    Layout.minimumWidth: 174
    Layout.preferredHeight: compact ? 90 : 116
    radius: 12
    color: colors.surface
    border.width: 1
    border.color: colors.border
    Accessible.role: Accessible.StaticText
    Accessible.name: metricLabel + ": " + value + ". " + note
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: card.compact ? 9 : 13
        spacing: card.compact ? 2 : 4
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            Rectangle {
                Layout.preferredWidth: card.compact ? 24 : 32
                Layout.preferredHeight: card.compact ? 24 : 32
                radius: 8
                color: colors.quietSurface
                SidebarGlyph {
                    anchors.centerIn: parent
                    kind: card.metricIcon
                    glyphColor: card.accent
                    width: card.compact ? 17 : 20
                    height: card.compact ? 17 : 20
                }
            }
            Label {
                text: card.metricLabel
                color: colors.navy
                font.pixelSize: card.compact ? 11 : 13
                font.weight: Font.DemiBold
                Layout.fillWidth: true
                elide: Text.ElideRight
            }
        }
        Label {
            objectName: "overviewMetricValue"
            text: card.value
            color: card.accent
            font.pixelSize: card.compact ? 19 : 27
            font.weight: Font.DemiBold
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        Label {
            text: card.note
            color: colors.ink
            font.pixelSize: 11
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }
}
