import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1500; height: 860
    minimumWidth: 1024; minimumHeight: 660
    visible: true
    title: "Rental Studio · P3 native Fleet and Rentals read-only proof"

    readonly property color navy: "#17324D"
    readonly property color teal: "#0F766E"
    readonly property color canvas: "#F6F8FA"
    readonly property color ice: "#EAF0F4"
    readonly property color mint: "#E8F5F0"
    readonly property color ink: "#5F6F82"
    property int workspace: 1
    property bool gallery: true

    color: canvas

    // Arrow keys are for moving between *vehicles* only while Fleet has
    // keyboard focus. The view scrolls only to reveal a newly focused vehicle.
    // Search text and ComboBox controls retain their native arrow behaviour.
    function navigateVehicles(deltaRow, deltaColumn) {
        const view = window.gallery ? galleryView : tableView
        if (view.count === 0)
            return
        const columns = window.gallery
                      ? Math.max(1, Math.round(galleryView.width / galleryView.cellWidth))
                      : 1
        const selected = fleet.selectedVisibleIndex()
        // When a previous selection is filtered out, restart on the first
        // visible vehicle instead of navigating from a stale source row.
        let current = selected >= 0 && selected < view.count ? selected : -1
        let target = current < 0 ? 0 : current
        if (current >= 0) {
            if (deltaRow !== 0)
                target = Math.max(0, Math.min(view.count - 1, current + deltaRow * columns))
            else if (deltaColumn !== 0) {
                const col = current % columns
                if (deltaColumn > 0 && col + 1 < columns && current + 1 < view.count)
                    target = current + 1
                else if (deltaColumn < 0 && col > 0)
                    target = current - 1
            }
        }
        // At a collection boundary the arrow is consumed, but neither the
        // selected ID nor the scroll position should move.
        if (target === current && current >= 0)
            return
        view.currentIndex = target
        fleet.selectVisibleIndex(target)
        if (window.gallery)
            galleryView.positionViewAtIndex(target, GridView.Contain)
        else
            tableView.positionViewAtIndex(target, ListView.Contain)
    }

    // A proxy reorder can change the visible row without changing the stable
    // vehicle ID. Keep BOTH views' current rows aligned with the C++ selection.
    // Defer until Qt has applied any pending model layout/filter changes.
    function syncCurrentVehicle() {
        const row = fleet.selectedVisibleIndex()
        galleryView.currentIndex = row
        tableView.currentIndex = row
    }

    Connections {
        target: fleet
        function onSelectionChanged() { Qt.callLater(window.syncCurrentVehicle) }
        function onQueryChanged() { Qt.callLater(window.syncCurrentVehicle) }
        function onStatusChanged() { Qt.callLater(window.syncCurrentVehicle) }
        function onSortByChanged() { Qt.callLater(window.syncCurrentVehicle) }
    }

    function handleVehicleArrow(event) {
        // Deliberately do NOT intercept Tab/Shift+Tab, Enter/Space, Escape,
        // text-input cursor keys or native ComboBox arrow controls.
        if (event.modifiers !== Qt.NoModifier)
            return
        if (event.key === Qt.Key_Up) navigateVehicles(-1, 0)
        else if (event.key === Qt.Key_Down) navigateVehicles(1, 0)
        else if (window.gallery && event.key === Qt.Key_Left) navigateVehicles(0, -1)
        else if (window.gallery && event.key === Qt.Key_Right) navigateVehicles(0, 1)
        else return
        event.accepted = true
    }

    // Global dismiss action for the read-only inspector. The triggering
    // card/table button retains focus; selection is only a view state.
    Shortcut {
        sequence: "Escape"
        onActivated: {
            if (window.workspace === 2) rentalsModel.clearSelection()
            else fleet.clearSelection()
        }
    }

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
                    text: "P3 · Read-only integration proof\nFictional demo · No booking buttons"
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
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 7
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                TextField {
                                    id: search
                                    objectName: "fleetSearchField"
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 150
                                    placeholderText: "Search model or vehicle ID"
                                    text: fleet.query
                                    onTextEdited: fleet.query = text
                                    Accessible.name: "Search fleet"
                                }
                                ComboBox {
                                    Layout.preferredWidth: 138
                                    model: ["All", "Available", "Rented"]
                                    Accessible.name: "Filter fleet status"
                                    onActivated: fleet.status = currentText
                                }
                                ComboBox {
                                    Layout.preferredWidth: 116
                                    model: ["Name", "Rate"]
                                    Accessible.name: "Sort fleet"
                                    onActivated: fleet.sortBy = currentText
                                }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    text: window.gallery ? "Vehicle gallery" : "Vehicle table"
                                    color: ink
                                    font.pixelSize: 12
                                }
                                Item { Layout.fillWidth: true }
                                Button {
                                    objectName: "fleetGalleryToggle"
                                    text: "Gallery"
                                    onClicked: {
                                        window.gallery = true
                                        galleryView.forceActiveFocus(Qt.OtherFocusReason)
                                    }
                                    Accessible.name: "Show Fleet gallery"
                                }
                                Button {
                                    objectName: "fleetTableToggle"
                                    text: "Table"
                                    onClicked: {
                                        window.gallery = false
                                        tableView.forceActiveFocus(Qt.OtherFocusReason)
                                    }
                                    Accessible.name: "Show Fleet table"
                                }
                            }
                        }

                        StackLayout {
                            Layout.fillWidth: true; Layout.fillHeight: true
                            currentIndex: window.gallery ? 0 : 1
                            GridView {
                                id: galleryView
                                objectName: "fleetGallery"
                                clip: true
                                activeFocusOnTab: true
                                keyNavigationEnabled: false
                                Accessible.name: "Fleet Gallery. Arrow keys change vehicles."
                                Accessible.role: Accessible.List
                                Keys.onPressed: (event) => window.handleVehicleArrow(event)
                                onActiveFocusChanged: {
                                    if (activeFocus) {
                                        const selected = fleet.selectedVisibleIndex()
                                        currentIndex = selected >= 0 ? selected : 0
                                    }
                                }
                                model: fleet.visibleModel
                                cellWidth: width < 790 ? width / 2 : width / 3
                                cellHeight: 215
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: vehicleCard
                                    required property int index
                                    required property string vehicleId
                                    required property string displayName
                                    required property string vehicleType
                                    required property double dailyRate
                                    required property bool available
                                    width: galleryView.cellWidth - 12
                                    height: 195
                                    activeFocusOnTab: false
                                    Accessible.role: Accessible.ListItem
                                    Accessible.name: displayName + ", " + vehicleId
                                                    + (available ? ", available" : ", rented")
                                    onClicked: {
                                        galleryView.currentIndex = index
                                        fleet.selectById(vehicleId)
                                        galleryView.forceActiveFocus(Qt.MouseFocusReason)
                                    }
                                    background: Rectangle {
                                        radius: 12
                                        color: fleet.selectedId === vehicleCard.vehicleId ? mint : "white"
                                        border.width: galleryView.activeFocus && galleryView.currentIndex === vehicleCard.index ? 3 : (fleet.selectedId === vehicleCard.vehicleId ? 2 : 1)
                                        border.color: galleryView.activeFocus && galleryView.currentIndex === vehicleCard.index ? navy : (fleet.selectedId === vehicleCard.vehicleId ? teal : "#D8E2E8")
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
                                objectName: "fleetTable"
                                clip: true
                                activeFocusOnTab: true
                                keyNavigationEnabled: false
                                Accessible.name: "Fleet Table. Up and Down select vehicles."
                                Accessible.role: Accessible.List
                                Keys.onPressed: (event) => window.handleVehicleArrow(event)
                                onActiveFocusChanged: {
                                    if (activeFocus) {
                                        const selected = fleet.selectedVisibleIndex()
                                        currentIndex = selected >= 0 ? selected : 0
                                    }
                                }
                                model: fleet.visibleModel
                                spacing: 6
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: vehicleRow
                                    objectName: "fleetTableRow"
                                    required property int index
                                    required property string vehicleId
                                    required property string displayName
                                    required property string vehicleType
                                    required property double dailyRate
                                    required property bool available
                                    width: tableView.width
                                    height: 60
                                    activeFocusOnTab: false
                                    onClicked: {
                                        tableView.currentIndex = index
                                        fleet.selectById(vehicleId)
                                        tableView.forceActiveFocus(Qt.MouseFocusReason)
                                    }
                                    Accessible.role: Accessible.ListItem
                                    Accessible.name: "Select " + displayName + ", " + vehicleId
                                    background: Rectangle {
                                        radius: 8
                                        color: fleet.selectedId === vehicleRow.vehicleId ? mint : "white"
                                        border.color: tableView.activeFocus && tableView.currentIndex === vehicleRow.index ? navy : (fleet.selectedId === vehicleRow.vehicleId ? teal : "#D8E2E8")
                                        border.width: tableView.activeFocus && tableView.currentIndex === vehicleRow.index ? 3 : (fleet.selectedId === vehicleRow.vehicleId ? 2 : 1)
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
                        objectName: "vehicleInspector"
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
                                    text: "Vehicle details"; color: navy; font.pixelSize: 17
                                    font.bold: true
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                Button {
                                    text: "×"
                                    visible: fleet.selectedId !== ""
                                    Layout.preferredWidth: 32
                                    Layout.maximumWidth: 32
                                    Layout.preferredHeight: 32
                                    Accessible.name: "Close vehicle details"
                                    onClicked: fleet.clearSelection()
                                }
                            }
                            Label {
                                text: fleet.selectedId === "" ? "Select a vehicle" : fleet.selectedName
                                color: navy; font.pixelSize: 21; font.bold: true
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                            }
                            Label {
                                text: fleet.selectedId === "" ?
                                    "Select a Gallery card or Table row to inspect the same C++ vehicle record." :
                                    fleet.selectedId + " · " + fleet.selectedType
                                color: ink; Layout.fillWidth: true; wrapMode: Text.WordWrap
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
                                objectName: "inspectorHint"
                                text: "P2 is non-mutating. Booking actions are intentionally absent."
                                color: ink; Layout.fillWidth: true; wrapMode: Text.WordWrap; font.pixelSize: 12
                            }
                            Item { Layout.fillHeight: true }
                        }
                    }
                }

                ColumnLayout {
                    spacing: 14
                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: "Rental records"
                            color: navy; font.pixelSize: 21; font.bold: true
                        }
                        Item { Layout.fillWidth: true }
                        Label {
                            text: "Read-only · C++ domain snapshots"
                            color: ink; font.pixelSize: 12
                        }
                    }
                    Label {
                        Layout.fillWidth: true
                        text: "Fictional records only. Dates, statuses and totals come from C++. No booking or return actions are available in this proof."
                        color: ink; wrapMode: Text.WordWrap; font.pixelSize: 12
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "white"
                        radius: 12
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12
                            Label {
                                text: rentalsModel.count + " rental records"
                                color: navy; font.bold: true
                            }
                            ListView {
                                id: rentalList
                                objectName: "rentalList"
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true
                                spacing: 7
                                model: rentalsModel
                                Accessible.role: Accessible.List
                                Accessible.name: "Fictional rental records"
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: rentalRow
                                    objectName: "rentalRow"
                                    required property string rentalId
                                    required property string vehicleId
                                    required property string status
                                    required property string dueState
                                    required property real total
                                    width: rentalList.width
                                    height: 70
                                    activeFocusOnTab: true
                                    Accessible.name: "Rental " + rentalId +
                                                     ", " + status + ", vehicle " + vehicleId
                                    onClicked: rentalsModel.selectById(rentalId)
                                    background: Rectangle {
                                        radius: 10
                                        color: rentalRow.rentalId === rentalsModel.selectedRentalId ? mint : ice
                                        border.width: rentalRow.activeFocus ? 2 : 1
                                        border.color: rentalRow.activeFocus ? teal : "#D8E2E8"
                                    }
                                    contentItem: RowLayout {
                                        anchors.margins: 10
                                        spacing: 16
                                        Label {
                                            text: rentalRow.rentalId
                                            color: navy; font.bold: true
                                            Layout.preferredWidth: 74
                                        }
                                        Label {
                                            text: rentalRow.vehicleId
                                            color: ink
                                            Layout.preferredWidth: 94
                                        }
                                        Label {
                                            text: rentalRow.status
                                            color: rentalRow.status === "Active" ? teal : navy
                                            Layout.preferredWidth: 100
                                        }
                                        Label {
                                            text: rentalRow.dueState
                                            color: ink
                                            Layout.fillWidth: true
                                        }
                                        Label {
                                            text: "R " + Number(rentalRow.total).toFixed(2)
                                            color: navy; font.bold: true
                                        }
                                    }
                                }
                            }
                            Label {
                                objectName: "rentalSelectionText"
                                text: rentalsModel.selectedRentalId === "" ?
                                      "No rental selected" :
                                      "Selected rental: " + rentalsModel.selectedRentalId
                                color: navy; font.pixelSize: 12
                                Accessible.name: text
                            }
                        }
                    }
                }
            }
        }
    }
}
