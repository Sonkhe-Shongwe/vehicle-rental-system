import QtQuick
import QtQuick.Controls

// Owner-approved UX-CTRL-002 permanently destructive visual language.
// Does not change a command or its C++ guard, confirmation or storage scope.
Button {
    id: control
    hoverEnabled: true
    activeFocusOnTab: true
    implicitHeight: 44
    background: Rectangle {
        radius: 8
        color: !control.enabled ? colors.disabledSurface :
               control.hovered || control.down ? colors.dangerHover : colors.danger
        border.width: control.activeFocus ? colors.focusWidth : 0
        border.color: colors.navy
        Behavior on color {
            ColorAnimation { duration: motionPolicy.selectionFadeMs }
        }
    }
    contentItem: Text {
        text: control.text
        color: control.enabled ? "#FFFFFF" : colors.disabledInk
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    DesignTokens { id: colors }
}
