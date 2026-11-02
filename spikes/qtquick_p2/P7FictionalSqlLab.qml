import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// P7 owner-approved D1 *fictional-only* integration into the actual Qt Quick
// executable. This workspace has its own generated QTemporaryDir SQLite DB.
// There is no production path, customer/contact input, or legacy migration.
Flickable {
    id: lab
    objectName: "p7AppSqlLab"
    clip: true
    contentWidth: width
    contentHeight: contents.implicitHeight
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

    ColumnLayout {
    id: contents
    width: lab.width
    spacing: 16

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 94
        radius: 12
        color: "#E8F5F0"
        border.color: "#0F766E"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 7
            Label {
                text: "SQLITE LAB · GENERATED FICTIONAL RECORDS ONLY"
                color: "#0F766E"
                font.pixelSize: 15
                font.bold: true
                Accessible.name: text
            }
            Label {
                Layout.fillWidth: true
                text: "Isolated test database. Overview, Fleet and Rentals remain the separate protected text-file demo. No customer data, import, payment or commercial storage."
                wrapMode: Text.WordWrap
                color: "#17324D"
                font.pixelSize: 12
                Accessible.name: text
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 14
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 115
            radius: 12
            color: "white"
            border.color: "#D6E0E7"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 8
                Label {
                    text: "SQLITE FLEET · VERIFIED C++ SNAPSHOT"
                    color: "#0F766E"
                    font.bold: true
                }
                Label {
                    objectName: "p7AppFleetMetrics"
                    Layout.fillWidth: true
                    text: p7SqlFleet.snapshotAvailable ?
                          p7SqlFleet.totalCount + " vehicle  |  " +
                          p7SqlFleet.availableCount + " available" :
                          "Fleet read unavailable. Counts hidden."
                    color: "#17324D"
                    font.pixelSize: 18
                    font.bold: true
                    Accessible.name: text
                }
                Button {
                    objectName: "p7AppRetryFleet"
                    text: "Retry Fleet read"
                    visible: !p7SqlFleet.snapshotAvailable
                    onClicked: p7SqlFleet.refresh()
                    Accessible.name: text
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 115
            radius: 12
            color: "white"
            border.color: "#D6E0E7"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 8
                Label {
                    text: "SQLITE RENTALS · VERIFIED C++ SNAPSHOT"
                    color: "#0F766E"
                    font.bold: true
                }
                Label {
                    objectName: "p7AppRentalsMetrics"
                    Layout.fillWidth: true
                    text: p7SqlRentals.snapshotAvailable ?
                          "Active: " + p7SqlRentals.activeCount +
                          "  |  History: " + p7SqlRentals.historyCount :
                          "Rentals read unavailable. Counts hidden."
                    color: "#17324D"
                    font.pixelSize: 18
                    font.bold: true
                    Accessible.name: text
                }
                Button {
                    objectName: "p7AppRetryRentals"
                    text: "Retry Rentals read"
                    visible: !p7SqlRentals.snapshotAvailable
                    onClicked: p7SqlRentals.refresh()
                    Accessible.name: text
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 175
        radius: 12
        color: "white"
        border.color: "#D6E0E7"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 10
            Label {
                text: "C001 · GENERATED FICTIONAL TOYOTA COROLLA"
                color: "#17324D"
                font.pixelSize: 18
                font.bold: true
            }
            Label {
                objectName: "p7AppAsset"
                Layout.fillWidth: true
                text: p7SqlFleet.snapshotAvailable && p7SqlFleet.vehicles.length > 0 ?
                      p7SqlFleet.vehicles[0].displayName +
                      "  ·  R " + Number(p7SqlFleet.vehicles[0].dailyRate).toFixed(2) + "/day" +
                      "  ·  " + (p7SqlFleet.vehicles[0].available ? "Available" : "Not available") :
                      "Verified vehicle details unavailable"
                color: "#17324D"
                Accessible.name: text
            }
            Label {
                objectName: "p7AppReceipt"
                text: p7SqlController.rentalId === "" ?
                      "Rental ID: not issued" :
                      "Rental ID: " + p7SqlController.rentalId
                color: "#17324D"
                font.bold: true
                Accessible.name: text
            }
            Label {
                objectName: "p7AppQuote"
                text: p7SqlController.quoteLabel + " · NOT A PAYMENT"
                color: "#0F766E"
                font.bold: true
                Accessible.name: text
            }
        }
    }

    Flow {
        Layout.fillWidth: true
        spacing: 10
        Button {
            objectName: "p7AppPreview"
            text: "Preview 3 days"
            enabled: p7SqlController.canPreview
            onClicked: p7SqlController.previewQuote()
        }
        Button {
            objectName: "p7AppConfirm"
            text: "Commit fictional booking"
            enabled: p7SqlController.canConfirm
            onClicked: p7SqlController.confirmBooking()
        }
        Button {
            objectName: "p7AppReturn"
            text: "Return fictional rental"
            enabled: p7SqlController.canReturn
            onClicked: p7SqlController.returnBooking()
        }
        Button {
            objectName: "p7AppArchive"
            text: "Archive fictional rental"
            enabled: p7SqlController.canArchive
            onClicked: p7SqlController.archiveBooking()
        }
        Button {
            objectName: "p7AppRetire"
            text: "Retire fictional vehicle"
            enabled: p7SqlController.canRetire
            onClicked: p7SqlController.retireAsset()
        }
    }

    // This explorer is deliberately READ ONLY: status and selection are
    // computed by typed C++ DTO models; no SQL, PII or lifecycle writes here.
    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 292
        radius: 12
        color: "white"
        border.color: "#D6E0E7"
        RowLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 14

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 7
                Label {
                    text: "FLEET RECORD EXPLORER · READ ONLY"
                    color: "#0F766E"
                    font.bold: true
                    Accessible.name: text
                }
                ComboBox {
                    objectName: "p7AppFleetFilter"
                    Layout.fillWidth: true
                    model: ["All", "Available", "Unavailable"]
                    enabled: p7SqlFleet.snapshotAvailable
                    onActivated: p7SqlFleet.setStatusFilter(currentText)
                    Accessible.name: "Filter fictional SQLite Fleet by availability"
                }
                TextField {
                    objectName: "p7AppFleetSearch"
                    Layout.fillWidth: true
                    enabled: p7SqlFleet.snapshotAvailable
                    placeholderText: "Search vehicle ID, model or details"
                    maximumLength: 80
                    onTextChanged: p7SqlFleet.setSearchText(text)
                    Accessible.name: "Search verified fictional Fleet records"
                }
                ListView {
                    objectName: "p7AppFleetList"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 55
                    clip: true
                    visible: p7SqlFleet.snapshotAvailable
                    model: p7SqlFleet.visibleVehicles
                    delegate: Button {
                        required property var modelData
                        objectName: "p7AppFleetRow" + modelData.id
                        width: ListView.view.width
                        height: 38
                        text: modelData.id + " · " + modelData.displayName +
                              (modelData.available ? " · Available" : " · Unavailable")
                        onClicked: p7SqlFleet.selectById(modelData.id)
                        Accessible.name: "Inspect generated fictional vehicle " + modelData.id
                    }
                }
                Label {
                    objectName: "p7AppFleetEmpty"
                    Layout.fillWidth: true
                    visible: p7SqlFleet.snapshotAvailable && p7SqlFleet.visibleCount === 0
                    text: "No matching fictional vehicles. Change the search or availability filter."
                    color: "#556576"
                    wrapMode: Text.WordWrap
                    Accessible.name: text
                }
                Label {
                    objectName: "p7AppFleetSelected"
                    Layout.fillWidth: true
                    text: !p7SqlFleet.snapshotAvailable ?
                          "Fleet snapshot unavailable, details hidden" :
                          p7SqlFleet.selectedVehicleId === "" ?
                          "Select a vehicle to inspect" :
                          p7SqlFleet.selectedVehicle.id + " · " +
                          p7SqlFleet.selectedVehicle.details +
                          " · R " + Number(p7SqlFleet.selectedVehicle.dailyRate).toFixed(2) + "/day"
                    color: "#17324D"
                    wrapMode: Text.WordWrap
                    Accessible.name: text
                }
                Label {
                    objectName: "p7AppFleetVisibleCount"
                    text: p7SqlFleet.snapshotAvailable ?
                          p7SqlFleet.visibleCount + " matching vehicle(s)" :
                          "Unverified"
                    color: "#556576"
                    Accessible.name: text
                }
            }
            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: "#D6E0E7"
            }
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 7
                Label {
                    text: "RENTAL CONTRACTS · READ ONLY"
                    color: "#0F766E"
                    font.bold: true
                    Accessible.name: text
                }
                ComboBox {
                    objectName: "p7AppRentalFilter"
                    Layout.fillWidth: true
                    model: ["All", "Active", "History"]
                    enabled: p7SqlRentals.snapshotAvailable
                    onActivated: p7SqlRentals.statusFilter = currentText
                    Accessible.name: "Filter fictional SQLite rental contracts by status"
                }
                ListView {
                    objectName: "p7AppRentalList"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 55
                    clip: true
                    visible: p7SqlRentals.snapshotAvailable
                    model: p7SqlRentals
                    delegate: Button {
                        objectName: "p7AppRentalRow" + rentalId
                        width: ListView.view.width
                        height: 38
                        text: rentalId + " · " + vehicleId + " · " + status
                        onClicked: p7SqlRentals.selectVisibleRow(index)
                        Accessible.name: "Inspect generated fictional contract " + rentalId
                    }
                }
                Label {
                    objectName: "p7AppRentalSelected"
                    Layout.fillWidth: true
                    text: !p7SqlRentals.snapshotAvailable ?
                          "Rental snapshot unavailable, details hidden" :
                          p7SqlRentals.selectedRentalId === "" ?
                          "Select a contract to inspect" :
                          p7SqlRentals.selectedContract.rentalId + " · " +
                          p7SqlRentals.selectedContract.status +
                          " · booked R " +
                          Number(p7SqlRentals.selectedContract.total).toFixed(2) +
                          " (NOT collected revenue)"
                    color: "#17324D"
                    wrapMode: Text.WordWrap
                    Accessible.name: text
                }
                Label {
                    objectName: "p7AppRentalVisibleCount"
                    text: p7SqlRentals.snapshotAvailable ?
                          p7SqlRentals.count + " visible contract(s)" : "Unverified"
                    color: "#556576"
                    Accessible.name: text
                }
            }
        }
    }
    Label {
        objectName: "p7AppMessage"
        Layout.fillWidth: true
        text: p7SqlController.message
        color: "#17324D"
        wrapMode: Text.WordWrap
        Accessible.name: text
    }
    Label {
        Layout.fillWidth: true
        text: "EXPERIMENTAL AND ISOLATED · This is not production persistence or a commercial booking workflow."
        color: "#556576"
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        Accessible.name: text
    }
}
}
