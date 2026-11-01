import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    id: addDialog
    property var command
    property var focusReturn
    title: "Add fictional fleet vehicle"
    modal: true
    focus: true
    width: Math.min(560, parent ? parent.width - 64 : 520)
    standardButtons: Dialog.NoButton
    closePolicy: Popup.CloseOnEscape
    onOpened: Qt.callLater(function() {
        if(addDialog.visible) addBrand.forceActiveFocus(Qt.TabFocusReason)
    })
    onClosed: {
        addBrand.clear()
        addModel.clear()
        addRate.clear()
        addType.currentIndex = 0
        addExtra.value = 4
        Qt.callLater(function() {
            if(focusReturn && focusReturn.visible && focusReturn.enabled)
                focusReturn.forceActiveFocus(Qt.TabFocusReason)
        })
    }
    contentItem: ColumnLayout {
        spacing: 9
        Label {
            text: "Temporary fictional demo only. Fleet additions cannot change the fixed persistent session."
            color: "#5F6F82"
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        ComboBox {
            id: addType
            objectName: "fleetAddType"
            model: ["Car", "Motorcycle"]
            activeFocusOnTab: true
            Accessible.name: "Vehicle type"
            Layout.fillWidth: true
            onCurrentIndexChanged: addExtra.value = currentIndex===0 ? 4 : 450
        }
        AccessibleTextField {
            id: addBrand
            objectName: "fleetAddBrand"
            fieldPurpose: "Fictional vehicle brand"
            placeholderText: "Brand, for example Demo Motors"
            Layout.fillWidth: true
        }
        AccessibleTextField {
            id: addModel
            objectName: "fleetAddModel"
            fieldPurpose: "Fictional vehicle model"
            placeholderText: "Model, for example Orion"
            Layout.fillWidth: true
        }
        AccessibleTextField {
            id: addRate
            objectName: "fleetAddRate"
            fieldPurpose: "Daily rental rate in rand"
            placeholderText: "Daily rate (R), for example 420"
            Layout.fillWidth: true
        }
        RowLayout {
            Label {
                text: addType.currentIndex===0 ? "Doors" : "Engine capacity (cc)"
                color: "#17324D"
            }
            SpinBox {
                id: addExtra
                objectName: "fleetAddExtra"
                from: addType.currentIndex===0 ? 2 : 50
                to: addType.currentIndex===0 ? 8 : 3000
                value: 4
                editable: true
                activeFocusOnTab: true
                Accessible.name: addType.currentIndex===0
                    ? "Number of car doors" : "Motorcycle engine capacity in cc"
            }
        }
        DomainMessage {
            objectName: "fleetAddFeedback"
            text: fleetAdmin ? fleetAdmin.lastMessage : ""
        }
        RowLayout {
            Button {
                objectName: "fleetAddCancel"
                text: "Cancel"
                activeFocusOnTab: true
                onClicked: addDialog.close()
            }
            Item { Layout.fillWidth: true }
            Button {
                objectName: "fleetAddConfirm"
                text: "Add to demo fleet"
                activeFocusOnTab: true
                enabled: fleetAdmin && fleetAdmin.canAdd
                onClicked: {
                    if(fleetAdmin.addVehicle(addType.currentText,addBrand.text,
                                             addModel.text,Number(addRate.text),
                                             addExtra.value))
                        addDialog.close()
                }
            }
        }
    }
}
