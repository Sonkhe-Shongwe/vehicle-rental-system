import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1500; height: 860
    minimumWidth: 1024; minimumHeight: 660
    visible: true
    title: "Rental Studio · P2 native Fleet proof (read-only)"

    readonly property color navy: "#17324D"
    readonly property color teal: "#0F766E"
    readonly property color canvas: "#F6F8FA"
    readonly property color ice: "#EAF0F4"
    readonly property color mint: "#E8F5F0"
    readonly property color ink: "#5F6F82"
    property int workspace: 1
    property bool gallery: true

    color: canvas

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 194
            color: ice
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 13
                Label {
                    text: "R  rental studio"
                    font.pixelSize: 19; font.bold: true; color: navy
                    Layout.bottomMargin: 28
                }
                Repeater {
                    model: ["Overview", "Fleet", "Rentals"]
                    delegate: Button {
                        required property string modelData
                        required property int index
                        Layout.fillWidth: true
                        text: modelData
                        activeFocusOnTab: true
                        Accessible.name: modelData + " workspace"
                        onClicked: window.workspace = index
                        background: Rectangle {
                            radius: 10
                            color: window.workspace === parent.index ? navy : "transparent"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: window.workspace === parent.index ? "white" : navy
                            font.bold: window.workspace === parent.index
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 13
                        }
                    }
                }
                Item { Layout.fillHeight: true }
                Label {
                    text: "P2 · Native feasibility only\nDemo fixture · No editing"
                    color: ink; font.pixelSize: 11
                    wrapMode: Text.WordWrap
                }
            }
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 24
            spacing: 18

            RowLayout {
                Layout.fillWidth: true
                Label {
                    text: window.workspace === 0 ? "Overview" :
                          window.workspace === 1 ? "Fleet management" : "Rentals"
                    font.pixelSize: 30; font.bold: true; color: navy
                }
                Item { Layout.fillWidth: true }
                Label { text: "READ-ONLY · C++ DEMO MODEL"; color: ink; font.pixelSize: 12 }
            }
            Rectangle { Layout.fillWidth: true; height: 1; color: "#D8E2E8" }

            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: window.workspace

                ColumnLayout {
                    spacing: 16
                    Label { text: "Fleet at a glance"; font.pixelSize: 21; color: navy }
                    RowLayout {
                        spacing: 16
                        Rectangle {
                            Layout.preferredWidth: 225; Layout.preferredHeight: 120
                            radius: 12; color: "white"
                            Column {
                                anchors.centerIn: parent; spacing: 5
                                Label { text: String(fleet.totalCount); font.pixelSize: 30; color: navy }
                                Label { text: "Vehicles in demo"; color: ink }
                            }
                        }
                        Rectangle {
                            Layout.preferredWidth: 225; Layout.preferredHeight: 120
                            radius: 12; color: mint
                            Column {
                                anchors.centerIn: parent; spacing: 5
                                Label { text: String(fleet.availableCount); font.pixelSize: 30; color: teal }
                                Label { text: "Available in demo"; color: navy }
                            }
                        }
                    }
                    Label {
                        text: "Rental value and due dates are deliberately omitted from this Fleet-only feasibility test."
                        color: ink; wrapMode: Text.WordWrap
                    }
                    Item { Layout.fillHeight: true }
                }

                RowLayout {
                    spacing: 14
                    ColumnLayout {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        spacing: 14
                        RowLayout {
                            Layout.fillWidth: true
                            TextField {
                                id: search
                                Layout.fillWidth: true
                                placeholderText: "Search model or vehicle ID"
                                text: fleet.query
                                onTextEdited: fleet.query = text
                                Accessible.name: "Search fleet"
                            }
                            ComboBox {
                                model: ["All", "Available", "Rented"]
                                Accessible.name: "Filter fleet status"
                                onActivated: fleet.status = currentText
                            }
                            ComboBox {
                                model: ["Name", "Rate"]
                                Accessible.name: "Sort fleet"
                                onActivated: fleet.sortBy = currentText
                            }
                            Button {
                                text: "Gallery"
                                onClicked: window.gallery = true
                                Accessible.name: "Show Fleet gallery"
                            }
                            Button {
                                text: "Table"
                                onClicked: window.gallery = false
                                Accessible.name: "Show Fleet table"
                            }
                        }

                        StackLayout {
                            Layout.fillWidth: true; Layout.fillHeight: true
                            currentIndex: window.gallery ? 0 : 1
                            GridView {
                                id: galleryView
                                clip: true
                                model: fleet.visibleModel
                                cellWidth: width < 790 ? width / 2 : width / 3
                                cellHeight: 215
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: vehicleCard
                                    required property string vehicleId
                                    required property string displayName
                                    required property string vehicleType
                                    required property double dailyRate
                                    required property bool available
                                    width: galleryView.cellWidth - 12
                                    height: 195
                                    activeFocusOnTab: true
                                    Accessible.name: displayName + ", " + vehicleId
                                                    + (available ? ", available" : ", rented")
                                    onClicked: fleet.selectById(vehicleId)
                                    background: Rectangle {
                                        radius: 12
                                        color: fleet.selectedId === vehicleCard.vehicleId ? mint : "white"
                                        border.width: fleet.selectedId === vehicleCard.vehicleId ? 2 : 1
                                        border.color: fleet.selectedId === vehicleCard.vehicleId ? teal : "#D8E2E8"
                                    }
                                    contentItem: ColumnLayout {
                                        anchors.margins: 12
                                        Label {
                                            text: "◇"
                                            font.pixelSize: 45; color: teal
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                        Label {
                                            text: vehicleCard.displayName
                                            font.bold: true; color: navy
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        Label { text: vehicleCard.vehicleId + " · " + vehicleCard.vehicleType; color: ink }
                                        Label {
                                            text: (vehicleCard.available ? "Available" : "Rented") +
                                                  "   ·   R " + vehicleCard.dailyRate.toFixed(2) + "/day"
                                            color: vehicleCard.available ? teal : navy
                                            font.pixelSize: 12
                                        }
                                    }
                                }
                            }
                            ListView {
                                id: tableView
                                clip: true
                                model: fleet.visibleModel
                                spacing: 6
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: vehicleRow
                                    required property string vehicleId
                                    required property string displayName
                                    required property string vehicleType
                                    required property double dailyRate
                                    required property bool available
                                    width: tableView.width
                                    height: 60
                                    activeFocusOnTab: true
                                    onClicked: fleet.selectById(vehicleId)
                                    Accessible.name: "Select " + displayName + ", " + vehicleId
                                    background: Rectangle {
                                        radius: 8
                                        color: fleet.selectedId === vehicleRow.vehicleId ? mint : "white"
                                        border.color: fleet.selectedId === vehicleRow.vehicleId ? teal : "#D8E2E8"
                                        border.width: fleet.selectedId === vehicleRow.vehicleId ? 2 : 1
                                    }
                                    contentItem: RowLayout {
                                        spacing: 14
                                        Label {
                                            text: vehicleRow.displayName
                                            Layout.fillWidth: true
                                            color: navy; font.bold: true
                                            elide: Text.ElideRight
                                        }
                                        Label { text: vehicleRow.vehicleId; color: ink }
                                        Label { text: vehicleRow.vehicleType; color: ink }
                                        Label {
                                            text: "R " + vehicleRow.dailyRate.toFixed(2)
                                            color: navy
                                        }
                                        Label {
                                            text: vehicleRow.available ? "Available" : "Rented"
                                            color: vehicleRow.available ? teal : navy
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: 258
                        Layout.fillHeight: true
                        color: "white"
                        border.color: "#D8E2E8"
                        radius: 12
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 18
                            spacing: 12
                            RowLayout {
                                Label {
                                    text: "Vehicle details"; color: navy; font.pixelSize: 18
                                    font.bold: true
                                    Layout.fillWidth: true
                                }
                                Button {
                                    text: "×"; enabled: fleet.selectedId !== ""
                                    Accessible.name: "Close vehicle details"
                                    onClicked: fleet.clearSelection()
                                }
                            }
                            Label {
                                text: fleet.selectedId === "" ? "Select a vehicle" : fleet.selectedName
                                color: navy; font.pixelSize: 21; font.bold: true
                                wrapMode: Text.WordWrap
                            }
                            Label {
                                text: fleet.selectedId === "" ?
                                    "Select a Gallery card or Table row to inspect the same C++ vehicle record." :
                                    fleet.selectedId + " · " + fleet.selectedType
                                color: ink; wrapMode: Text.WordWrap
                            }
                            Rectangle { Layout.fillWidth: true; height: 1; color: "#D8E2E8" }
                            Label {
                                text: fleet.selectedId === "" ? "" : fleet.selectedDetails
                                color: ink; wrapMode: Text.WordWrap
                            }
                            Label {
                                text: fleet.selectedId === "" ? "" :
                                    "R " + fleet.selectedRate + " / day"
                                color: navy; font.pixelSize: 18; font.bold: true
                            }
                            Label {
                                text: fleet.selectedId === "" ? "" :
                                    (fleet.selectedAvailable ? "Available" : "Rented")
                                color: fleet.selectedAvailable ? teal : navy
                            }
                            Label {
                                text: "P2 is non-mutating. Booking actions are intentionally absent."
                                color: ink; wrapMode: Text.WordWrap; font.pixelSize: 12
                            }
                            Item { Layout.fillHeight: true }
                        }
                    }
                }

                ColumnLayout {
                    Label { text: "Rentals will be integrated in P5."; color: navy; font.pixelSize: 22 }
                    Label {
                        text: "This native feasibility experiment proves Fleet data binding only. No draft booking, payment or working rental buttons are represented here."
                        color: ink; wrapMode: Text.WordWrap
                    }
                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}
