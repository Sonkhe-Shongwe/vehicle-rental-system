import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// R2 presentation only. C++ remains the source of fleet/rental values.
// Pinned, locally bundled Lucide SVG icons are used.
Rectangle {
    id: card
    property string metricLabel: ""
    property string value: ""
    property string note: ""
    property string metricIcon: ""
    property color accent: colors.teal
    property bool compact: false
    DesignTokens { id: colors }
    Layout.fillWidth: true
    Layout.minimumWidth: 170
    radius: 14
    color: colors.surface
    border.color: colors.border
    border.width: 1
    Accessible.role: Accessible.StaticText
    Accessible.name: metricLabel + ": " + value + ". " + note
    Rectangle {
        x: 13
        y: card.compact ? 10 : 13
        width: card.compact ? 27 : 32
        height: width
        radius: 9
        color: colors.quietSurface
        R2LucideIcon {
            anchors.centerIn: parent
            width: 19
            height: 19
            iconName: card.metricIcon
            tone: "emerald"
            Accessible.ignored: true
        }
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: card.compact ? 49 : 54
        anchors.rightMargin: 9
        anchors.topMargin: card.compact ? 7 : 10
        anchors.bottomMargin: card.compact ? 6 : 9
        spacing: 1
        Label {
            text: card.metricLabel.toUpperCase()
            color: colors.secondaryText
            font.family: colors.shellFontFamily
            font.pixelSize: card.compact ? 9 : 10
            font.weight: Font.DemiBold
            font.letterSpacing: 0.5
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        Label {
            objectName: "overviewMetricValue"
            text: card.value
            color: colors.pageHeading
            font.family: colors.shellFontFamily
            font.pixelSize: card.compact ? 20 : 26
            font.weight: Font.DemiBold
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
        Label {
            text: card.note
            color: colors.secondaryText
            font.family: colors.shellFontFamily
            font.pixelSize: card.compact ? 9 : 10
            Layout.fillWidth: true
            elide: Text.ElideRight
        }
    }
}
