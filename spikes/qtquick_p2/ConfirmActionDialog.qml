import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Shared presentation-only confirmation. Parent owns all C++ commands.
Dialog {
    id: dialog
    property string question: ""
    property string acceptText: "Confirm"
    property string cancelName: ""
    property string acceptName: ""
    property bool canAccept: false
    property Item restoreFocusTo: null
    property Item fallbackFocusTo: null
    signal confirmed()

    width: Math.min(480, parent ? parent.width - 80 : 480)
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    standardButtons: Dialog.NoButton
    onClosed: Qt.callLater(function() {
        if (dialog.restoreFocusTo && dialog.restoreFocusTo.visible &&
            dialog.restoreFocusTo.enabled)
            dialog.restoreFocusTo.forceActiveFocus(Qt.TabFocusReason)
        else if (dialog.fallbackFocusTo && dialog.fallbackFocusTo.visible)
            dialog.fallbackFocusTo.forceActiveFocus(Qt.TabFocusReason)
    })
    contentItem: ColumnLayout {
        spacing: 12
        Label {
            text: dialog.question
            color: palette.navy
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            Accessible.name: text
        }
        RowLayout {
            Button {
                objectName: dialog.cancelName
                text: "Cancel"
                activeFocusOnTab: true
                Accessible.name: "Cancel " + dialog.title
                onClicked: dialog.close()
            }
            Item { Layout.fillWidth: true }
            Button {
                objectName: dialog.acceptName
                text: dialog.acceptText
                activeFocusOnTab: true
                enabled: dialog.canAccept
                Accessible.name: dialog.acceptText
                onClicked: {
                    if (dialog.canAccept) {
                        dialog.close()
                        dialog.confirmed()
                    }
                }
            }
        }
    }
    DesignTokens { id: palette }
}
