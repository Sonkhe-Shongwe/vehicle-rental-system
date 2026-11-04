import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Native Button retains Enter/Space activation, Tab order and accessibility.
// Group-local arrows move focus; Enter/Space activates the native Button.
Button {
    id: nav
    required property string modelData
    required property int index
    property bool currentWorkspace: false
    property var workspaceItems: null
    signal enterContent()
    Layout.fillWidth: true
    objectName: "workspaceNav" + modelData
    text: modelData
    activeFocusOnTab: true
    hoverEnabled: true
    // Workspace choices are mutually exclusive; expose active state without
    // changing native Button activation or the existing C++ workspace routing.
    Accessible.role: Accessible.RadioButton
    Accessible.name: modelData + " workspace"
    Accessible.checkable: true
    Accessible.checked: nav.currentWorkspace
    Accessible.description: "Up and Down focus workspace names; Enter activates. Right enters the active workspace."
    Keys.onPressed: (event) => {
        if (event.modifiers !== Qt.NoModifier || !nav.activeFocus)
            return
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            // Qt Quick Buttons may activate Space but not Return without
            // default-button policy. Explicitly mirror mouse click here.
            nav.clicked()
            event.accepted = true
            return
        }
        let target = -1
        if (event.key === Qt.Key_Up && nav.index > 0)
            target = nav.index - 1
        else if (event.key === Qt.Key_Down &&
                 nav.index < (nav.workspaceItems ? nav.workspaceItems.count - 1 : 2))
            target = nav.index + 1
        else if (event.key === Qt.Key_Right && nav.currentWorkspace) {
            nav.enterContent()
            event.accepted = true
            return
        } else
            return
        if (nav.workspaceItems && target >= 0) {
            const sibling = nav.workspaceItems.itemAt(target)
            if (sibling && sibling.visible && sibling.enabled)
                sibling.forceActiveFocus(Qt.TabFocusReason)
        }
        event.accepted = true
    }
    background: Rectangle {
        radius: 10
        color: nav.currentWorkspace ? colors.navy :
               nav.hovered ? colors.neutralHover : "transparent"
        // White-on-Navy focus avoids confusing the selected workspace
        // state with keyboard focus; unfocused active workspace remains Navy.
        border.width: nav.activeFocus ? colors.focusWidth : 0
        border.color: nav.currentWorkspace ? "white" : colors.navy
    }
    contentItem: Text {
        text: nav.text
        color: nav.currentWorkspace ? "white" : colors.navy
        font.bold: nav.currentWorkspace
        verticalAlignment: Text.AlignVCenter
        leftPadding: 13
    }
    DesignTokens { id: colors }
}
