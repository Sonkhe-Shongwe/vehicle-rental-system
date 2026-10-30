import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// No custom key handlers: cursor, Tab and selection remain Qt-native.
TextField {
    property string fieldPurpose: ""
    activeFocusOnTab: true
    Layout.minimumHeight: 44
    Accessible.name: fieldPurpose
}
