import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Precision Automotive Light: one persistent primary command, not a page.
// Reuses the existing native booking flow; this component has no domain logic.
Button {
    id: action
    property bool compact: false
    text: "New rental"
    implicitHeight: 48
    Layout.fillWidth: true
    Layout.minimumHeight: 48
    Layout.preferredHeight: 48
    activeFocusOnTab: true
    hoverEnabled: true
    Accessible.role: Accessible.Button
    Accessible.name: "New rental"
    Accessible.description: "Opens the existing fictional vehicle, customer and review booking flow"
    ToolTip.visible: compact && hovered
    ToolTip.text: "New rental"
    background: Rectangle {
        radius: colors.componentRadius
        color: !action.enabled ? colors.disabledSurface :
               (action.down || action.hovered) ? colors.shellActionHover : colors.shellAction
        border.width: action.activeFocus ? colors.focusWidth : 1
        border.color: action.activeFocus ? colors.shellFocus : "#159473"
    }
    contentItem: Item {
        R2LucideIcon {
            objectName: "sidebarNewRentalIcon"
            iconName: "plus"
            tone: "inverse"
            opacity: action.enabled ? 1 : 0.45
            width: 19
            height: 19
            x: action.compact ? (parent.width - width) / 2 : 12
            y: (parent.height - height) / 2
        }
        Text {
            visible: !action.compact
            text: action.text
            x: 42
            width: Math.max(0, parent.width - x - 6)
            height: parent.height
            color: action.enabled ? "#FFFFFF" : colors.disabledInk
            font.pixelSize: 14
            font.family: colors.shellFontFamily
            font.weight: Font.DemiBold
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
    }
    DesignTokens { id: colors }
}
