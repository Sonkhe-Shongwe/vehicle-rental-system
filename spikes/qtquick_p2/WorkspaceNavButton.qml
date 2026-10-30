import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Native Button retains Enter/Space activation, Tab order and accessibility.
// Group-local Up/Down and Fleet Right are the only additional key mappings.
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
    Accessible.name: modelData + " workspace"
    Accessible.description: "Use Up and Down to navigate workspace names"
    Keys.onPressed: (event) => {
        if (event.modifiers !== Qt.NoModifier || !nav.activeFocus)
            return
        let target = -1
        if (event.key === Qt.Key_Up && nav.index > 0)
            target = nav.index - 1
        else if (event.key === Qt.Key_Down && nav.index < 2)
            target = nav.index + 1
        else if (event.key === Qt.Key_Right && nav.index === 1) {
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
        color: nav.currentWorkspace ? colors.navy : "transparent"
        // White-on-Navy focus avoids confusing the selected workspace
        // state with keyboard focus; unfocused active workspace remains Navy.
        border.width: nav.activeFocus ? 2 : 0
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
