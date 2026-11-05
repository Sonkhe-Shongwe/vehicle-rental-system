import QtQuick

// Owner-approved Navy/Emerald/Cloud palette. Source: design/r1/OWNER_THEME_DIRECTION.
// No guessed typography licensing, motion preference or WCAG signoff.
QtObject {
    readonly property color navy: "#17324D"
    readonly property color teal: "#0F766E"
    readonly property color canvas: "#F6F8FA"
    readonly property color surface: "#FFFFFF"
    readonly property color ice: "#EAF0F4"
    readonly property color mint: "#E8F5F0"
    readonly property color ink: "#5F6F82"
    readonly property color border: "#D8E2E8"
    readonly property color rented: "#1D4ED8"
    // Precision Automotive Light: semantic shell roles derived from the
    // selected Navy/Emerald tokens. Keep these consistent across workspaces.
    readonly property color sidebarSelected: "#D7F0EA"
    readonly property color quietSurface: "#F1F5F8"
    readonly property color pageHeading: navy
    readonly property color secondaryText: ink
    readonly property int sidebarExpandedWidth: 218
    readonly property int sidebarCollapsedWidth: 76
    readonly property int pageHeadingSizeWide: 30
    readonly property int pageHeadingSizeCompact: 27
    readonly property int pageSubtitleSize: 13
    readonly property int sidebarActionHeight: 48
    readonly property int componentRadius: 10
    // Owner-approved UX-CTRL-002 semantic states, not a new competing theme.
    readonly property color primaryHover: "#0C625C"
    readonly property color warningSurface: "#FFF2D5"
    readonly property color warningInk: "#965A0A"
    readonly property color danger: "#B42318"
    readonly property color dangerHover: "#912018"
    readonly property color dangerSoft: "#FEECEB"
    readonly property color neutralHover: "#DCE8EF"
    readonly property color disabledSurface: "#E6EAEE"
    readonly property color disabledInk: "#6B7580"
    readonly property int focusWidth: 3
    readonly property int selectedWidth: 2
    readonly property int minimumTouchTarget: 44
}
