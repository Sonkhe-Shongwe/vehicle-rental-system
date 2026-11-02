import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 880
    height: 640
    visible: true
    title: "Rental Studio | Synthetic SQLite Review"
    color: "#F6F8FA"
    readonly property color navy: "#17324D"
    readonly property color teal: "#0F766E"
    readonly property color mint: "#E8F5F0"
    readonly property color ice: "#EAF0F4"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 16
        Label {
            text: "RENTAL STUDIO  ·  P7 ENGINEERING PREVIEW"
            font.pixelSize: 14; font.bold: true; color: teal
            Layout.fillWidth: true
        }
        Label {
            text: "Fictional SQLite lifecycle"
            font.pixelSize: 30; font.bold: true; color: navy
            Layout.fillWidth: true
        }
        Label {
            text: "Generated temporary records only. No customer names, licence data, payments, imports or production storage."
            wrapMode: Text.WordWrap; color: navy
            Layout.fillWidth: true
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 136
            radius: 12
            color: "#FFFFFF"
            border.color: "#D6E0E7"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                spacing: 7
                Label {
                    text: "C001  ·  Toyota Corolla  ·  R 450.00/day"
                    color: navy; font.pixelSize: 20; font.bold: true
                    Layout.fillWidth: true
                }
                Label {
                    objectName: "p7StateLabel"
                    text: "Workflow: " + previewController.stage +
                          "  |  Asset: " + previewController.vehicleState
                    color: teal
                    font.bold: true
                    Layout.fillWidth: true
                }
                Label {
                    objectName: "p7ReceiptLabel"
                    text: previewController.rentalId === "" ?
                              "Rental ID: not issued" :
                              "Rental ID: " + previewController.rentalId
                    color: navy
                    Layout.fillWidth: true
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 112
            color: mint; radius: 12
            ColumnLayout {
                anchors.fill: parent; anchors.margins: 16
                Label { text: "LIVE QUOTE · NOT A PAYMENT"; color: teal; font.bold: true }
                Label {
                    objectName: "p7QuoteLabel"
                    text: previewController.quoteLabel
                    font.pixelSize: 21; font.bold: true; color: navy
                }
            }
        }
        Flow {
            Layout.fillWidth: true
            spacing: 10
            Button {
                objectName: "p7PreviewButton"
                text: "Preview 3 days"
                enabled: previewController.canPreview
                onClicked: previewController.previewQuote()
            }
            Button {
                objectName: "p7ConfirmButton"
                text: "Confirm fictional booking"
                enabled: previewController.canConfirm
                onClicked: previewController.confirmBooking()
            }
            Button {
                objectName: "p7ReturnButton"
                text: "Return"
                enabled: previewController.canReturn
                onClicked: previewController.returnBooking()
            }
            Button {
                objectName: "p7ArchiveButton"
                text: "Archive"
                enabled: previewController.canArchive
                onClicked: previewController.archiveBooking()
            }
            Button {
                objectName: "p7RetireButton"
                text: "Retire vehicle"
                enabled: previewController.canRetire
                onClicked: previewController.retireAsset()
            }
        }
        Label {
            objectName: "p7MessageLabel"
            text: previewController.message
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            color: navy
            Accessible.name: text
        }
        Item { Layout.fillHeight: true }
        Label {
            Layout.fillWidth: true
            text: "REVIEW ONLY · This isolated test executable is NOT the normal Rental Studio application."
            color: "#556576"; font.pixelSize: 12
            wrapMode: Text.WordWrap
        }
    }
}
