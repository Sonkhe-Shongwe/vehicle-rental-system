import QtQuick
import QtQuick.Controls

// Status uses explicit text, never color alone.
Label {
    property string statusValue: ""
    DesignTokens { id: tokens }
    text: statusValue
    color: statusValue === "Active" || statusValue === "Available"
         ? tokens.teal : tokens.navy
    Accessible.name: statusValue + " status"
}
