import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Read-only, C++-bound real overview; no generated KPI values or fake events.
Rectangle {
    id: panel
    objectName: "overviewAvailabilityPanel"
    property int total: 0
    property int available: 0
    property int rented: 0
    property int dueToday: 0
    property int history: 0
    property string oldestOverdueId: ""
    property real bookedValue: 0
    property bool compact: false
    readonly property real availableShare: total > 0
        ? Math.max(0, Math.min(1, available / total)) : 0
    readonly property int availablePercent: Math.round(availableShare * 100)
    Layout.fillWidth: true
    Layout.minimumWidth: 300
    Layout.preferredHeight: compact ? 272 : 294
    radius: 12
    color: colors.surface
    border.width: 1
    border.color: colors.border
    Accessible.role: Accessible.StaticText
    Accessible.name: "Fleet availability: " + available + " available of " +
        total + ", " + rented + " rented, " + availablePercent + " percent."
    DesignTokens { id: colors }
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: panel.compact ? 12 : 16
        spacing: panel.compact ? 6 : 8
        Label {
            text: "Fleet availability"
            Layout.fillWidth: true
            color: colors.navy
            font.pixelSize: 17
            font.weight: Font.DemiBold
        }
        Label {
            text: "Current fictional inventory, not a revenue forecast"
            Layout.fillWidth: true
            font.pixelSize: 11
            color: colors.ink
            elide: Text.ElideRight
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: panel.compact ? 8 : 12
            Item {
                Layout.preferredWidth: panel.compact ? 116 : 132
                Layout.preferredHeight: panel.compact ? 116 : 132
                Canvas {
                    id: availabilityRing
                    objectName: "overviewAvailabilityRing"
                    anchors.fill: parent
                    readonly property real share: panel.availableShare
                    onShareChanged: requestPaint()
                    Component.onCompleted: requestPaint()
                    onPaint: {
                        const ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        const mid = Math.min(width, height) / 2
                        const radius = mid - 12
                        const start = -Math.PI / 2
                        ctx.lineWidth = 12
                        ctx.lineCap = "round"
                        ctx.strokeStyle = "#DFE8ED"
                        ctx.beginPath()
                        ctx.arc(width/2, height/2, radius, 0, Math.PI*2)
                        ctx.stroke()
                        if (share > 0) {
                            ctx.strokeStyle = "#0F766E"
                            ctx.beginPath()
                            ctx.arc(width/2, height/2, radius, start,
                                    start + Math.PI*2*share)
                            ctx.stroke()
                        }
                    }
                }
                Label {
                    objectName: "overviewAvailablePercent"
                    anchors.centerIn: parent
                    text: panel.availablePercent + "%"
                    color: colors.navy
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                    Accessible.name: text + " of vehicles available"
                }
            }
            ColumnLayout {
                Layout.fillWidth: true
                Layout.minimumWidth: 130
                spacing: 3
                RowLayout {
                    spacing: 6
                    Rectangle { width: 8; height: 8; radius: 4; color: colors.teal }
                    Label { text: "Available: " + panel.available; color: colors.navy; font.pixelSize: 11 }
                }
                RowLayout {
                    spacing: 6
                    Rectangle { width: 8; height: 8; radius: 4; color: colors.rented }
                    Label { text: "Rented: " + panel.rented; color: colors.navy; font.pixelSize: 11 }
                }
                RowLayout {
                    spacing: 6
                    Rectangle { width: 8; height: 8; radius: 4; color: colors.border }
                    Label { text: "Fleet total: " + panel.total; color: colors.navy; font.pixelSize: 11 }
                }
                OverviewMetricCard {
                    objectName: "overviewValueCard"
                    metricLabel: "Active booked value"
                    value: "R " + Number(panel.bookedValue).toFixed(2)
                    note: "Contracts, not payments"
                    metricIcon: "Rentals"
                    compact: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: 138
                    Layout.preferredHeight: 88
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            Label {
                objectName: "overviewDueTodayText"
                text: "Due today: " + panel.dueToday
                color: colors.navy
                font.pixelSize: 12
                Accessible.name: text
            }
            Label {
                objectName: "overviewHistoryText"
                text: "Returned or archived: " + panel.history
                color: colors.navy
                font.pixelSize: 12
                Layout.fillWidth: true
                elide: Text.ElideRight
                Accessible.name: text
            }
        }
        Label {
            objectName: "overviewOldestOverdueText"
            Layout.fillWidth: true
            text: panel.oldestOverdueId !== ""
                ? "Oldest overdue contract: " + panel.oldestOverdueId
                : "No overdue returns need attention"
            color: panel.oldestOverdueId !== "" ? colors.warningInk : colors.ink
            font.pixelSize: 12
            font.weight: Font.DemiBold
            elide: Text.ElideRight
            Accessible.name: text
        }
    }
}
