import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: removeDialog
    property var command
    property var focusReturn
    property string targetId: ""
    property string targetName: ""
    title: "Remove fictional fleet vehicle"
    modal: true
    focus: true
    width: Math.min(520, parent ? parent.width-60 : 500)
    standardButtons: Dialog.NoButton
    closePolicy: Popup.CloseOnEscape
    onOpened: Qt.callLater(function() {
        if(removeDialog.visible) confirmationField.forceActiveFocus(Qt.TabFocusReason)
    })
    onClosed: {
        confirmationField.clear()
        targetId = ""
        targetName = ""
        Qt.callLater(function() {
            if(focusReturn && focusReturn.visible && focusReturn.enabled)
                focusReturn.forceActiveFocus(Qt.TabFocusReason)
        })
    }
    contentItem: ColumnLayout {
        spacing: 12
        Label {
            text: "You are removing a vehicle from this temporary fictional demo."
            color: "#17324D"
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        Label {
            objectName: "fleetRemoveTarget"
            text: targetId === "" ? "No vehicle selected" : targetName + " (" + targetId + ")"
            font.bold: true
            color: "#17324D"
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
        }
        Label {
            text: "Active rental vehicles cannot be removed. Type REMOVE " + targetId + " to confirm."
            wrapMode: Text.WordWrap
            color: "#5F6F82"
            Layout.fillWidth: true
        }
        AccessibleTextField {
            id: confirmationField
            objectName: "fleetRemoveConfirmation"
            fieldPurpose: "Exact vehicle removal confirmation"
            placeholderText: "REMOVE " + targetId
            Layout.fillWidth: true
        }
        DomainMessage {
            objectName: "fleetRemoveFeedback"
            text: command ? command.lastMessage : ""
        }
        RowLayout {
            Button {
                objectName: "fleetRemoveCancel"
                text: "Cancel"
                activeFocusOnTab: true
                onClicked: removeDialog.close()
            }
            Item { Layout.fillWidth: true }
            Button {
                objectName: "fleetRemoveConfirm"
                text: "Remove vehicle"
                activeFocusOnTab: true
                enabled: command && command.canRemove && targetId !== ""
                onClicked: {
                    if(command.removeVehicle(targetId, confirmationField.text))
                        removeDialog.close()
                }
            }
        }
    }
}
