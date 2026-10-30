import QtQuick

// Shared visual focus/selection state; no keyboard event interception.
// Keyboard focus (Navy) must remain separate from selected record (Mint/Teal).
Rectangle {
    id: frame
    objectName: "sharedFocusFrame"
    property bool keyboardFocused: false
    property bool selected: false
    property color idleSurface: colors.surface
    property int cornerRadius: 12

    DesignTokens { id: colors }
    radius: cornerRadius
    color: selected ? colors.mint : idleSurface
    border.width: keyboardFocused ? colors.focusWidth :
                  selected ? colors.selectedWidth : 1
    border.color: keyboardFocused ? colors.navy :
                  selected ? colors.teal : colors.border
    // No implicit/transient animations; honors low-motion expectations by
    // default and avoids distracting motion or focus lag.
}
