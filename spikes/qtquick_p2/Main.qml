import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 1500; height: 860
    minimumWidth: 1024; minimumHeight: 660
    visible: true
    title: persistentFictionalDemo
           ? "Rental Studio 2.0 · persistent fictional-only demo"
           : "Rental Studio 2.0 · operational overview · fictional demo"

    // Shared owner-selected tokens; preserve the existing local bindings.
    DesignTokens { id: designTokens }
    // MotionPolicy is C++-owned; no OS rules or filesystem access in QML.
    readonly property bool reducedMotion: motionPolicy.reducedMotion
    readonly property int selectionFadeMs: motionPolicy.selectionFadeMs
    readonly property color navy: designTokens.navy
    readonly property color teal: designTokens.teal
    readonly property color canvas: designTokens.canvas
    readonly property color ice: designTokens.ice
    readonly property color mint: designTokens.mint
    readonly property color ink: designTokens.ink
    property int workspace: 1
    property bool gallery: true
    // Confirmed receipt survives closing the ephemeral preview dialog.
    // Only the C++-verified success branch populates this display string.
    property string bookingReceiptNotice: ""
    // Cancellation is a separate informational outcome, never a receipt.
    property string bookingCancelledNotice: ""
    property string rentalLookupFeedback: ""
    property string returnLookupFeedback: ""

    // Carry the exact selected, AVAILABLE Fleet ID into the existing native
    // guided booking modal. C++ quote/confirm still owns all business rules.
    function bookSelectedFleetVehicle() {
        if (window.workspace !== 1 || fleet.selectedId === "" ||
                !fleet.selectedAvailable)
            return
        const selectedId = fleet.selectedId
        window.bookingReceiptNotice = ""
        window.bookingCancelledNotice = ""
        bookingActions.discardPreview()
        window.workspace = 2
        Qt.callLater(function() {
            if (window.workspace !== 2 || fleet.selectedId !== selectedId ||
                    !fleet.selectedAvailable)
                return
            bookingVehicleId.text = selectedId
            bookingDialog.open()
        })
    }

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

    // Rental Arrow navigation follows only C++-filtered visible rows. Text
    // input, filter buttons, Tab and Escape retain native key behaviour.
    function navigateRentals(delta) {
        if (rentalsModel.count === 0)
            return
        const current = rentalsModel.selectedRow
        const target = current < 0 ? 0 :
                       Math.max(0, Math.min(rentalsModel.count - 1, current + delta))
        if (current === target)
            return
        if (rentalsModel.selectVisibleRow(target))
            rentalList.positionViewAtIndex(target, ListView.Contain)
    }

    function handleRentalArrow(event) {
        if (event.modifiers !== Qt.NoModifier)
            return
        if (event.key === Qt.Key_Up)
            navigateRentals(-1)
        else if (event.key === Qt.Key_Down)
            navigateRentals(1)
        else
            return
        event.accepted = true
    }

    // A deliberate lookup can reveal an ID hidden by the current filter.
    // Domain history and financial data are never modified by this route.
    function findRentalById() {
        const id = rentalLookupField.text.trim()
        if (id === "") {
            window.rentalLookupFeedback = "Enter a rental ID."
            return
        }
        if (!rentalsModel.locateById(id)) {
            window.rentalLookupFeedback = "Rental ID not found."
            return
        }
        window.rentalLookupFeedback = "Selected " + rentalsModel.selectedRentalId
        Qt.callLater(function() {
            if (window.workspace === 2 && rentalsModel.selectedRow >= 0) {
                rentalList.currentIndex = rentalsModel.selectedRow
                rentalList.positionViewAtIndex(rentalsModel.selectedRow, ListView.Contain)
                rentalList.forceActiveFocus(Qt.TabFocusReason)
            }
        })
    }

    // Legacy operator parity without auto-return: an ID resolves to one
    // ACTIVE record only, then the existing separate confirmation is required.
    function findActiveReturn() {
        const id = returnLookupField.text.trim()
        if (!rentalsModel.locateActiveReturn(id)) {
            window.returnLookupFeedback = id === ""
                ? "Enter an active rental or vehicle ID."
                : "No active rental matches that ID."
            return
        }
        window.returnLookupFeedback =
            "Ready to review return for " + rentalsModel.selectedRentalId
        Qt.callLater(function() {
            if (window.workspace === 2 && rentalsModel.selectedRow >= 0) {
                rentalList.currentIndex = rentalsModel.selectedRow
                rentalList.positionViewAtIndex(rentalsModel.selectedRow, ListView.Contain)
                if (returnSelectedButton.enabled)
                    returnSelectedButton.forceActiveFocus(Qt.TabFocusReason)
            }
        })
    }

    function syncCurrentRental() {
        rentalList.currentIndex = rentalsModel.selectedRow
    }

    Connections {
        target: rentalsModel
        function onSelectionChanged() {
            window.returnLookupFeedback = ""
            Qt.callLater(window.syncCurrentRental)
        }
        function onStatusFilterChanged() { Qt.callLater(window.syncCurrentRental) }
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

    // Escape dismisses only a selection in the currently visible workspace.
    // Never mutate hidden Fleet state while reading Overview, nor capture
    // Escape when there is no active selection to dismiss.
    readonly property bool canDismissSelection:
        (window.workspace === 1 && fleet.selectedId !== "") ||
        (window.workspace === 2 && rentalsModel.selectedRentalId !== "")
    Shortcut {
        sequence: "Escape"
        // The topmost modal owns Escape; selection clearing happens afterward.
        enabled: window.canDismissSelection &&
                 !bookingDialog.visible &&
                 !returnConfirmation.visible && !archiveConfirmation.visible &&
                 !archivedDeleteDialog.visible &&
                 !fleetAddDialog.visible && !fleetRemoveDialog.visible
        onActivated: {
            if (window.workspace === 1) fleet.clearSelection()
            else if (window.workspace === 2) rentalsModel.clearSelection()
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
                    id: workspaceItems
                    model: ["Overview", "Fleet", "Rentals"]
                    delegate: WorkspaceNavButton {
                        currentWorkspace: window.workspace === index
                        workspaceItems: workspaceItems
                        onClicked: window.workspace = index
                        onEnterContent: {
                            window.workspace = 1
                            Qt.callLater(function() {
                                search.forceActiveFocus(Qt.TabFocusReason)
                            })
                        }
                    }
                }
                Item { Layout.fillHeight: true }
                Label {
                    text: "P3 · Verified fictional data\nC++ domain owns all writes"
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
                Label { text: "FICTIONAL DEMO · C++ DOMAIN WRITES"; color: ink; font.pixelSize: 12 }
            }
            Rectangle { Layout.fillWidth: true; height: 1; color: "#D8E2E8" }

            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: window.workspace

                Flickable {
                    id: overviewScroll
                    objectName: "overviewScroll"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    contentWidth: width
                    contentHeight: overviewContent.implicitHeight
                    boundsBehavior: Flickable.StopAtBounds
                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }
                    ColumnLayout {
                    id: overviewContent
                    width: overviewScroll.width
                    spacing: 16
                    Label {
                        text: "Operations at a glance"
                        font.pixelSize: 21; font.bold: true; color: navy
                    }
                    Label {
                        text: "Live from the C++ rental records in this fictional demo."
                        color: ink; wrapMode: Text.WordWrap
                    }
                    GridLayout {
                        Layout.fillWidth: true
                        columns: window.width < 1350 ? 2 : 4
                        rowSpacing: 12; columnSpacing: 12
                        OverviewMetricCard {
                            objectName: "overviewAvailableCard"
                            metricLabel: "Available vehicles"
                            Layout.preferredHeight: window.height < 800 ? 114 : 134
                            value: String(fleet.availableCount)
                            note: "Of " + fleet.totalCount + " in Fleet"
                            accent: teal
                        }
                        OverviewMetricCard {
                            objectName: "overviewActiveCard"
                            metricLabel: "Active rentals"
                            Layout.preferredHeight: window.height < 800 ? 114 : 134
                            value: String(rentalsModel.activeCount)
                            note: "Confirmed rental contracts"
                            accent: navy
                        }
                        OverviewMetricCard {
                            objectName: "overviewOverdueCard"
                            metricLabel: "Overdue rentals"
                            Layout.preferredHeight: window.height < 800 ? 114 : 134
                            value: String(rentalsModel.overdueCount)
                            note: "From current C++ due-state"
                            accent: rentalsModel.overdueCount > 0 ? "#B45309" : teal
                        }
                        OverviewMetricCard {
                            objectName: "overviewValueCard"
                            metricLabel: "Active booked value"
                            Layout.preferredHeight: window.height < 800 ? 114 : 134
                            value: "R " + Number(rentalsModel.activeBookedValue).toFixed(2)
                            note: "Contract totals, not payments"
                            accent: navy
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 138
                        radius: 12
                        color: mint
                        border.color: designTokens.border
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 9
                            Label {
                                text: "Rental lifecycle"
                                color: navy; font.bold: true; font.pixelSize: 17
                            }
                            RowLayout {
                                spacing: 20
                                Label {
                                    objectName: "overviewDueTodayText"
                                    text: "Due today: " + rentalsModel.dueTodayCount
                                    color: navy
                                    Accessible.name: text
                                }
                                Label {
                                    objectName: "overviewHistoryText"
                                    text: "Returned or archived: " + rentalsModel.historyCount
                                    color: navy
                                    Accessible.name: text
                                }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12
                                Label {
                                    objectName: "overviewOldestOverdueText"
                                    text: rentalsModel.oldestOverdueRentalId !== ""
                                          ? "Oldest overdue contract: " + rentalsModel.oldestOverdueRentalId
                                          : "No overdue returns need attention"
                                    color: navy
                                    font.bold: true
                                    Accessible.name: text
                                }
                                Item { Layout.fillWidth: true }
                                Button {
                                    id: overviewOverdueAction
                                    objectName: "overviewReviewOverdue"
                                    text: "Review overdue"
                                    enabled: rentalsModel.oldestOverdueRentalId !== ""
                                    activeFocusOnTab: true
                                    Accessible.name: "Review oldest overdue rental"
                                    Accessible.description: "Select the oldest overdue active rental without changing its record"
                                    onClicked: {
                                        if (!rentalsModel.selectOldestOverdue())
                                            return
                                        window.workspace = 2
                                        Qt.callLater(function() {
                                            if (window.workspace !== 2)
                                                return
                                            rentalList.currentIndex = rentalsModel.selectedRow
                                            rentalList.positionViewAtIndex(rentalsModel.selectedRow, ListView.Contain)
                                            rentalList.forceActiveFocus(Qt.TabFocusReason)
                                        })
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        Button {
                            id: overviewActiveButton
                            objectName: "overviewOpenActive"
                            text: "Review active rentals"
                            activeFocusOnTab: true
                            Accessible.name: "Review active rentals"
                            onClicked: {
                                rentalsModel.statusFilter = "Active"
                                window.workspace = 2
                            }
                        }
                        Button {
                            objectName: "overviewOpenFleet"
                            text: "Open Fleet"
                            activeFocusOnTab: true
                            Accessible.name: "Open Fleet"
                            onClicked: window.workspace = 1
                        }
                    }
                    Label {
                        objectName: "overviewDemoDisclosure"
                        text: "Demo-only operations. No payment, deposit or realized revenue reporting."
                        color: ink; wrapMode: Text.WordWrap
                    }
                    Rectangle {
                        objectName: "overviewRecentPanel"
                        Layout.fillWidth: true
                        Layout.preferredHeight: recentContent.implicitHeight + 28
                        radius: 12
                        color: "white"
                        border.color: designTokens.border
                        ColumnLayout {
                            id: recentContent
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 7
                            Label {
                                text: "Recent rental contracts"
                                font.pixelSize: 17
                                font.bold: true
                                color: navy
                            }
                            Label {
                                text: "Latest contract start dates. Not an activity log or payments."
                                font.pixelSize: 11
                                color: ink
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                            }
                            Label {
                                objectName: "overviewRecentEmpty"
                                visible: rentalsModel.recentActivities.length === 0
                                text: "No rental contracts yet."
                                color: ink
                                Accessible.name: text
                            }
                            Repeater {
                                model: rentalsModel.recentActivities
                                delegate: Button {
                                    required property var modelData
                                    required property int index
                                    objectName: "overviewRecentRow" + index
                                    activeFocusOnTab: true
                                    Layout.fillWidth: true
                                    Layout.minimumHeight: 36
                                    text: modelData.rentalId + "  ·  " + modelData.vehicleId +
                                          "  ·  " + modelData.startDate + "  ·  " + modelData.status +
                                          "  ·  R " + Number(modelData.total).toFixed(2)
                                    Accessible.name: "Review rental " + modelData.rentalId +
                                                     ", vehicle " + modelData.vehicleId +
                                                     ", started " + modelData.startDate +
                                                     ", " + modelData.status +
                                                     ", booked value R " +
                                                     Number(modelData.total).toFixed(2)
                                    Accessible.description: "View contract in Rentals without changing it"
                                    onActiveFocusChanged: {
                                        if (activeFocus) {
                                            const top = mapToItem(overviewContent, 0, 0).y
                                            overviewScroll.contentY = Math.max(0,
                                                Math.min(top - 18,
                                                    overviewScroll.contentHeight - overviewScroll.height))
                                        }
                                    }
                                    onClicked: {
                                        if (!rentalsModel.locateById(modelData.rentalId))
                                            return
                                        window.workspace = 2
                                        Qt.callLater(function() {
                                            if (window.workspace === 2 && rentalsModel.selectedRow >= 0) {
                                                rentalList.currentIndex = rentalsModel.selectedRow
                                                rentalList.positionViewAtIndex(rentalsModel.selectedRow,
                                                                               ListView.Contain)
                                                rentalList.forceActiveFocus(Qt.TabFocusReason)
                                            }
                                        })
                                    }
                                }
                            }
                        }
                    }
                    }
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
                                AccessibleTextField {
                                    id: search
                                    fieldPurpose: "Search fleet"
                                    objectName: "fleetSearchField"
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 150
                                    placeholderText: "Search model or vehicle ID"
                                    text: fleet.query
                                    onTextEdited: fleet.query = text
                                }
                                ComboBox {
                                    id: fleetStatusCombo
                                    objectName: "fleetStatusCombo"
                                    activeFocusOnTab: true
                                    Layout.preferredWidth: 138
                                    model: ["All", "Available", "Rented"]
                                    Accessible.name: "Filter fleet status"
                                    onActivated: fleet.status = currentText
                                }
                                ComboBox {
                                    id: fleetSortCombo
                                    objectName: "fleetSortCombo"
                                    activeFocusOnTab: true
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
                                    Accessible.role: Accessible.RadioButton
                                    Accessible.name: "Fleet gallery view"
                                    Accessible.checkable: true
                                    Accessible.checked: window.gallery
                                    Accessible.description: "Choose the vehicle gallery presentation"
                                }
                                Button {
                                    objectName: "fleetTableToggle"
                                    text: "Table"
                                    onClicked: {
                                        window.gallery = false
                                        tableView.forceActiveFocus(Qt.OtherFocusReason)
                                    }
                                    Accessible.role: Accessible.RadioButton
                                    Accessible.name: "Fleet table view"
                                    Accessible.checkable: true
                                    Accessible.checked: !window.gallery
                                    Accessible.description: "Choose the vehicle table presentation"
                                }
                                Item { Layout.fillWidth: true }
                                Button {
                                    id: fleetAddButton
                                    objectName: "fleetAddButton"
                                    text: "Add vehicle"
                                    enabled: fleetAdmin.canAdd
                                    activeFocusOnTab: true
                                    Accessible.name: "Add a fictional car or motorcycle"
                                    Accessible.description: fleetAdmin.canAdd
                                        ? "Opens the temporary demo fleet form"
                                        : "Cannot change the fixed persistent fictional fleet"
                                    onClicked: fleetAddDialog.open()
                                }
                            }
                            Label {
                                objectName: "fleetSnapshotSummary"
                                Layout.fillWidth: true
                                color: ink
                                font.pixelSize: 12
                                wrapMode: Text.WordWrap
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                text: fleet.totalCount === 0
                                    ? "No fleet vehicles"
                                    : "Fleet snapshot: " + fleet.carCount + " cars · " +
                                      fleet.motorcycleCount + " motorcycles · " +
                                      fleet.rentedCount + " of " + fleet.totalCount +
                                      " currently rented"
                                Accessible.name: text
                                Accessible.description: "Current rental occupancy, not historical fleet utilisation or collected revenue"
                            }
                            DomainMessage {
                                objectName: "fleetAddMessage"
                                text: fleetAdmin.lastMessage
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
                                    background: FocusFrame {
                                        objectName: "fleetGalleryFocus"
                                        keyboardFocused: galleryView.activeFocus &&
                                                         galleryView.currentIndex === vehicleCard.index
                                        selected: fleet.selectedId === vehicleCard.vehicleId
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
                                    background: FocusFrame {
                                        objectName: "fleetTableFocus"
                                        cornerRadius: 8
                                        keyboardFocused: tableView.activeFocus &&
                                                         tableView.currentIndex === vehicleRow.index
                                        selected: fleet.selectedId === vehicleRow.vehicleId
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
                                        RentalStatusLabel {
                                            statusValue: vehicleRow.available ? "Available" : "Rented"
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
                                text: fleet.selectedId === ""
                                      ? "Select a vehicle to inspect its details and availability."
                                      : fleet.selectedAvailable
                                        ? "Available for a new rental. Review the authoritative C++ quote before confirming."
                                        : "Already rented. Return the active rental before booking this vehicle again."
                                color: ink; Layout.fillWidth: true; wrapMode: Text.WordWrap; font.pixelSize: 12
                            }
                            Button {
                                id: bookSelectedFleetButton
                                objectName: "fleetBookSelectedButton"
                                Layout.fillWidth: true
                                text: "Book selected vehicle"
                                enabled: fleet.selectedId !== "" && fleet.selectedAvailable
                                activeFocusOnTab: true
                                Accessible.name: "Create rental for selected available vehicle"
                                Accessible.description: fleet.selectedId === ""
                                    ? "Select an available Fleet vehicle first"
                                    : fleet.selectedAvailable
                                      ? "Opens the guided rental quote for " + fleet.selectedId
                                      : "This vehicle is currently rented"
                                onClicked: window.bookSelectedFleetVehicle()
                            }
                            Button {
                                id: removeSelectedFleetButton
                                objectName: "fleetRemoveSelectedButton"
                                Layout.fillWidth: true
                                text: "Remove selected vehicle"
                                activeFocusOnTab: true
                                enabled: fleet.selectedId !== "" &&
                                         fleet.selectedAvailable &&
                                         fleetRemove.canRemoveVehicle(fleet.selectedId)
                                Accessible.name: "Remove selected available fictional vehicle"
                                Accessible.description: !fleetRemove.canRemove
                                    ? "Unavailable in persistent fictional-only mode"
                                    : !fleet.selectedAvailable
                                      ? "Return the active rental before vehicle removal"
                                      : fleetRemove.hasRentalHistory(fleet.selectedId)
                                        ? "Historical rental records reference this vehicle. Removal is blocked."
                                        : "Requires exact vehicle ID confirmation"
                                onClicked: {
                                    fleetRemove.clearMessage()
                                    fleetRemoveDialog.targetId = fleet.selectedId
                                    fleetRemoveDialog.targetName = fleet.selectedName
                                    fleetRemoveDialog.open()
                                }
                            }
                            Label {
                                objectName: "fleetRentalHistoryHint"
                                visible: fleet.selectedId !== "" &&
                                         fleet.selectedAvailable &&
                                         fleetRemove.hasRentalHistory(fleet.selectedId)
                                text: "Removal blocked: rental history still references this vehicle."
                                color: ink
                                wrapMode: Text.WordWrap
                                font.pixelSize: 12
                                Layout.fillWidth: true
                                Accessible.name: text
                            }
                            DomainMessage {
                                objectName: "fleetRemoveMessage"
                                text: fleetRemove.lastMessage
                            }
                            Item { Layout.fillHeight: true }
                        }
                    }
                    FleetAddDialog {
                        id: fleetAddDialog
                        objectName: "fleetAddDialog"
                        anchors.centerIn: parent
                        command: fleetAdmin
                        focusReturn: fleetAddButton
                    }
                    FleetRemoveDialog {
                        id: fleetRemoveDialog
                        objectName: "fleetRemoveDialog"
                        anchors.centerIn: parent
                        command: fleetRemove
                        focusReturn: removeSelectedFleetButton
                        fallbackFocusReturn: fleetAddButton
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
                            text: "C++ domain · Fictional rental workflow"
                            color: ink; font.pixelSize: 12
                        }
                    }
                    Label {
                        Layout.fillWidth: true
                        text: persistentFictionalDemo
                              ? "Persistent fictional-only demo. Bookings survive restart in a fixed local synthetic workspace. No real customer details."
                              : "Demo records only. Booking and returns use authoritative C++ domain transactions on isolated temporary copies. No operational customer records."
                        color: ink; wrapMode: Text.WordWrap; font.pixelSize: 12
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Button {
                            id: newBookingButton
                            objectName: "rentalNewBookingButton"
                            text: "New rental"
                            activeFocusOnTab: true
                            Accessible.name: "Create a new fictional rental"
                            onClicked: {
                                window.bookingReceiptNotice = ""
                                window.bookingCancelledNotice = ""
                                bookingDialog.open()
                            }
                        }
                        DomainMessage {
                            objectName: "rentalBookingMessage"
                            emphasized: window.bookingReceiptNotice !== ""
                            text: window.bookingReceiptNotice !== ""
                                  ? window.bookingReceiptNotice
                                  : window.bookingCancelledNotice !== ""
                                    ? window.bookingCancelledNotice
                                    : bookingActions.lastMessage
                        }
                    }
                    Dialog {
                        id: bookingDialog
                        objectName: "rentalBookingDialog"
                        title: "New rental: review authoritative quote"
                        modal: true
                        focus: true
                        anchors.centerIn: parent
                        width: Math.min(620, window.width - 80)
                        standardButtons: Dialog.NoButton
                        closePolicy: Popup.CloseOnEscape
                        onOpened: Qt.callLater(function() {
                            if (bookingDialog.visible)
                                bookingVehicleId.forceActiveFocus(Qt.TabFocusReason)
                        })
                        onClosed: {
                            // All exits, including Escape and title-bar dismissal,
                            // must forget uncommitted contact fields and C++ quote.
                            // Only a confirmed C++ commit can leave a receipt.
                            bookingActions.discardPreview()
                            bookingCustomer.clear()
                            bookingPhone.clear()
                            if (window.bookingReceiptNotice === "")
                                window.bookingCancelledNotice = "Booking cancelled. No rental saved."
                            Qt.callLater(function() {
                                if (newBookingButton.visible && newBookingButton.enabled)
                                    newBookingButton.forceActiveFocus(Qt.TabFocusReason)
                            })
                        }
                        contentItem: ColumnLayout {
                            spacing: 10
                            Label {
                                text: "Demo only. No booking occurs until Confirm booking succeeds."
                                color: ink; wrapMode: Text.WordWrap
                            }
                            RowLayout {
                                Label { text: "Vehicle ID"; color: navy; Layout.preferredWidth: 92 }
                                AccessibleTextField {
                                    id: bookingVehicleId
                                    fieldPurpose: "Vehicle ID for rental quote"
                                    objectName: "bookingVehicleId"
                                    Layout.fillWidth: true
                                    placeholderText: "C001"
                                    onTextEdited: bookingActions.discardPreview()
                                }
                                Label { text: "Days"; color: navy }
                                SpinBox {
                                    id: bookingDays
                                    objectName: "bookingDays"
                                    from: 1; to: 365; value: 2
                                    editable: true
                                    Accessible.name: "Rental days"
                                    onValueModified: bookingActions.discardPreview()
                                }
                            }
                            Button {
                                id: bookingPreviewButton
                                objectName: "bookingPreviewButton"
                                text: bookingActions.needsFreshQuote ? "Refresh quote" : "Preview C++ quote"
                                activeFocusOnTab: true
                                Accessible.name: bookingActions.needsFreshQuote
                                    ? "Refresh outdated rental quote" : "Preview current C++ rental quote"
                                Accessible.description: bookingActions.needsFreshQuote
                                    ? "The previous quote cannot be confirmed. Review current availability and price."
                                    : "Review a current domain quote before enabling Confirm booking"
                                onClicked: bookingActions.preview(bookingVehicleId.text, bookingDays.value)
                            }
                            DomainMessage {
                                objectName: "bookingQuoteSummary"
                                emphasized: bookingActions.canConfirm
                                text: bookingActions.quoteSummary
                            }
                            // A declined confirmation must be explained inside
                            // the still-open dialog, not behind its modal shade.
                            DomainMessage {
                                objectName: "bookingDialogFeedback"
                                text: bookingActions.lastMessage
                            }
                            Label {
                                text: persistentFictionalDemo
                                      ? "Fixed fictional contact is used in persistent demo mode. No real customer details."
                                      : "Customer details are sent only to the C++ commit service."
                                color: ink; wrapMode: Text.WordWrap
                            }
                            AccessibleTextField {
                                id: bookingCustomer
                                fieldPurpose: "Fictional customer name"
                                objectName: "bookingCustomer"
                                Layout.fillWidth: true
                                placeholderText: "Customer name"
                                enabled: !persistentFictionalDemo
                            }
                            AccessibleTextField {
                                id: bookingPhone
                                fieldPurpose: "Fictional contact number"
                                objectName: "bookingPhone"
                                Layout.fillWidth: true
                                placeholderText: "Contact number"
                                enabled: !persistentFictionalDemo
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                Button {
                                    objectName: "bookingCancelButton"
                                    text: "Cancel"
                                    activeFocusOnTab: true
                                    onClicked: bookingDialog.close()
                                }
                                Item { Layout.fillWidth: true }
                                Button {
                                    objectName: "bookingConfirmButton"
                                    text: "Confirm booking"
                                    enabled: bookingActions.canConfirm
                                    activeFocusOnTab: true
                                    onClicked: {
                                        if (bookingActions.confirm(
                                            persistentFictionalDemo ? "Fictional Demo Session" : bookingCustomer.text,
                                            persistentFictionalDemo ? "0000000000" : bookingPhone.text)) {
                                            window.bookingReceiptNotice = bookingActions.lastMessage
                                            bookingCustomer.clear()
                                            bookingPhone.clear()
                                            bookingDialog.close()
                                        } else if (bookingActions.needsFreshQuote) {
                                            // A disabled Confirm can trigger Qt's own fallback
                                            // focus assignment in this same input event. Return
                                            // focus only after that change has settled.
                                            Qt.callLater(function() {
                                                if (bookingDialog.visible && bookingActions.needsFreshQuote)
                                                    bookingPreviewButton.forceActiveFocus(Qt.TabFocusReason)
                                            })
                                        }
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Button {
                            id: returnSelectedButton
                            objectName: "rentalReturnButton"
                            text: "Return selected rental"
                            activeFocusOnTab: true
                            enabled: rentalActions.canReturnSelected
                            Accessible.name: "Return the selected active rental"
                            onClicked: returnConfirmation.open()
                        }
                        Button {
                            id: archiveActionButton
                            objectName: "rentalArchiveButton"
                            text: "Archive returned"
                            activeFocusOnTab: true
                            enabled: archiveActions.canArchiveSelected
                            Accessible.name: "Archive selected returned rental"
                            onClicked: archiveConfirmation.open()
                        }
                        Button {
                            id: deleteArchivedButton
                            objectName: "rentalDeleteArchivedButton"
                            text: "Delete archived"
                            activeFocusOnTab: true
                            enabled: archivedDelete.canDeleteSelected
                            Accessible.name: "Permanently delete selected archived fictional rental"
                            Accessible.description: archivedDelete.canDeleteSelected
                                ? "Requires exact DELETE rental ID confirmation"
                                : "Select an archived rental in a disposable fictional demo"
                            onClicked: {
                                archivedDelete.clearMessage()
                                archivedDeleteDialog.targetId = rentalsModel.selectedRentalId
                                archivedDeleteDialog.open()
                            }
                        }
                        DomainMessage {
                            objectName: "rentalReturnMessage"
                            text: rentalActions.lastReturnMessage
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10
                        Label {
                            text: "Return lookup"
                            color: navy
                            font.pixelSize: 12
                        }
                        AccessibleTextField {
                            id: returnLookupField
                            objectName: "returnLookupField"
                            fieldPurpose: "Find active rental to return by rental ID or vehicle ID"
                            placeholderText: "Rental ID or vehicle ID"
                            Layout.preferredWidth: 195
                            onTextEdited: {
                                // Editing a new target must never leave the
                                // previous contract eligible for confirmation.
                                rentalsModel.clearSelection()
                                window.returnLookupFeedback = ""
                            }
                            onAccepted: window.findActiveReturn()
                        }
                        Button {
                            id: returnLookupButton
                            objectName: "returnLookupButton"
                            text: "Locate return"
                            activeFocusOnTab: true
                            Layout.minimumHeight: 36
                            Accessible.name: "Locate active rental for return"
                            Accessible.description: "Select only. Opens no confirmation and writes nothing."
                            onClicked: window.findActiveReturn()
                        }
                        Label {
                            objectName: "returnLookupFeedback"
                            Layout.fillWidth: true
                            text: window.returnLookupFeedback
                            color: ink
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            Accessible.name: text
                        }
                    }
                    ConfirmActionDialog {
                        id: returnConfirmation
                        objectName: "rentalReturnDialog"
                        anchors.centerIn: parent
                        title: "Confirm rental return"
                        question: "Mark " + rentalsModel.selectedRentalId + " as returned today?"
                        acceptText: "Confirm return"
                        acceptName: "rentalReturnConfirm"
                        cancelName: "rentalReturnCancel"
                        canAccept: rentalActions.canReturnSelected
                        restoreFocusTo: returnSelectedButton
                        fallbackFocusTo: rentalList
                        onConfirmed: rentalActions.returnSelected()
                    }
                    ConfirmActionDialog {
                        id: archiveConfirmation
                        objectName: "rentalArchiveDialog"
                        anchors.centerIn: parent
                        title: "Archive returned rental"
                        question: "Move " + rentalsModel.selectedRentalId +
                                  " to archived history? The record will not be deleted."
                        acceptText: "Confirm archive"
                        acceptName: "rentalArchiveConfirm"
                        cancelName: "rentalArchiveCancel"
                        canAccept: archiveActions.canArchiveSelected
                        restoreFocusTo: archiveActionButton
                        fallbackFocusTo: rentalList
                        onConfirmed: archiveActions.archiveSelected()
                    }
                    P6ArchivedDeleteDialog {
                        id: archivedDeleteDialog
                        objectName: "rentalDeleteArchivedDialog"
                        anchors.centerIn: parent
                        command: archivedDelete
                        focusReturn: deleteArchivedButton
                        fallbackFocusReturn: rentalList
                    }
                    DomainMessage {
                        objectName: "rentalDeleteMessage"
                        text: archivedDelete.lastMessage
                    }
                    DomainMessage {
                        objectName: "rentalArchiveMessage"
                        text: archiveActions.lastArchiveMessage
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        Repeater {
                            // Retain combined History for previous keyboard
                            // workflows; Returned and Archived are separate
                            // read-only C++ lifecycle views.
                            model: ["All", "Active", "Returned", "Archived", "History"]
                            delegate: Button {
                                required property string modelData
                                objectName: "rentalFilter" + modelData
                                text: modelData
                                activeFocusOnTab: true
                                // Native defaults were only 26 px high.
                                // Give all lifecycle filter targets a comfortably
                                // sized keyboard/mouse interaction surface.
                                Layout.minimumHeight: 36
                                Accessible.role: Accessible.RadioButton
                                Accessible.name: modelData + " rentals"
                                Accessible.checkable: true
                                Accessible.checked: rentalsModel.statusFilter === modelData
                                Accessible.description: "Filter fictional rentals by lifecycle status"
                                onClicked: rentalsModel.statusFilter = modelData
                                background: Rectangle {
                                    radius: 8
                                    color: rentalsModel.statusFilter === parent.modelData ? navy : ice
                                }
                                contentItem: Text {
                                    text: parent.text
                                    color: rentalsModel.statusFilter === parent.modelData ? "white" : navy
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: rentalsModel.statusFilter === parent.modelData
                                }
                            }
                        }
                        Label {
                            objectName: "rentalLookupFeedback"
                            text: window.rentalLookupFeedback
                            color: ink
                            font.pixelSize: 12
                            elide: Text.ElideRight
                            Layout.preferredWidth: 165
                            Accessible.name: text
                        }
                        Item { Layout.fillWidth: true }
                        AccessibleTextField {
                            id: rentalLookupField
                            objectName: "rentalLookupField"
                            fieldPurpose: "Find rental by ID"
                            placeholderText: "Rental ID, e.g. R001"
                            Layout.preferredWidth: 180
                            onTextEdited: window.rentalLookupFeedback = ""
                            onAccepted: window.findRentalById()
                        }
                        Button {
                            objectName: "rentalLookupButton"
                            text: "Find rental"
                            activeFocusOnTab: true
                            Accessible.name: "Find rental by ID"
                            onClicked: window.findRentalById()
                        }
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
                                activeFocusOnTab: true
                                keyNavigationEnabled: false
                                Keys.onPressed: (event) => window.handleRentalArrow(event)
                                model: rentalsModel
                                Accessible.role: Accessible.List
                                Accessible.name: "Fictional rental records"
                                ScrollBar.vertical: ScrollBar {}
                                delegate: Button {
                                    id: rentalRow
                                    objectName: "rentalRow"
                                    required property int index
                                    required property string rentalId
                                    required property string vehicleId
                                    required property string status
                                    required property string dueState
                                    required property real total
                                    width: rentalList.width
                                    height: 70
                                    // The ListView is the single keyboard Tab stop; arrow keys
                                    // select records and rows remain pointer-clickable.
                                    activeFocusOnTab: false
                                    // Include all the visible record context and selection
                                    // in one spoken name; never expose customer PII here.
                                    Accessible.name: (rentalRow.rentalId === rentalsModel.selectedRentalId
                                                      ? "Selected rental " : "Rental ") +
                                                     rentalId + ", " + status +
                                                     ", vehicle " + vehicleId +
                                                     ", " + dueState +
                                                     ", total R " + Number(total).toFixed(2)
                                    onClicked: rentalsModel.selectById(rentalId)
                                    background: FocusFrame {
                                        objectName: "rentalRowFocus"
                                        cornerRadius: 10
                                        idleSurface: designTokens.ice
                                        keyboardFocused: rentalRow.activeFocus ||
                                                         (rentalList.activeFocus &&
                                                          rentalList.currentIndex === index)
                                        selected: rentalRow.rentalId === rentalsModel.selectedRentalId
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
                                        RentalStatusLabel {
                                            statusValue: rentalRow.status
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
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    objectName: "rentalSelectionText"
                                    text: rentalsModel.selectedRentalId === "" ?
                                          "No rental selected" :
                                          "Selected rental: " + rentalsModel.selectedRentalId
                                    color: navy; font.pixelSize: 12
                                    Accessible.name: text
                                    Layout.fillWidth: true
                                }
                                Button {
                                    id: showContractDetailsButton
                                    objectName: "rentalDetailsButton"
                                    text: "View contract details"
                                    Layout.minimumHeight: 36
                                    activeFocusOnTab: true
                                    enabled: rentalsModel.selectedContract.rentalId !== undefined
                                    Accessible.name: "View selected rental contract details"
                                    Accessible.description: "Read-only dates, status, duration and booked amount. No customer contact."
                                    onClicked: contractDetailsDialog.open()
                                }
                            }
                        }
                    }
                    Dialog {
                        id: contractDetailsDialog
                        objectName: "rentalContractDetailsDialog"
                        title: "Rental contract details"
                        width: Math.min(540, window.width - 64)
                        anchors.centerIn: parent
                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape
                        standardButtons: Dialog.NoButton
                        onOpened: Qt.callLater(function() {
                            if (contractDetailsDialog.visible)
                                detailsCloseButton.forceActiveFocus(Qt.TabFocusReason)
                        })
                        onClosed: Qt.callLater(function() {
                            if (showContractDetailsButton.visible && showContractDetailsButton.enabled)
                                showContractDetailsButton.forceActiveFocus(Qt.TabFocusReason)
                            else if (rentalList.visible)
                                rentalList.forceActiveFocus(Qt.TabFocusReason)
                        })
                        contentItem: ColumnLayout {
                            spacing: 10
                            Label {
                                text: "Read-only contract data from C++. No customer contact or payment details."
                                color: ink
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                            }
                            Label {
                                objectName: "rentalDetailIdentity"
                                text: "Rental: " + (rentalsModel.selectedContract.rentalId || "None") +
                                      "  ·  Vehicle: " + (rentalsModel.selectedContract.vehicleId || "None")
                                color: navy; font.bold: true
                                Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailStatus"
                                text: "Status: " + (rentalsModel.selectedContract.status || "Not selected") +
                                      "  ·  Due: " + (rentalsModel.selectedContract.dueState || "Unknown")
                                color: navy
                                Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailStart"
                                text: "Start date: " + (rentalsModel.selectedContract.startDate || "Not recorded")
                                color: ink; Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailExpected"
                                text: "Expected return: " + (rentalsModel.selectedContract.expectedReturnDate || "Not recorded")
                                color: ink; Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailActual"
                                text: "Actual return: " + (rentalsModel.selectedContract.actualReturnDate || "Not returned")
                                color: ink; Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailDuration"
                                text: "Rental days: " + (rentalsModel.selectedContract.days || 0)
                                color: ink; Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailRate"
                                text: "Daily rate: R " + Number(rentalsModel.selectedContract.dailyRate || 0).toFixed(2)
                                color: ink; Accessible.name: text
                            }
                            Label {
                                objectName: "rentalDetailTotal"
                                text: "Booked contract total: R " + Number(rentalsModel.selectedContract.total || 0).toFixed(2)
                                color: navy; font.bold: true
                                Accessible.name: text
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                Item { Layout.fillWidth: true }
                                Button {
                                    id: detailsCloseButton
                                    objectName: "rentalDetailsClose"
                                    text: "Close"
                                    Layout.minimumHeight: 36
                                    activeFocusOnTab: true
                                    Accessible.name: "Close rental contract details"
                                    onClicked: contractDetailsDialog.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
