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
               (action.down || action.hovered) ? colors.primaryHover : colors.teal
        border.width: action.activeFocus ? colors.focusWidth : 0
        border.color: colors.navy
    }
    contentItem: Item {
        SidebarGlyph {
            objectName: "sidebarNewRentalIcon"
            kind: "add"
            glyphColor: action.enabled ? "#FFFFFF" : colors.disabledInk
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
            font.weight: Font.DemiBold
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
    }
    DesignTokens { id: colors }
}
