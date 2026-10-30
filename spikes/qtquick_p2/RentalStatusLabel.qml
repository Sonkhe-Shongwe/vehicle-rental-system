import QtQuick
import QtQuick.Controls

// Status uses explicit text, never color alone.
Label {
    property string state: ""
    DesignTokens { id: tokens }
    text: state
    color: state === "Active" || state === "Available"
         ? tokens.teal : tokens.navy
    Accessible.name: state + " status"
}
