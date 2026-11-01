import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: deleteDialog
    property var command
    property var focusReturn
    property var fallbackFocusReturn
    property string targetId: ""
    title: "Permanently delete archived rental"
    modal: true
    focus: true
    width: Math.min(520, parent ? parent.width - 64 : 500)
    standardButtons: Dialog.NoButton
    closePolicy: Popup.CloseOnEscape
    onOpened: Qt.callLater(function() {
        if(deleteDialog.visible)
            deletePhrase.forceActiveFocus(Qt.TabFocusReason)
    })
    onClosed: {
        deletePhrase.clear()
        targetId = ""
        Qt.callLater(function() {
            if(focusReturn && focusReturn.visible && focusReturn.enabled)
                focusReturn.forceActiveFocus(Qt.TabFocusReason)
            else if(fallbackFocusReturn && fallbackFocusReturn.visible)
                fallbackFocusReturn.forceActiveFocus(Qt.TabFocusReason)
        })
    }
    contentItem: ColumnLayout {
        spacing: 12
        Label {
            text: "This removes the archived rental record permanently from the temporary fictional demo. It cannot be undone."
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            color: "#17324D"
        }
        Label {
            objectName: "rentalDeleteTarget"
            text: targetId === "" ? "No archived rental selected" : "Archived rental: " + targetId
            font.bold: true
            color: "#17324D"
            Layout.fillWidth: true
        }
        Label {
            text: "Type DELETE " + targetId + " exactly to confirm."
            wrapMode: Text.WordWrap
            color: "#5F6F82"
            Layout.fillWidth: true
        }
        AccessibleTextField {
            id: deletePhrase
            objectName: "rentalDeletePhrase"
            fieldPurpose: "Exact archived rental deletion phrase"
            placeholderText: "DELETE " + targetId
            Layout.fillWidth: true
        }
        DomainMessage {
            objectName: "rentalDeleteFeedback"
            text: command ? command.lastMessage : ""
        }
        RowLayout {
            Button {
                objectName: "rentalDeleteCancel"
                text: "Cancel"
                activeFocusOnTab: true
                onClicked: deleteDialog.close()
            }
            Item { Layout.fillWidth: true }
            Button {
                objectName: "rentalDeleteConfirm"
                text: "Delete archived record"
                activeFocusOnTab: true
                enabled: command && command.canDeleteSelected && targetId !== ""
                Accessible.name: "Permanently delete selected archived rental"
                onClicked: {
                    if(command.permanentlyDelete(targetId,deletePhrase.text))
                        deleteDialog.close()
                }
            }
        }
    }
}
