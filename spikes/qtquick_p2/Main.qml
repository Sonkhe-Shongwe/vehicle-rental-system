import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    id: window
    width: 1500; height: 860
    minimumWidth: 1024; minimumHeight: 660
    visible: true
    title: p7SqlLabEnabled ? "Rental Studio 2.0 · isolated fictional SQLite Lab" :
           persistentFictionalDemo
           ? "Rental Studio 2.0 · persistent fictional-only demo"
           : "Rental Studio 2.0 · operational overview · fictional demo"

    // Shared owner-selected tokens; preserve the existing local bindings.
    DesignTokens { id: designTokens }
    // Keep the native Windows titlebar to preserve window accessibility.
    // MotionPolicy is C++-owned; no OS rules or filesystem access in QML.
    readonly property bool reducedMotion: motionPolicy.reducedMotion
    readonly property int selectionFadeMs: motionPolicy.selectionFadeMs
    readonly property color navy: designTokens.navy
    readonly property color teal: designTokens.teal
    readonly property color canvas: designTokens.canvas
    readonly property color ice: designTokens.ice
    readonly property color mint: designTokens.mint
    readonly property color ink: designTokens.ink
    // Direction A: lead with the operational Overview on normal launch.
    property int workspace: 0
    property bool gallery: true
    // Shell presentation only: never changes workspace, selection or C++ records.
    property bool sidebarCollapsed: false
    // Return focus to the actual invoker of the native booking dialogue.
    property bool bookingFromSidebar: false
    // Confirmed receipt survives closing the ephemeral preview dialog.
    // Only the C++-verified success branch populates this display string.
    property string bookingReceiptNotice: ""
    // Cancellation is a separate informational outcome, never a receipt.
    property string bookingCancelledNotice: ""
    property string rentalLookupFeedback: ""
    property string returnLookupFeedback: ""
    // The C++ read service owns all due-date decisions. The local calendar
    // key is only a cheap reason to ask it for a fresh read-only snapshot.
    // It prevents all-day stale Due today / Overdue labels across midnight
    // or after the desktop resumes from sleep.
    property string lastRentalCalendarDay: Qt.formatDate(new Date(), "yyyy-MM-dd")
    function refreshRentalDueIfCalendarChanged(dayKey) {
        if (!dayKey || dayKey === window.lastRentalCalendarDay)
            return false
        window.lastRentalCalendarDay = dayKey
        rentalsModel.refresh()
        return true
    }
    onActiveChanged: {
        if (active)
            window.refreshRentalDueIfCalendarChanged(
                Qt.formatDate(new Date(), "yyyy-MM-dd"))
    }
    Timer {
        objectName: "rentalDayRefreshTimer"
        interval: 60000
        running: window.visible
        repeat: true
        onTriggered: window.refreshRentalDueIfCalendarChanged(
            Qt.formatDate(new Date(), "yyyy-MM-dd"))
    }
    // Last replacement outcome is shown in the existing Fleet message lane.
    // Capture the target before the native picker can change focus/selection.
    property string photoChangeTargetId: ""
    property string photoChangeNotice: ""
    property string photoResetTargetId: ""
    // Locked, read-only reference-image inspection. Neither the preview
    // nor its close action changes authoritative fleet/photo storage.
    property string fullPhotoTargetId: ""
    property string fullPhotoTargetName: ""

    function openFullFleetPhoto() {
        if (window.workspace !== 1 || fleet.selectedId === "" ||
                !fleetPhotos.hasPhoto(fleet.selectedId) ||
                inspectorPhoto.status !== Image.Ready)
            return false
        window.fullPhotoTargetId = fleet.selectedId
        window.fullPhotoTargetName = fleet.selectedName
        fleetFullPhotoDialog.open()
        return true
    }

    // Precision Automotive shell shortcut. This reuses the existing native
    // booking dialogue and C++ preview/confirm path; no new booking logic.
    function beginNewRental(fromSidebar) {
        if (bookingDialog.visible) return false
        window.bookingFromSidebar = !!fromSidebar
        window.bookingReceiptNotice = ""
        window.bookingCancelledNotice = ""
        bookingActions.discardPreview()
        window.workspace = 2
        Qt.callLater(function() {
            if (window.workspace === 2 && !bookingDialog.visible)
                bookingDialog.open()
        })
        return true
    }

    // Carry the exact selected, AVAILABLE Fleet ID into the existing native
    // guided booking modal. C++ quote/confirm still owns all business rules.
    function bookSelectedFleetVehicle() {
        if (window.workspace !== 1 || fleet.selectedId === "" ||
                !fleet.selectedAvailable)
            return
        const selectedId = fleet.selectedId
        window.bookingFromSidebar = false
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
    // Keep the C++ photo store authoritative. This function is exercised in
    // real native QML tests, not merely by staging Add Vehicle media.
    function applySelectedFleetPhoto(fileUrl) {
        const id = window.photoChangeTargetId
        window.photoChangeTargetId = ""
        if(persistentFictionalDemo || window.workspace !== 1 || id === "" ||
                fleet.selectedId !== id) {
            window.photoChangeNotice = "Photo unchanged. Select the vehicle again before changing its photo."
            return false
        }
        const saved = fleetPhotos.replaceFor(id, fileUrl)
        window.photoChangeNotice = saved
            ? "Photo updated for " + id + " in this temporary demo."
            : "Photo unchanged for " + id + ". " + fleetPhotos.feedback
        return saved
    }

    // Only explicitly chosen local media may override a fictional Fleet photo.
    // Cancel never mutates the prior photo or the rental business records.
    FileDialog {
        id: selectedFleetPhotoDialog
        objectName: "fleetReplacePhotoPicker"
        title: "Choose a replacement fictional vehicle photo"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Images (*.png *.jpg *.jpeg *.webp)"]
        onAccepted: {
            window.applySelectedFleetPhoto(selectedFile)
            Qt.callLater(function() {
                if (window.workspace === 1 && fleetReplacePhotoButton.visible &&
                        fleetReplacePhotoButton.enabled)
                    fleetReplacePhotoButton.forceActiveFocus(Qt.TabFocusReason)
            })
        }
        onRejected: {
            window.photoChangeTargetId = ""
            Qt.callLater(function() {
                if (window.workspace === 1 && fleetReplacePhotoButton.visible &&
                        fleetReplacePhotoButton.enabled)
                    fleetReplacePhotoButton.forceActiveFocus(Qt.TabFocusReason)
            })
        }
    }

    // A reset removes only the optional local override after user
    // confirmation. Default repo imagery and C++ fleet records are untouched.
    function confirmFleetPhotoReset() {
        const id = window.photoResetTargetId
        window.photoResetTargetId = ""
        if (persistentFictionalDemo || window.workspace !== 1 || id === "" ||
                fleet.selectedId !== id) {
            window.photoChangeNotice = "Photo unchanged. Select the vehicle again before restoring the default."
            return false
        }
        const restored = fleetPhotos.restoreDefaultFor(id)
        window.photoChangeNotice = restored
            ? "Default image restored for " + id + "."
            : "Photo unchanged for " + id + ". " + fleetPhotos.feedback
        return restored
    }

    Dialog {
        id: fleetRestorePhotoDialog
        objectName: "fleetRestorePhotoDialog"
        title: "Restore default image?"
        modal: true
        focus: true
        width: Math.min(420, parent ? parent.width - 48 : 400)
        x: parent ? (parent.width - width) / 2 : 0
        y: parent ? (parent.height - height) / 2 : 0
        standardButtons: Dialog.NoButton
        closePolicy: Popup.CloseOnEscape
        onAccepted: window.confirmFleetPhotoReset()
        onClosed: {
            window.photoResetTargetId = ""
            // After removal the reset action hides. Restore focus to an
            // available, visible Inspector control rather than losing it.
            Qt.callLater(function() {
                if (window.workspace !== 1)
                    return
                if (fleetRestoreDefaultPhotoButton.visible &&
                        fleetRestoreDefaultPhotoButton.enabled)
                    fleetRestoreDefaultPhotoButton.forceActiveFocus(Qt.TabFocusReason)
                else if (fleetReplacePhotoButton.visible &&
                         fleetReplacePhotoButton.enabled)
                    fleetReplacePhotoButton.forceActiveFocus(Qt.TabFocusReason)
            })
        }
        contentItem: ColumnLayout {
            spacing: 14
            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "Remove the custom photo for " + window.photoResetTargetId
                      + "? The original illustration or neutral vehicle silhouette will return. "
                      + "This cannot recover the custom photo."
                color: window.navy
                Accessible.name: text
            }
            RowLayout {
                Layout.fillWidth: true
                Button {
                    objectName: "fleetRestoreDefaultCancel"
                    text: "Keep photo"
                    activeFocusOnTab: true
                    onClicked: fleetRestorePhotoDialog.reject()
                }
                Item { Layout.fillWidth: true }
                Button {
                    objectName: "fleetRestoreDefaultConfirm"
                    text: "Restore default"
                    activeFocusOnTab: true
                    Accessible.name: "Confirm removing the custom fictional vehicle photo"
                    onClicked: fleetRestorePhotoDialog.accept()
                }
            }
        }
    }

    // Show the FULL reference image without Gallery/Inspector cropping.
    // This is a reversible inspection aid, not a newly licensed photo.
    Dialog {
        id: fleetFullPhotoDialog
        objectName: "fleetFullPhotoDialog"
        title: "Full reference image"
        modal: true
        focus: true
        standardButtons: Dialog.NoButton
        closePolicy: Popup.CloseOnEscape
        width: Math.min(860, parent ? parent.width - 40 : 820)
        height: Math.min(660, parent ? parent.height - 40 : 600)
        x: parent ? (parent.width - width) / 2 : 0
        y: parent ? (parent.height - height) / 2 : 0
        readonly property var activeCredit: fleetPhotos.revision >= 0 &&
            window.fullPhotoTargetId !== ""
            ? fleetPhotos.attributionFor(window.fullPhotoTargetId) : ({})
        onClosed: {
            window.fullPhotoTargetId = ""
            window.fullPhotoTargetName = ""
            Qt.callLater(function() {
                if (window.workspace === 1 && fleetViewFullPhotoButton.visible &&
                        fleetViewFullPhotoButton.enabled)
                    fleetViewFullPhotoButton.forceActiveFocus(Qt.TabFocusReason)
            })
        }
        contentItem: ColumnLayout {
            spacing: 10
            Label {
                objectName: "fleetFullPhotoHeading"
                Layout.fillWidth: true
                text: window.fullPhotoTargetName + " · " + window.fullPhotoTargetId
                color: window.navy
                font.bold: true
                font.pixelSize: 18
                elide: Text.ElideRight
                Accessible.name: text
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: window.ice
                radius: 10
                clip: true
                Image {
                    id: fleetFullPhotoImage
                    objectName: "fleetFullPhotoImage"
                    anchors.fill: parent
                    anchors.margins: 8
                    source: window.fullPhotoTargetId !== "" &&
                            fleetPhotos.hasPhoto(window.fullPhotoTargetId)
                        ? "image://fleetphotos/" + window.fullPhotoTargetId +
                          "?v=" + fleetPhotos.revision : ""
                    fillMode: Image.PreserveAspectFit
                    cache: false
                    asynchronous: false
                    Accessible.name: "Full uncropped illustrative reference photo for " +
                                     window.fullPhotoTargetName
                    Accessible.description: "Complete source image fitted within the viewing area, " +
                                            "not a photograph of the actual rented vehicle"
                }
            }
            Label {
                objectName: "fleetFullPhotoDisclosure"
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: "Illustrative model reference only. This is not a verified photo of an actual fleet vehicle."
                color: window.ink
                font.pixelSize: 12
                Accessible.name: text
            }
            Label {
                objectName: "fleetFullPhotoCredit"
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                text: fleetFullPhotoDialog.activeCredit.kind === "custom"
                    ? "Operator-selected fictional photo · licence not verified"
                    : fleetFullPhotoDialog.activeCredit.creator
                      ? "Photo: " + fleetFullPhotoDialog.activeCredit.creator +
                        " · " + fleetFullPhotoDialog.activeCredit.licence
                      : "Photo source metadata unavailable; do not assume a licence."
                color: window.navy
                font.pixelSize: 12
                Accessible.name: text
            }
            Label {
                objectName: "fleetFullPhotoSource"
                Layout.fillWidth: true
                visible: !!fleetFullPhotoDialog.activeCredit.sourcePage
                text: "Original source: " + (fleetFullPhotoDialog.activeCredit.sourcePage || "")
                color: window.ink
                font.pixelSize: 11
                elide: Text.ElideMiddle
                Accessible.name: text
                Accessible.description: "Offline source reference; no network request is made"
            }
            RowLayout {
                Layout.fillWidth: true
                Item { Layout.fillWidth: true }
                Button {
                    objectName: "fleetFullPhotoClose"
                    text: "Close"
                    activeFocusOnTab: true
                    Accessible.name: "Close full image and return to vehicle details"
                    onClicked: fleetFullPhotoDialog.close()
                }
            }
        }
    }

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
        function onSelectionChanged() {
            Qt.callLater(window.syncCurrentVehicle)
            window.photoChangeNotice = ""
            // A read-only preview must never show a prior vehicle after
            // the authoritative C++ selection has changed.
            if (window.fullPhotoTargetId !== "" &&
                    fleet.selectedId !== window.fullPhotoTargetId)
                fleetFullPhotoDialog.close()
        }
        function onQueryChanged() { Qt.callLater(window.syncCurrentVehicle) }
        function onStatusChanged() { Qt.callLater(window.syncCurrentVehicle) }
        function onSortByChanged() { Qt.callLater(window.syncCurrentVehicle) }
    }

    // Translate only C++ due-state codes for operator display. Dates,
    // overdue decisions, contract status and writes remain C++-owned.
    function dueStateLabel(state) {
        switch (state) {
        case "NotApplicable": return "No return due"
        case "NotDue": return "On schedule"
        case "DueToday": return "Due today"
        case "Overdue": return "Overdue"
        default: return "Due date unavailable"
        }
    }

    // Presentation formatting only; the C++ value is authoritative.
    function rentalMoney(value) {
        const parts = Number(value || 0).toFixed(2).split(".")
        return "R " + parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") +
               "." + parts[1]
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
        if (event.key === Qt.Key_Up) {
            if (rentalsModel.selectedRow <= 0)
                focusEnabled(rentalLookupField)
            else
                navigateRentals(-1)
        } else if (event.key === Qt.Key_Down) {
            if (rentalsModel.count > 0 &&
                    rentalsModel.selectedRow === rentalsModel.count - 1) {
                if (!focusEnabled(showContractDetailsButton))
                    navigateRentals(1)
            } else
                navigateRentals(1)
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter ||
                   event.key === Qt.Key_Space)
            openSelectedRentalDetails(true)
        else
            return
        event.accepted = true
    }

    // UX-CTRL-003: remembering region focus is distinct from selected C++ IDs.
    property int lastOverviewQuickFocus: 0
    property int lastRentalStatusFocus: 0
    property int lastRentalDueFocus: 0
    property int lastRentalReturnFocus: 0
    property int lastRentalActionFocus: 0
    // A vertical transition must reveal its destination inside Rentals.
    // No global pixel-distance navigation search is performed.
    function revealRentalFocus(item) {
        if (window.workspace !== 2 || !rentalsPageScroll.visible) return
        const top = item.mapToItem(rentalPageContent,0,0).y
        const bottom = top + item.height
        const page = rentalsPageScroll
        const maxY = Math.max(0,page.contentHeight-page.height)
        let next = page.contentY
        if (top < next + 12 || item.height > page.height - 24)
            next = top - 12
        else if (bottom > next + page.height - 12)
            next = bottom - page.height + 12
        page.contentY = Math.max(0,Math.min(maxY,next))
    }
    // Only explicit bounded neighbors are navigated. Text native caret wins.
    function focusEnabled(item) {
        if (!item || !item.visible || !item.enabled)
            return false
        item.forceActiveFocus(Qt.TabFocusReason)
        revealRentalFocus(item)
        return true
    }
    function focusRentalStatus() {
        return focusEnabled(rentalStatusRepeater.itemAt(lastRentalStatusFocus)) ||
               focusEnabled(rentalStatusRepeater.itemAt(0))
    }
    function focusRentalDue() {
        return focusEnabled(rentalDueRepeater.itemAt(lastRentalDueFocus)) ||
               focusEnabled(rentalDueRepeater.itemAt(0))
    }
    function focusReturnLookup() {
        const previous = lastRentalReturnFocus === 1
            ? returnLookupButton : returnLookupField
        return focusEnabled(previous) || focusEnabled(returnLookupField)
    }
    function focusRentalAction() {
        const controls = [newBookingButton,returnSelectedButton,
                          archiveActionButton,deleteArchivedButton]
        return focusEnabled(controls[lastRentalActionFocus]) ||
               focusEnabled(newBookingButton)
    }
    function rentalActionKey(event,index) {
        if (event.modifiers !== Qt.NoModifier) return
        const controls = [newBookingButton,returnSelectedButton,
                          archiveActionButton,deleteArchivedButton]
        if (activateFocusedButton(event,controls[index])) return
        if (event.key === Qt.Key_Left) {
            if (index === 0) focusSidebar()
            else {
                for(let i=index-1;i>=1;--i)
                    if(focusEnabled(controls[i]))break
            }
        } else if (event.key === Qt.Key_Right) {
            for(let i=Math.max(1,index+1);i<controls.length;++i)
                if(focusEnabled(controls[i]))break
        } else if (event.key === Qt.Key_Up) {
            if(index!==0)focusEnabled(newBookingButton)
        } else if (event.key === Qt.Key_Down) {
            if(index===0) {
                let next = false
                if(lastRentalActionFocus>0)
                    next=focusEnabled(controls[lastRentalActionFocus])
                if(!next)for(let i=1;i<controls.length;++i)
                    if(focusEnabled(controls[i])){next=true;break}
                if(!next)focusReturnLookup()
            } else focusReturnLookup()
        } else return
        event.accepted = true
    }
    function overviewRecentKey(event,index) {
        if (event.modifiers !== Qt.NoModifier) return
        if (activateFocusedButton(event,overviewRecentRepeater.itemAt(index)))
            return
        if (event.key === Qt.Key_Up) {
            if (index===0)
                focusEnabled([overviewActiveButton,overviewFleetButton,
                              overviewOverdueAction][lastOverviewQuickFocus])
            else
                focusEnabled(overviewRecentRepeater.itemAt(index-1))
        } else if (event.key === Qt.Key_Down)
            focusEnabled(overviewRecentRepeater.itemAt(index+1))
        else if (event.key === Qt.Key_Left)
            focusSidebar()
        else return
        event.accepted = true
    }
    function focusSidebar() {
        return focusEnabled(workspaceItems.itemAt(window.workspace))
    }
    function enterWorkspaceContent(index) {
        if (index !== window.workspace)
            return false
        if (index === 0)
            return focusEnabled(overviewActiveButton)
        if (index === 1)
            return focusEnabled(search)
        if (index === 2)
            return focusEnabled(rentalStatusRepeater.itemAt(0))
        return false // Lab is a separate opt-in surface with its own focus.
    }
    function activateFocusedButton(event, button) {
        if (event.modifiers !== Qt.NoModifier ||
            (event.key !== Qt.Key_Return && event.key !== Qt.Key_Enter) ||
            !button || !button.visible || !button.enabled)
            return false
        button.clicked()
        event.accepted = true
        return true
    }
    function overviewQuickKey(event, index) {
        if (event.modifiers !== Qt.NoModifier)
            return
        const controls = [overviewActiveButton, overviewFleetButton,
                          overviewOverdueAction]
        if (activateFocusedButton(event,controls[index]))
            return
        if (event.key === Qt.Key_Down) {
            if (focusEnabled(overviewRecentRepeater.itemAt(0)))
                event.accepted = true
            return
        }
        if (event.key === Qt.Key_Left) {
            if (index === 0)
                focusSidebar()
            else {
                for (let i=index-1; i>=0; --i)
                    if (focusEnabled(controls[i])) break
            }
        } else if (event.key === Qt.Key_Right) {
            for (let i=index+1; i<controls.length; ++i)
                if (focusEnabled(controls[i])) break
        } else return
        event.accepted = true
    }
    function rentalStatusKey(event, index) {
        if (event.modifiers !== Qt.NoModifier)
            return
        if (activateFocusedButton(event,rentalStatusRepeater.itemAt(index)))
            return
        if (event.key === Qt.Key_Left) {
            if (index === 0) focusSidebar()
            else focusEnabled(rentalStatusRepeater.itemAt(index-1))
        } else if (event.key === Qt.Key_Right)
            focusEnabled(rentalStatusRepeater.itemAt(index+1))
        else if (event.key === Qt.Key_Up)
            focusReturnLookup()
        else if (event.key === Qt.Key_Down)
            focusRentalDue()
        else return
        event.accepted = true
    }
    function rentalDueKey(event, index) {
        if (event.modifiers !== Qt.NoModifier)
            return
        if (activateFocusedButton(event,rentalDueRepeater.itemAt(index)))
            return
        if (event.key === Qt.Key_Left) {
            if (index === 0) focusSidebar()
            else focusEnabled(rentalDueRepeater.itemAt(index-1))
        } else if (event.key === Qt.Key_Right)
            focusEnabled(rentalDueRepeater.itemAt(index+1))
        else if (event.key === Qt.Key_Up)
            focusRentalStatus()
        else if (event.key === Qt.Key_Down)
            focusEnabled(rentalLookupField)
        else return
        event.accepted = true
    }
    function focusFleetCollection() {
        const view = window.gallery ? galleryView : tableView
        if (!view || !view.visible)
            return false
        if (view.count > 0) {
            const selected = fleet.selectedVisibleIndex()
            view.currentIndex = selected >= 0 ? selected : 0
            view.positionViewAtIndex(view.currentIndex, GridView.Contain)
        }
        return focusEnabled(view)
    }
    function fleetViewToggleKey(event, useGallery) {
        if (event.modifiers !== Qt.NoModifier)
            return
        if (activateFocusedButton(event,
                useGallery ? fleetGalleryToggle : fleetTableToggle))
            return
        if (event.key === Qt.Key_Down) {
            if (focusFleetCollection())
                event.accepted = true
        } else if (event.key === Qt.Key_Up) {
            if (focusEnabled(search))
                event.accepted = true
        } else if (event.key === Qt.Key_Right && useGallery) {
            if (focusEnabled(fleetTableToggle))
                event.accepted = true
        } else if (event.key === Qt.Key_Left && !useGallery) {
            if (focusEnabled(fleetGalleryToggle))
                event.accepted = true
        }
    }
    function enterRentalRecords() {
        if (!rentalsModel.snapshotAvailable)
            return false
        if (rentalsModel.count === 0)
            return focusEnabled(rentalEmptyReset)
        let row = rentalsModel.selectedRow
        if (row < 0) {
            if (!rentalsModel.selectVisibleRow(0))
                return false
            row = 0
        }
        rentalList.currentIndex = row
        rentalList.positionViewAtIndex(row, ListView.Contain)
        return focusEnabled(rentalList)
    }
    property bool contractDetailsFromRow: false
    property string contractDetailsOpenedId: ""
    function openSelectedRentalDetails(fromRow) {
        if (!rentalsModel.snapshotAvailable ||
                !rentalsModel.selectedContract.rentalId)
            return false
        window.contractDetailsOpenedId = rentalsModel.selectedRentalId
        window.contractDetailsFromRow = fromRow
        contractDetailsDialog.open()
        return true
    }
    function revokeOpenContractDetails() {
        if (contractDetailsDialog.visible)
            contractDetailsDialog.close()
    }

    // A deliberate lookup can reveal an ID hidden by the current filter.
    // Domain history and financial data are never modified by this route.
    function findRentalById() {
        const result = rentalsModel.locateForOperator(rentalLookupField.text)
        if (result !== "Selected") {
            window.rentalLookupFeedback = result === "Empty"
                ? "Enter a rental ID or vehicle ID."
                : result === "Ambiguous"
                  ? "Multiple rentals use that vehicle ID. Enter the exact rental ID."
                  : result === "Unavailable"
                    ? "Rental data unavailable. Lookup requires a verified refresh."
                    : "Rental or vehicle ID not found."
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

    // An existing modal review is no longer current after C++ replaces its
    // authoritative rental snapshot, even if the selected ID survives.
    // Capture only the FIRST invalidation reason for an open review.
    function invalidateOpenRentalReviews(reason) {
        if (returnConfirmation.visible && !returnConfirmation.reviewInvalidated) {
            returnConfirmation.reviewInvalidated = true
            returnConfirmation.reviewInvalidationReason = reason
        }
        if (archiveConfirmation.visible && !archiveConfirmation.reviewInvalidated) {
            archiveConfirmation.reviewInvalidated = true
            archiveConfirmation.reviewInvalidationReason = reason
        }
    }

    Connections {
        target: rentalsModel
        function onSelectionChanged() {
            if (contractDetailsDialog.visible &&
                    rentalsModel.selectedRentalId !== window.contractDetailsOpenedId)
                window.revokeOpenContractDetails()
            // Lookup feedback describes the result of a specific deliberate
            // selection. Pointer, keyboard, or domain navigation elsewhere
            // must not keep claiming an older record is selected.
            window.rentalLookupFeedback = ""
            window.returnLookupFeedback = ""
            // A temporary selection switch cannot revive previous consent,
            // even when it returns to the original rental ID.
            if (returnConfirmation.visible &&
                    rentalsModel.selectedRentalId !== returnConfirmation.targetId &&
                    !returnConfirmation.reviewInvalidated) {
                returnConfirmation.reviewInvalidated = true
                returnConfirmation.reviewInvalidationReason = "Selection changed."
            }
            if (archiveConfirmation.visible &&
                    rentalsModel.selectedRentalId !== archiveConfirmation.targetId &&
                    !archiveConfirmation.reviewInvalidated) {
                archiveConfirmation.reviewInvalidated = true
                archiveConfirmation.reviewInvalidationReason = "Selection changed."
            }
            Qt.callLater(window.syncCurrentRental)
        }
        // A clock rollover or any authoritative model refresh can alter the
        // visible contract details without emitting selectionChanged.
        function onModelReset() {
            // Never leave the old read-only modal showing stale money or status.
            window.revokeOpenContractDetails()
            // A reset may preserve selected ID while changing its state.
            // Neither lookup's earlier success/miss is current afterward.
            window.rentalLookupFeedback = ""
            window.returnLookupFeedback = ""
            window.invalidateOpenRentalReviews("Rental data refreshed.")
            Qt.callLater(window.syncCurrentRental)
        }
        function onStatusFilterChanged() {
            // A filter change can retain the selected ID without emitting
            // selectionChanged. Clear old lookup feedback in that case too.
            window.rentalLookupFeedback = ""
            window.returnLookupFeedback = ""
            Qt.callLater(window.syncCurrentRental)
        }
        function onSnapshotAvailabilityChanged() {
            if (!rentalsModel.snapshotAvailable)
                window.revokeOpenContractDetails()
            // A failed read leaves a last-known selection buffered but no
            // verified record. Never retain a misleading "Selected" receipt.
            window.rentalLookupFeedback = ""
            window.returnLookupFeedback = ""
            if (!rentalsModel.snapshotAvailable)
                window.invalidateOpenRentalReviews("Rental data unavailable.")
        }
    }

    function handleVehicleArrow(event) {
        // Deliberately do NOT intercept Tab/Shift+Tab, Enter/Space, Escape,
        // text-input cursor keys or native ComboBox arrow controls.
        if (event.modifiers !== Qt.NoModifier)
            return
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter ||
                 event.key === Qt.Key_Space) {
            const view = window.gallery ? galleryView : tableView
            if (view.count > 0 && view.currentItem && view.currentItem.vehicleId)
                fleet.selectById(view.currentItem.vehicleId)
            else if (view.count > 0)
                navigateVehicles(0,0)
            event.accepted = true
            return
        }
        if (event.key === Qt.Key_Up) {
            const view = window.gallery ? galleryView : tableView
            const selected = fleet.selectedVisibleIndex()
            const row = selected >= 0 ? selected : Math.max(0,view.currentIndex)
            const columns = window.gallery
                ? Math.max(1,Math.round(galleryView.width/galleryView.cellWidth)) : 1
            if(row < columns)
                focusEnabled(window.gallery ? fleetGalleryToggle : fleetTableToggle)
            else
                navigateVehicles(-1,0)
        } else if (event.key === Qt.Key_Down) navigateVehicles(1,0)
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
    // Windows-standard search route: useful from Overview and Rentals without
    // requiring pointer navigation. Never steal keyboard input from a modal.
    Shortcut {
        sequence: "Ctrl+F"
        enabled: !bookingDialog.visible &&
                 !returnConfirmation.visible && !archiveConfirmation.visible &&
                 !archivedDeleteDialog.visible && !contractDetailsDialog.visible &&
                 !fleetAddDialog.visible && !fleetRemoveDialog.visible
        onActivated: {
            window.workspace = 1
            Qt.callLater(function() {
                if (window.workspace === 1 && search.visible)
                    search.forceActiveFocus(Qt.ShortcutFocusReason)
            })
        }
    }
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

    // Page keys scroll the active operations page without changing rental
    // selection or business state. The SQLite Lab is opt-in and fictional only.
    function scrollOperationsPage(direction) {
        const page = window.workspace === 2 ? rentalsPageScroll :
                     (p7SqlLabEnabled && window.workspace === 3
                      ? p7SqlLabLoader.item : null)
        if (!page)
            return
        const limit = Math.max(0, page.contentHeight - page.height)
        const distance = Math.max(140, page.height * 0.8)
        page.contentY = Math.max(0, Math.min(limit, page.contentY + direction * distance))
    }
    Shortcut {
        sequence: "PgDown"
        enabled: (window.workspace === 2 ||
                  (p7SqlLabEnabled && window.workspace === 3)) &&
                 !bookingDialog.visible && !returnConfirmation.visible &&
                 !archiveConfirmation.visible && !archivedDeleteDialog.visible &&
                 !contractDetailsDialog.visible
        onActivated: window.scrollOperationsPage(1)
    }
    Shortcut {
        sequence: "PgUp"
        enabled: (window.workspace === 2 ||
                  (p7SqlLabEnabled && window.workspace === 3)) &&
                 !bookingDialog.visible && !returnConfirmation.visible &&
                 !archiveConfirmation.visible && !archivedDeleteDialog.visible &&
                 !contractDetailsDialog.visible
        onActivated: window.scrollOperationsPage(-1)
    }
    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: appSidebar
            objectName: "appSidebar"
            Layout.fillHeight: true
            Layout.preferredWidth: window.sidebarCollapsed ?
                designTokens.sidebarCollapsedWidth : designTokens.sidebarExpandedWidth
            color: designTokens.shell
            border.width: 1
            border.color: designTokens.shellBorder
            clip: true
            // Approved reference: discreet evergreen footer sweeps only.
            // Decorations are clipped and sit behind the real controls.
            Rectangle {
                id: editorialSidebarWave
                objectName: "editorialSidebarWave"
                width: 475; height: 240
                x: -165
                y: appSidebar.height - 181
                rotation: -14
                radius: 120
                color: designTokens.shellFooterWave
                opacity: 0.68
                Accessible.ignored: true
            }
            Rectangle {
                width: 450; height: 170
                x: -200
                y: appSidebar.height - 101
                rotation: -14
                radius: 85
                color: "#082F2A"
                opacity: 0.52
                Accessible.ignored: true
            }
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: window.sidebarCollapsed ? 12 : 14
                spacing: 12
                RowLayout {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 17
                    spacing: 5
                    Rectangle {
                        visible: !window.sidebarCollapsed
                        objectName: "editorialBrandMark"
                        Layout.preferredWidth: visible ? 36 : 0
                        Layout.preferredHeight: 36
                        radius: 10
                        color: "#075A48"
                        border.width: 1
                        border.color: "#1C896F"
                        Label {
                            anchors.centerIn: parent
                            text: "R"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#A2F6DB"
                            font.family: designTokens.shellFontFamily
                        }
                    }
                    ColumnLayout {
                        visible: !window.sidebarCollapsed
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        spacing: 1
                        Label {
                            text: "Rental Studio"
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            color: designTokens.shellText
                            font.pixelSize: 14
                            font.family: designTokens.shellFontFamily
                            font.bold: true
                        }
                        Label {
                            text: "VEHICLE OPERATIONS"
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            color: designTokens.shellMuted
                            font.pixelSize: 8
                            font.bold: true
                            font.letterSpacing: 0.4
                        }
                    }
                    Button {
                        id: sidebarToggle
                        objectName: "sidebarToggleButton"
                        text: window.sidebarCollapsed ? "Expand sidebar" : "Collapse sidebar"
                        Layout.preferredWidth: 36
                        Layout.preferredHeight: 36
                        Layout.alignment: window.sidebarCollapsed ?
                                          Qt.AlignHCenter : Qt.AlignRight
                        activeFocusOnTab: true
                        hoverEnabled: true
                        ToolTip.visible: hovered
                        ToolTip.text: text
                        Accessible.name: text
                        Accessible.description: "Toggle navigation labels. Workspace and record selection remain unchanged."
                        background: Rectangle {
                            radius: 10
                            color: sidebarToggle.hovered ? designTokens.shellHover : "#1B2826"
                            border.width: sidebarToggle.activeFocus ? 3 : 1
                            border.color: sidebarToggle.activeFocus ? designTokens.shellFocus : designTokens.shellBorder
                        }
                        contentItem: Item {
                            SidebarGlyph {
                                anchors.centerIn: parent
                                width: 22
                                height: 22
                                kind: window.sidebarCollapsed ? "expand" : "collapse"
                                glyphColor: designTokens.shellText
                            }
                        }
                        onClicked: window.sidebarCollapsed = !window.sidebarCollapsed
                    }
                }
                PrecisionPrimaryButton {
                    id: sidebarNewRentalButton
                    objectName: "sidebarNewRentalButton"
                    compact: window.sidebarCollapsed
                    text: "New rental"
                    onClicked: window.beginNewRental(true)
                }
                Label {
                    visible: !window.sidebarCollapsed
                    text: "WORKSPACES"
                    font.pixelSize: 10
                    font.family: designTokens.shellFontFamily
                    font.bold: true
                    font.letterSpacing: 1.2
                    color: designTokens.shellMuted
                    Layout.leftMargin: 12
                    Layout.bottomMargin: 2
                }
                Repeater {
                    id: workspaceItems
                    model: p7SqlLabEnabled ?
                               ["Overview", "Fleet", "Rentals", "SQLite Lab"] :
                               ["Overview", "Fleet", "Rentals"]
                    delegate: WorkspaceNavButton {
                        sidebarCollapsed: window.sidebarCollapsed
                        currentWorkspace: window.workspace === index
                        workspaceItems: workspaceItems
                        onClicked: window.workspace = index
                        onEnterContent: window.enterWorkspaceContent(index)
                    }
                }
                Item { Layout.fillHeight: true }
                Rectangle {
                    visible: !window.sidebarCollapsed
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: designTokens.shellBorder
                }
                RowLayout {
                    visible: !window.sidebarCollapsed
                    Layout.fillWidth: true
                    spacing: 8
                    Rectangle {
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 5
                        implicitWidth: 7
                        implicitHeight: 7
                        radius: 4
                        color: designTokens.teal
                    }
                    Label {
                    objectName: "sessionModeSidebar"
                    Layout.fillWidth: true
                    text: p7SqlLabEnabled
                          ? "Fictional SQLite Lab\nSeparate from the demo fleet"
                          : portfolioShowcase
                          ? fleet.totalCount + "-vehicle portfolio demo\nChanges reset when you close"
                          : persistentFictionalDemo
                          ? "Fictional demo\nBookings survive restart"
                          : "Fictional demo\nChanges reset when you close"
                    color: designTokens.shellMuted
                    font.pixelSize: 11
                    font.family: designTokens.shellFontFamily
                    wrapMode: Text.WordWrap
                    Accessible.name: text
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: window.height < 800 ? 18 : 24
            spacing: window.height < 800 ? 12 : 18

            RowLayout {
                Layout.fillWidth: true
                spacing: 12
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 3
                    Label {
                        objectName: "workspacePageHeading"
                        text: window.workspace === 0 ? "Your fleet. Your next move." :
                              window.workspace === 1 ? "Your fleet, beautifully organised." :
                              window.workspace === 2 ? "Every contract, in clear view." : "Fictional SQLite Lab"
                        font.pixelSize: window.height < 800 ?
                            designTokens.pageHeadingSizeCompact : designTokens.pageHeadingSizeWide
                        font.weight: Font.DemiBold
                        font.family: designTokens.shellFontFamily
                        color: designTokens.pageHeading
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Label {
                        objectName: "workspacePageSubtitle"
                        text: window.workspace === 0
                            ? "An immediate view of what is ready, active and needs attention"
                            : window.workspace === 1
                            ? "Explore every vehicle, understand availability and take the right action"
                            : window.workspace === 2
                            ? "The register comes first. Actions follow the selected contract."
                            : "Isolated fictional persistence preview"
                        color: designTokens.secondaryText
                        font.family: designTokens.shellFontFamily
                        font.pixelSize: designTokens.pageSubtitleSize
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
                Rectangle {
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredHeight: 34
                    Layout.preferredWidth: sessionModeNotice.implicitWidth + 22
                    radius: 9
                    color: designTokens.quietSurface
                    border.width: 1
                    border.color: designTokens.border
                    Label {
                        id: sessionModeNotice
                        objectName: "sessionModeNotice"
                        anchors.centerIn: parent
                        text: p7SqlLabEnabled ? "FICTIONAL · ISOLATED SQLITE LAB"
                              : portfolioShowcase ? "FICTIONAL · " + fleet.totalCount + "-VEHICLE SHOWCASE"
                              : persistentFictionalDemo ? "FICTIONAL · BOOKINGS SAVED"
                              : "FICTIONAL · RESETS ON EXIT"
                        color: ink
                        font.pixelSize: 11
                        font.weight: Font.DemiBold
                        Accessible.name: text
                    }
                }
            }
            Rectangle { Layout.fillWidth: true; height: 1; color: designTokens.border }

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
                        spacing: window.height < 800 ? 10 : 12
                    GridLayout {
                        objectName: "overviewMetricGrid"
                        Layout.fillWidth: true
                        columns: 4
                        rowSpacing: 8
                        columnSpacing: 12
                        OverviewMetricCard {
                            objectName: "overviewTotalCard"
                            metricLabel: "Total vehicles"
                            value: String(fleet.totalCount)
                            note: fleet.carCount + " cars · " + fleet.motorcycleCount + " motorcycles"
                            metricIcon: "car-front"
                            accent: navy
                            compact: window.height < 800
                            Layout.preferredHeight: window.height < 800 ? 81 : 94
                        }
                        OverviewMetricCard {
                            objectName: "overviewAvailableCard"
                            metricLabel: "Available vehicles"
                            value: String(fleet.availableCount)
                            note: fleet.totalCount > 0
                                ? Math.round(100 * fleet.availableCount / fleet.totalCount) +
                                  "% of fleet ready"
                                : "No fleet vehicles"
                            metricIcon: "layers"
                            accent: teal
                            compact: window.height < 800
                            Layout.preferredHeight: window.height < 800 ? 81 : 94
                        }
                        OverviewMetricCard {
                            objectName: "overviewActiveCard"
                            metricLabel: "Active rentals"
                            value: String(rentalsModel.activeCount)
                            note: "Confirmed contracts"
                            metricIcon: "key-round"
                            accent: navy
                            compact: window.height < 800
                            Layout.preferredHeight: window.height < 800 ? 81 : 94
                        }
                        OverviewMetricCard {
                            objectName: "overviewValueCard"
                            metricLabel: "Active booked value"
                            value: "R " + Number(rentalsModel.activeBookedValue).toFixed(2)
                            note: "Contract value, not payments"
                            metricIcon: "database"
                            accent: teal
                            compact: window.height < 800
                            Layout.preferredHeight: window.height < 800 ? 81 : 94
                        }
                    }
                    RowLayout {
                        objectName: "overviewHeroGrid"
                        Layout.fillWidth: true
                        spacing: 12
                    Rectangle {
                        id: editorialOverviewHero
                        objectName: "editorialOverviewHero"
                        property var overduePreview: rentalsModel.oldestOverduePreview
                        readonly property bool needsAttention:
                            rentalsModel.snapshotAvailable &&
                            rentalsModel.oldestOverdueRentalId !== ""
                        // Reference imagery follows verified C++ selection, never a mockup ID.
                        readonly property string featuredVehicleId: needsAttention
                            ? (overduePreview && overduePreview.vehicleId
                               ? overduePreview.vehicleId : "")
                            : (fleet.availableHighlights.length > 0
                               ? fleet.availableHighlights[0].vehicleId : "")
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        Layout.preferredHeight: window.height < 800 ? 198 : 226
                        // Fixed readiness fraction below leaves ~65% for the
                        // source-backed photo/priority hero at both target sizes.
                        color: "#072A28"
                        radius: 16
                        clip: true
                        Accessible.role: Accessible.Grouping
                        Accessible.name: needsAttention
                            ? "Return exception for contract " + rentalsModel.oldestOverdueRentalId
                            : "Overview: no overdue returns"
                        Rectangle {
                            width: 315
                            height: 315
                            radius: 158
                            x: parent.width - 248
                            y: -78
                            color: "transparent"
                            border.color: "#185B4C"
                            border.width: 1
                        }
                        Rectangle {
                            width: 235
                            height: 235
                            radius: 118
                            x: parent.width - 208
                            y: -36
                            color: "transparent"
                            border.color: "#185B4C"
                            border.width: 1
                        }
                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: window.height < 800 ? 20 : 28
                            anchors.rightMargin: window.height < 800 ? 14 : 24
                            anchors.topMargin: window.height < 800 ? 14 : 20
                            anchors.bottomMargin: window.height < 800 ? 12 : 19
                            spacing: 20
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.minimumWidth: 0
                                spacing: 5
                                Label {
                                    text: !rentalsModel.snapshotAvailable
                                        ? "RENTAL SNAPSHOT UNAVAILABLE"
                                        : editorialOverviewHero.needsAttention
                                        ? "RETURN EXCEPTION  ·  OPERATIONAL PRIORITY"
                                        : "FLEET OPERATIONS  ·  LIVE SNAPSHOT"
                                    color: "#88DECE"
                                    font.pixelSize: 11
                                    font.letterSpacing: 1
                                    font.weight: Font.DemiBold
                                }
                                Label {
                                    text: !rentalsModel.snapshotAvailable
                                        ? "Rental records cannot\nbe verified."
                                        : editorialOverviewHero.needsAttention
                                        ? "One rental needs\nattention."
                                        : "Make your next\nmove with confidence."
                                    font.pixelSize: window.height < 800 ? 25 : 31
                                    lineHeight: 0.97
                                    font.weight: Font.DemiBold
                                    color: "#FFFFFF"
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }
                                Label {
                                    text: !rentalsModel.snapshotAvailable
                                        ? "Check the read-only rental source before acting"
                                        : editorialOverviewHero.needsAttention
                                        ? editorialOverviewHero.overduePreview.rentalId +
                                          "  ·  Vehicle " + editorialOverviewHero.overduePreview.vehicleId
                                        : fleet.availableCount + " vehicles ready for the next rental"
                                    color: "#DCEDE8"
                                    font.pixelSize: 12
                                    font.weight: Font.DemiBold
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                Label {
                                    text: editorialOverviewHero.needsAttention
                                        ? "Expected return: " +
                                          editorialOverviewHero.overduePreview.expectedReturnDate
                                        : "Current fictional fleet and confirmed contracts"
                                    color: "#B2D4C9"
                                    font.pixelSize: 11
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                Item { Layout.fillHeight: true }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        Button {
                            id: overviewOverdueAction
                            objectName: "overviewReviewOverdue"
                            text: rentalsModel.oldestOverdueRentalId !== ""
                                ? "Review rental " + rentalsModel.oldestOverdueRentalId
                                : "No overdue returns"
                            Layout.minimumHeight: 44
                            enabled: rentalsModel.oldestOverdueRentalId !== ""
                            visible: enabled
                            hoverEnabled: true
                            background: Rectangle {
                                radius: 8
                                color: !overviewOverdueAction.enabled
                                    ? "#304C5B"
                                    : overviewOverdueAction.hovered
                                      ? "#A6F2E5" : "#80E4D3"
                                border.color: overviewOverdueAction.activeFocus ? "#FFFFFF" : "transparent"
                                border.width: overviewOverdueAction.activeFocus ? 3 : 1
                            }
                            contentItem: Text {
                                text: overviewOverdueAction.text
                                color: overviewOverdueAction.enabled
                                    ? "#123F45" : "#C3D5D9"
                                font.bold: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                            activeFocusOnTab: true
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastOverviewQuickFocus = 2
                            }
                            Keys.onPressed: (event) => window.overviewQuickKey(event,2)
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
                        Button {
                            id: overviewFleetButton
                            objectName: "overviewOpenFleet"
                            text: "Browse fleet"
                            Layout.minimumHeight: 44
                            hoverEnabled: true
                            background: Rectangle {
                                radius: 8
                                color: overviewFleetButton.hovered
                                       ? designTokens.neutralHover : "#FFFFFF"
                                border.color: overviewFleetButton.activeFocus ? navy : designTokens.border
                                border.width: overviewFleetButton.activeFocus ? 3 : 1
                            }
                            contentItem: Text {
                                text: overviewFleetButton.text
                                color: navy
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            activeFocusOnTab: true
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastOverviewQuickFocus = 1
                            }
                            Keys.onPressed: (event) => window.overviewQuickKey(event,1)
                            Accessible.name: "Browse fleet"
                            onClicked: window.workspace = 1
                        }
                    }
                            }
                            Item {
                                id: overviewHeroPhotoBox
                                objectName: "overviewHeroPhotoBox"
                                Layout.preferredWidth: window.height < 800 ? 191 : 267
                                Layout.preferredHeight: window.height < 800 ? 152 : 192
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 13
                                    color: "#123B35"
                                    border.color: "#357867"
                                    clip: true
                                    Image {
                                        id: overviewHeroPhoto
                                        objectName: "overviewHeroPhoto"
                                        anchors.fill: parent
                                        anchors.margins: 3
                                        source: editorialOverviewHero.featuredVehicleId !== "" &&
                                                fleetPhotos.revision >= 0 &&
                                                fleetPhotos.hasPhoto(editorialOverviewHero.featuredVehicleId)
                                            ? "image://fleetphotos/" +
                                              editorialOverviewHero.featuredVehicleId +
                                              "?v=" + fleetPhotos.revision : ""
                                        asynchronous: true
                                        // Editorial photo-led crop is safe because Fleet
                                        // still provides the source and full-image view.
                                        fillMode: Image.PreserveAspectCrop
                                        visible: status === Image.Ready && source !== ""
                                        Accessible.ignored: true
                                    }
                                    VehicleSilhouette {
                                        anchors.centerIn: parent
                                        scale: window.height < 800 ? 0.8 : 1.1
                                        vehicleType: "Car"
                                        visible: !overviewHeroPhoto.visible
                                    }
                                    Label {
                                        visible: overviewHeroPhoto.visible
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        anchors.margins: 8
                                        text: "MODEL REFERENCE"
                                        font.pixelSize: 9
                                        font.weight: Font.DemiBold
                                        color: "#17324D"
                                        padding: 4
                                        background: Rectangle {
                                            color: "#F6F8FA"
                                            radius: 5
                                        }
                                    }
                                }
                            }
                        }
                    }
                        OverviewAvailabilityPanel {
                            objectName: "overviewAvailabilityPanel"
                            // Approved R2 65/35 split, with a safe floor during
                            // smaller manual window resize. No demo values added.
                            Layout.preferredWidth: Math.max(290,
                                (overviewScroll.width - 12) * 0.35)
                            Layout.minimumWidth: 290
                            Layout.maximumWidth: Layout.preferredWidth
                            Layout.preferredHeight: window.height < 800 ? 198 : 226
                            total: fleet.totalCount
                            available: fleet.availableCount
                            rented: fleet.rentedCount
                            carCount: fleet.carCount
                            motorcycleCount: fleet.motorcycleCount
                            dueToday: rentalsModel.dueTodayCount
                            history: rentalsModel.historyCount
                            oldestOverdueId: rentalsModel.oldestOverdueRentalId
                            rentalSnapshotAvailable: rentalsModel.snapshotAvailable
                            bookedValue: rentalsModel.activeBookedValue
                            compact: window.height < 800
                        }
                    }
                    Label {
                        objectName: "overviewDemoDisclosure"
                        text: "Demo-only operations. No payment, deposit or realized revenue reporting."
                        color: ink; wrapMode: Text.WordWrap
                    }
                    RowLayout {
                        id: overviewInsightGrid
                        objectName: "overviewInsightGrid"
                        Layout.fillWidth: true
                        spacing: 12
                    Rectangle {
                        objectName: "overviewRecentPanel"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        Layout.preferredWidth: (overviewScroll.width - 12) * 0.60
                        Layout.maximumWidth: Layout.preferredWidth
                        Layout.preferredHeight: window.height < 800 ? 272 : 294
                        clip: true
                        radius: 12
                        color: "white"
                        border.color: designTokens.border
                        ColumnLayout {
                            id: recentContent
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 7
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 10
                                Label {
                                    text: "Recent contracts"
                                    font.pixelSize: 17
                                    font.weight: Font.DemiBold
                                    color: navy
                                    Layout.fillWidth: true
                                }
                        Button {
                            id: overviewActiveButton
                            objectName: "overviewOpenActive"
                            text: "VIEW ACTIVE  ›"
                            Layout.minimumHeight: 44
                            Layout.preferredWidth: 127
                            hoverEnabled: true
                            background: Rectangle {
                                radius: 8
                                color: overviewActiveButton.hovered ? designTokens.mint : "transparent"
                                border.color: overviewActiveButton.activeFocus ? navy : "transparent"
                                border.width: overviewActiveButton.activeFocus ? 3 : 0
                            }
                            contentItem: Text {
                                text: overviewActiveButton.text
                                color: teal
                                font.pixelSize: 11
                                font.weight: Font.DemiBold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            activeFocusOnTab: true
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastOverviewQuickFocus = 0
                            }
                            Keys.onPressed: (event) => window.overviewQuickKey(event,0)
                            Accessible.name: "Review active rentals"
                            onClicked: {
                                rentalsModel.statusFilter = "Active"
                                window.workspace = 2
                            }
                        }
                            }
                            Label {
                                text: "Ordered by start date · Booked amounts are not payments."
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
                                id: overviewRecentRepeater
                                model: rentalsModel.recentActivities
                                delegate: Button {
                                    required property var modelData
                                    required property int index
                                    objectName: "overviewRecentRow" + index
                                    activeFocusOnTab: true
                                    Keys.onPressed: (event) => window.overviewRecentKey(event,index)
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 0
                                    Layout.minimumHeight: window.height < 800 ? 54 : 62
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: parent.activeFocus ? mint :
                                               parent.hovered ? ice : "#FFFFFF"
                                        border.color: parent.activeFocus ? navy : designTokens.border
                                        border.width: parent.activeFocus ? 2 : 1
                                    }
                                    contentItem: RowLayout {
                                        spacing: 9
                                        Label {
                                            text: modelData.rentalId
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                            color: navy
                                            Layout.preferredWidth: 50
                                        }
                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.minimumWidth: 0
                                            spacing: 3
                                            Label {
                                                objectName: "overviewRecentVehicleName" + index
                                                text: fleet.vehicleNames[modelData.vehicleId] ||
                                                      ("Vehicle " + modelData.vehicleId)
                                                font.pixelSize: 12
                                                font.weight: Font.DemiBold
                                                color: navy
                                                Layout.fillWidth: true
                                                elide: Text.ElideRight
                                            }
                                            Label {
                                                text: "Started " + modelData.startDate
                                                font.pixelSize: 11
                                                color: ink
                                                Layout.fillWidth: true
                                                elide: Text.ElideRight
                                            }
                                        }
                                        Rectangle {
                                            Layout.preferredWidth: 84
                                            Layout.preferredHeight: 25
                                            radius: 13
                                            color: modelData.status === "Active" ? mint :
                                                   modelData.status === "Returned" ? "#EAF1FF" :
                                                   designTokens.quietSurface
                                            Label {
                                                anchors.centerIn: parent
                                                text: modelData.status.toUpperCase()
                                                font.pixelSize: 10
                                                font.weight: Font.DemiBold
                                                color: modelData.status === "Active" ? teal :
                                                       modelData.status === "Returned" ?
                                                       designTokens.rented : ink
                                            }
                                        }
                                        Label {
                                            text: "R " + Number(modelData.total).toFixed(2)
                                            color: navy
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                            Layout.preferredWidth: 108
                                            horizontalAlignment: Text.AlignRight
                                            elide: Text.ElideRight
                                        }
                                    }
                                    text: modelData.rentalId + "  ·  " + modelData.vehicleId +
                                          "  ·  " + modelData.startDate + "  ·  " + modelData.status +
                                          "  ·  R " + Number(modelData.total).toFixed(2)
                                    Accessible.name: "Review rental " + modelData.rentalId +
                                                     ", " + (fleet.vehicleNames[modelData.vehicleId] ||
                                                       ("Vehicle " + modelData.vehicleId)) +
                                                     ", vehicle ID " + modelData.vehicleId +
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
                    Rectangle {
                        objectName: "overviewReadyPanel"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        Layout.preferredWidth: (overviewScroll.width - 12) * 0.40
                        Layout.maximumWidth: Layout.preferredWidth
                        Layout.preferredHeight: window.height < 800 ? 272 : 294
                        radius: 12
                        color: "white"
                        border.color: designTokens.border
                        clip: true
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 5
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    text: "READY FOR THE NEXT RENTAL"
                                    font.pixelSize: 12
                                    font.weight: Font.DemiBold
                                    font.letterSpacing: 0.5
                                    color: navy
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                Label {
                                    text: "SEE FLEET  ›"
                                    color: teal
                                    font.pixelSize: 10
                                    font.weight: Font.DemiBold
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: designTokens.border
                            }
                            Label {
                                text: "No available vehicles in the fictional fleet."
                                visible: fleet.availableHighlights.length === 0
                                color: ink
                                font.pixelSize: 12
                            }
                            Repeater {
                                id: overviewReadyRepeater
                                model: fleet.availableHighlights
                                delegate: EditorialVehiclePreview {
                                    objectName: "overviewReadyVehicle" + index
                                    vehicleId: modelData.vehicleId
                                    vehicleName: modelData.displayName
                                    vehicleType: modelData.vehicleType
                                    dailyRate: modelData.dailyRate
                                    photoRevision: fleetPhotos.revision
                                    hasPhoto: fleetPhotos.revision >= 0 &&
                                              fleetPhotos.hasPhoto(modelData.vehicleId)
                                    compact: window.height < 800
                                    onSelected: (vehicleId) => {
                                        fleet.query = ""
                                        fleet.status = "All"
                                        window.gallery = true
                                        fleet.selectById(vehicleId)
                                        window.workspace = 1
                                    }
                                }
                            }
                            Item { Layout.fillHeight: true }
                            Rectangle { Layout.fillWidth: true; Layout.preferredHeight: 1; color: designTokens.border }
                            Label {
                                text: Math.min(2, fleet.availableCount) + " shown · " +
                                      fleet.availableCount + " available in the fictional fleet"
                                color: ink
                                font.pixelSize: 11
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                        }
                    }
                    }
                    }
                }

                RowLayout {
                    id: fleetWorkspaceRow
                    objectName: "fleetWorkspaceRow"
                    spacing: 14
                    ColumnLayout {
                        Layout.fillWidth: true; Layout.fillHeight: true
                        Layout.minimumWidth: 360
                        spacing: 14
                        ColumnLayout {
                            objectName: "fleetToolbar"
                            Layout.fillWidth: true
                            spacing: window.height < 800 ? 5 : 7
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8
                                ComboBox {
                                    id: fleetStatusCombo
                                    objectName: "fleetStatusCombo"
                                    activeFocusOnTab: true
                                    Layout.preferredWidth: 138
                                    Layout.minimumHeight: 44
                                    background: Rectangle {
                                        radius: 8
                                        color: "#FFFFFF"
                                        border.color: fleetStatusCombo.activeFocus ? navy : designTokens.border
                                        border.width: fleetStatusCombo.activeFocus ? 2 : 1
                                    }
                                    model: ["All", "Available", "Rented"]
                                    // Only LEFT/RIGHT when the native popup is closed:
                                    // Up/Down, Enter and popup selection stay native.
                                    Keys.priority: Keys.BeforeItem
                                    Keys.onPressed: (event) => {
                                        if (event.modifiers !== Qt.NoModifier ||
                                                (fleetStatusCombo.popup && fleetStatusCombo.popup.visible)) return
                                        if (event.key === Qt.Key_Right &&
                                                window.focusEnabled(fleetSortCombo))
                                            event.accepted = true
                                        else if (event.key === Qt.Key_Left && window.focusSidebar())
                                            event.accepted = true
                                    }
                                    Accessible.name: "Filter fleet status"
                                    onActivated: fleet.status = currentText
                                }
                                ComboBox {
                                    id: fleetSortCombo
                                    objectName: "fleetSortCombo"
                                    activeFocusOnTab: true
                                    Layout.preferredWidth: 116
                                    Layout.minimumHeight: 44
                                    background: Rectangle {
                                        radius: 8
                                        color: "#FFFFFF"
                                        border.color: fleetSortCombo.activeFocus ? navy : designTokens.border
                                        border.width: fleetSortCombo.activeFocus ? 2 : 1
                                    }
                                    model: ["Name", "Rate"]
                                    Keys.priority: Keys.BeforeItem
                                    Keys.onPressed: (event) => {
                                        if (event.modifiers !== Qt.NoModifier ||
                                                (fleetSortCombo.popup && fleetSortCombo.popup.visible)) return
                                        if (event.key === Qt.Key_Left &&
                                                window.focusEnabled(fleetStatusCombo))
                                            event.accepted = true
                                        else if (event.key === Qt.Key_Right &&
                                                 window.focusEnabled(search))
                                            event.accepted = true
                                    }
                                    Accessible.name: "Sort fleet"
                                    onActivated: fleet.sortBy = currentText
                                }                                AccessibleTextField {
                                    id: search
                                    fieldPurpose: "Search fleet"
                                    objectName: "fleetSearchField"
                                    Layout.fillWidth: true
                                    Layout.minimumWidth: 150
                                    placeholderText: "Search make, model or vehicle ID"
                                    leftPadding: 36
                                    background: Rectangle {
                                        radius: 9
                                        color: designTokens.surface
                                        border.color: search.activeFocus ? navy : designTokens.border
                                        border.width: search.activeFocus ? 2 : 1
                                        SidebarGlyph {
                                            kind: "search"
                                            glyphColor: designTokens.ink
                                            width: 17; height: 17
                                            x: 11
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }
                                    text: fleet.query
                                    onTextEdited: fleet.query = text
                                    Keys.onPressed: (event) => {
                                        if (event.modifiers !== Qt.NoModifier ||
                                                inputMethodComposing) return
                                        // At the empty-field boundary, Left enters the
                                        // visible Name -> All filter group. Nonempty text
                                        // retains Qt's native caret movement.
                                        if (event.key === Qt.Key_Left && text.length === 0 &&
                                                cursorPosition === 0 && selectedText.length === 0 &&
                                                window.focusEnabled(fleetSortCombo)) {
                                            event.accepted = true
                                        } else if (event.key === Qt.Key_Down &&
                                                window.focusEnabled(window.gallery
                                                  ? fleetGalleryToggle : fleetTableToggle)) {
                                            event.accepted = true
                                        }
                                    }
                                }

                            }
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    objectName: "fleetCollectionHeading"
                                    text: "Vehicle collection"
                                    color: navy
                                    font.pixelSize: window.height < 800 ? 16 : 18
                                    font.weight: Font.DemiBold
                                }
                                Label {
                                    objectName: "fleetShownCount"
                                    text: "(" + (window.gallery ? galleryView.count : tableView.count) + " shown)"
                                    color: ink
                                    font.pixelSize: 12
                                }
                                Item { Layout.fillWidth: true }
                                RowLayout {
                                    // Badges duplicate the authoritative Fleet
                                    // snapshot and must not force gallery overflow.
                                    visible: window.width >= 1650
                                    spacing: 6
                                    Layout.preferredWidth: visible ? implicitWidth : 0
                                    Rectangle {
                                        implicitWidth: 102
                                        implicitHeight: 27
                                        radius: 13
                                        color: designTokens.mint
                                        Label {
                                            anchors.centerIn: parent
                                            text: fleet.availableCount + " AVAILABLE"
                                            color: teal
                                            font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                            Accessible.name: fleet.availableCount + " fleet vehicles available"
                                        }
                                    }
                                    Rectangle {
                                        implicitWidth: 88
                                        implicitHeight: 27
                                        radius: 13
                                        color: "#EAF1FF"
                                        Label {
                                            anchors.centerIn: parent
                                            text: fleet.rentedCount + " RENTED"
                                            color: designTokens.rented
                                            font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                            Accessible.name: fleet.rentedCount + " vehicles rented"
                                        }
                                    }
                                }
                                Button {
                                    id: fleetGalleryToggle
                                    objectName: "fleetGalleryToggle"
                                    text: "Gallery"
                                    Keys.onPressed: (event) => window.fleetViewToggleKey(event,true)
                                    property bool visuallySelected: window.gallery
                                    Layout.minimumHeight: 44
                                    Layout.preferredWidth: 102
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: window.gallery ? mint :
                                               (parent.hovered ? designTokens.neutralHover : "#FFFFFF")
                                        border.width: window.gallery || parent.activeFocus ? 2 : 1
                                        border.color: parent.activeFocus ? navy : window.gallery ? teal : designTokens.border
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: navy
                                        font.bold: window.gallery
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
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
                                    id: fleetTableToggle
                                    objectName: "fleetTableToggle"
                                    text: "Table"
                                    Keys.onPressed: (event) => window.fleetViewToggleKey(event,false)
                                    property bool visuallySelected: !window.gallery
                                    Layout.minimumHeight: 44
                                    Layout.preferredWidth: 94
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: !window.gallery ? mint :
                                               (parent.hovered ? designTokens.neutralHover : "#FFFFFF")
                                        border.width: !window.gallery || parent.activeFocus ? 2 : 1
                                        border.color: parent.activeFocus ? navy : !window.gallery ? teal : designTokens.border
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: navy
                                        font.bold: !window.gallery
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
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
                                    Layout.minimumHeight: 44
                                    Layout.preferredWidth: 124
                                    hoverEnabled: true
                                    enabled: fleetAdmin.canAdd
                                    background: Rectangle {
                                        radius: 8
                                        color: !fleetAddButton.enabled ? designTokens.disabledSurface :
                                               fleetAddButton.hovered || fleetAddButton.down ?
                                               designTokens.neutralHover : designTokens.surface
                                        border.width: fleetAddButton.activeFocus ? 3 : 1
                                        border.color: fleetAddButton.activeFocus ? navy : designTokens.border
                                    }
                                    contentItem: Text {
                                        text: fleetAddButton.text
                                        font.bold: true
                                        color: fleetAddButton.enabled ? navy : designTokens.disabledInk
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
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
                                text: window.photoChangeNotice !== ""
                                      ? window.photoChangeNotice : fleetAdmin.lastMessage
                                visible: text !== ""
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
                                        if (selected === 0) {
                                            Qt.callLater(function() {
                                                if (galleryView.activeFocus &&
                                                    galleryView.currentIndex === 0)
                                                    galleryView.positionViewAtBeginning()
                                            })
                                        }
                                    }
                                }
                                model: fleet.visibleModel
                                // Initial first selection stays visible at the top.
                                // Operators remain free to scroll afterward.
                                Component.onCompleted: Qt.callLater(function() {
                                    if (galleryView.count > 0 && galleryView.currentIndex <= 0)
                                        galleryView.positionViewAtBeginning()
                                })
                                // Keep original keyboard grid semantics:
                                // three columns at 1500, two at 1280. The
                                // former width heuristic is unsuitable after
                                // allocating 40% to the selected inspector.
                                cellWidth: window.width < 1430 ? width / 2 : width / 3
                                // Photo-led cards need enough vertical room to retain
                                // recognisable vehicle framing at compact widths.
                                cellHeight: 272
                                ScrollBar.vertical: ScrollBar {}
                                Column {
                                    objectName: "fleetGalleryEmpty"
                                    anchors.centerIn: parent
                                    width: Math.min(parent.width - 28, 420)
                                    spacing: 12
                                    visible: galleryView.count === 0
                                    Label {
                                        width: parent.width
                                        text: fleet.totalCount === 0 ? "No fleet vehicles yet" :
                                              "No vehicles match this search"
                                        color: navy
                                        font.pixelSize: 19
                                        font.bold: true
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                    }
                                    Label {
                                        width: parent.width
                                        text: fleet.totalCount === 0
                                            ? "Add a fictional vehicle to begin managing the fleet."
                                            : "Try another name or show all availability states."
                                        color: ink
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                    }
                                    Button {
                                        objectName: "fleetClearGalleryFilters"
                                        visible: fleet.totalCount > 0
                                        text: "Clear search and filters"
                                        activeFocusOnTab: true
                                        onClicked: {
                                            fleet.query = ""
                                            fleet.status = "All"
                                            fleetStatusCombo.currentIndex = 0
                                            search.forceActiveFocus(Qt.OtherFocusReason)
                                        }
                                    }
                                }
                                delegate: Button {
                                    id: vehicleCard
                                    required property int index
                                    required property string vehicleId
                                    required property string displayName
                                    required property string vehicleType
                                    required property double dailyRate
                                    required property bool available
                                    width: galleryView.cellWidth - 12
                                    height: 257
                                    activeFocusOnTab: false
                                    Accessible.role: Accessible.ListItem
                                    Accessible.name: displayName + ", " + vehicleId
                                                    + (available ? ", available" : ", rented")
                                    hoverEnabled: true
                                    onClicked: {
                                        galleryView.currentIndex = index
                                        fleet.selectById(vehicleId)
                                        galleryView.forceActiveFocus(Qt.MouseFocusReason)
                                    }
                                    background: FocusFrame {
                                        hovered: vehicleCard.hovered
                                        cornerRadius: 14
                                        objectName: "fleetGalleryFocus"
                                        keyboardFocused: galleryView.activeFocus &&
                                                         galleryView.currentIndex === vehicleCard.index
                                        selected: fleet.selectedId === vehicleCard.vehicleId
                                    }
                                    contentItem: ColumnLayout {
                                        spacing: 5
                                        anchors.margins: 10
                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 154
                                            color: designTokens.quietSurface
                                            radius: 9
                                            clip: true
                                            Image {
                                                id: cardPhoto
                                                objectName: "vehicleCardPhoto"
                                                anchors.fill: parent
                                                // A source is not a decoded image; fallback stays visible until Ready.

                                                readonly property bool photoAvailable:

                                                    fleetPhotos.revision >= 0 &&

                                                    fleetPhotos.hasPhoto(vehicleCard.vehicleId)

                                                source: photoAvailable

                                                    ? "image://fleetphotos/" + vehicleCard.vehicleId

                                                      + "?v=" + fleetPhotos.revision : ""

                                                visible: photoAvailable && status === Image.Ready
                                                // An editorial thumbnail crop only; full-size
                                                // source and licensing remain accessible in Fleet.
                                                fillMode: Image.PreserveAspectCrop
                                                cache: false
                                                Accessible.name: "Illustrative photo for " + vehicleCard.displayName
                                            }
                                            VehicleSilhouette {
                                                id: vehicleArt
                                                objectName: "vehicleCardArt"
                                                anchors.centerIn: parent
                                                // Reserve space for the textual motorcycle identity.
                                                // The vector remains make-neutral, never a stock photo.
                                                anchors.verticalCenterOffset:
                                                    vehicleCard.vehicleType === "Motorcycle" ? -10 : 0
                                                visible: !cardPhoto.visible
                                                vehicleType: vehicleCard.vehicleType
                                                width: 164
                                                height: 74
                                            }
                                            Label {
                                                objectName: "fleetGalleryFallbackModelLabel"
                                                anchors.bottom: parent.bottom
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.bottomMargin: 4
                                                visible: !cardPhoto.visible &&
                                                    vehicleCard.vehicleType === "Motorcycle"
                                                text: vehicleCard.displayName
                                                width: Math.min(implicitWidth, parent.width - 12)
                                                elide: Text.ElideRight
                                                font.pixelSize: 11
                                                font.bold: true
                                                color: navy
                                                padding: 3
                                                z: 1
                                                Accessible.name: "Generic motorcycle illustration for " + text
                                                Accessible.description:
                                                    "Text identifies the fictional fleet model; the drawing is not model-specific"
                                                background: Rectangle {
                                                    color: "#F3FFFFFF"
                                                    radius: 5
                                                }
                                            }
                                            // Every card must state whether its media is a decoded
                                            // reference picture or neutral non-photographic artwork.
                                            // A loading/failed image never masquerades as a photo.
                                            Label {
                                                objectName: "fleetGalleryMediaStatus"
                                                anchors.left: parent.left
                                                anchors.top: parent.top
                                                anchors.margins: 5
                                                padding: 3
                                                font.pixelSize: 10
                                                font.bold: true
                                                text: cardPhoto.visible ? "Reference image" : "Illustration"
                                                color: navy
                                                Accessible.name: text
                                                Accessible.description: cardPhoto.visible
                                                    ? "Illustrative reference only, not the actual rental vehicle"
                                                    : "Generic vehicle artwork; no photograph is displayed"
                                                background: Rectangle {
                                                    color: "#EFFFFFFF"
                                                    radius: 4
                                                }
                                            }
                                        }
                                        Label {
                                            text: vehicleCard.displayName
                                            font.pixelSize: 16
                                            font.weight: Font.DemiBold
                                            color: navy
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        Label {
                                            text: vehicleCard.vehicleId + "  ·  " + vehicleCard.vehicleType
                                            color: ink
                                            font.pixelSize: 11
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }
                                        RowLayout {
                                            Layout.fillWidth: true
                                            spacing: 4
                                            Label {
                                                objectName: "fleetCardRate"
                                                text: "R " + vehicleCard.dailyRate.toFixed(2)
                                                color: navy
                                                font.pixelSize: 16
                                                font.weight: Font.DemiBold
                                            }
                                            Label {
                                                text: "/ day"
                                                color: ink
                                                font.pixelSize: 11
                                            }
                                            Item { Layout.fillWidth: true }
                                            FleetStatusPill {
                                                objectName: "fleetCardStatusPill"
                                                available: vehicleCard.available
                                            }
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
                                // Column headers are part of the real scroll view,
                                // never an invented spreadsheet or separate screen.
                                header: Rectangle {
                                    objectName: "fleetTableHeader"
                                    width: tableView.width
                                    height: 42
                                    radius: 8
                                    color: designTokens.quietSurface
                                    border.color: designTokens.border
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 10
                                        Label {
                                            text: "VEHICLE"
                                            Layout.fillWidth: true
                                            color: ink; font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                        Label {
                                            text: "ID"
                                            Layout.preferredWidth: 70
                                            color: ink; font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                        Label {
                                            text: "TYPE"
                                            visible: tableView.width > 560
                                            Layout.preferredWidth: 76
                                            color: ink; font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                        Label {
                                            text: "RATE / DAY"
                                            Layout.preferredWidth: 102
                                            color: ink; font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                        Label {
                                            text: "STATUS"
                                            Layout.preferredWidth: 80
                                            color: ink; font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                    }
                                }
                                ScrollBar.vertical: ScrollBar {}
                                Column {
                                    objectName: "fleetTableEmpty"
                                    anchors.centerIn: parent
                                    width: Math.min(parent.width - 28, 420)
                                    spacing: 12
                                    visible: tableView.count === 0
                                    Label {
                                        width: parent.width
                                        text: fleet.totalCount === 0 ? "No fleet vehicles yet" :
                                              "No vehicles match this search"
                                        color: navy
                                        font.pixelSize: 19
                                        font.bold: true
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                    }
                                    Label {
                                        width: parent.width
                                        text: fleet.totalCount === 0
                                            ? "Add a fictional vehicle to begin managing the fleet."
                                            : "Try another name or show all availability states."
                                        color: ink
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                    }
                                    Button {
                                        objectName: "fleetClearTableFilters"
                                        visible: fleet.totalCount > 0
                                        text: "Clear search and filters"
                                        activeFocusOnTab: true
                                        onClicked: {
                                            fleet.query = ""
                                            fleet.status = "All"
                                            fleetStatusCombo.currentIndex = 0
                                            search.forceActiveFocus(Qt.OtherFocusReason)
                                        }
                                    }
                                }
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
                                    leftPadding: 12
                                    rightPadding: 12
                                    activeFocusOnTab: false
                                    hoverEnabled: true
                                    onClicked: {
                                        tableView.currentIndex = index
                                        fleet.selectById(vehicleId)
                                        tableView.forceActiveFocus(Qt.MouseFocusReason)
                                    }
                                    Accessible.role: Accessible.ListItem
                                    Accessible.name: "Select " + displayName + ", " + vehicleId
                                    background: FocusFrame {
                                        hovered: vehicleRow.hovered
                                        objectName: "fleetTableFocus"
                                        cornerRadius: 8
                                        keyboardFocused: tableView.activeFocus &&
                                                         tableView.currentIndex === vehicleRow.index
                                        selected: fleet.selectedId === vehicleRow.vehicleId
                                    }
                                    contentItem: RowLayout {
                                        spacing: 10
                                        Label {
                                            text: vehicleRow.displayName
                                            Layout.fillWidth: true
                                            Layout.minimumWidth: 65
                                            color: navy
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                            elide: Text.ElideRight
                                        }
                                        Label {
                                            text: vehicleRow.vehicleId
                                            Layout.preferredWidth: 70
                                            color: ink
                                            font.pixelSize: 12
                                        }
                                        Label {
                                            text: vehicleRow.vehicleType
                                            visible: tableView.width > 560
                                            Layout.preferredWidth: 76
                                            color: ink
                                            font.pixelSize: 12
                                            elide: Text.ElideRight
                                        }
                                        Label {
                                            text: "R " + vehicleRow.dailyRate.toFixed(2)
                                            Layout.preferredWidth: 102
                                            color: navy
                                            font.pixelSize: 12
                                        }
                                        FleetStatusPill {
                                            objectName: "fleetTableStatusPill"
                                            available: vehicleRow.available
                                            Layout.preferredWidth: 80
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: vehicleInspectorPanel
                        objectName: "vehicleInspector"
                        // Real source-backed register (60%) and inspector (40%).
                        // Preserve a safe 320px minimum during manual resizing.
                        Layout.preferredWidth: Math.max(320,
                            (fleetWorkspaceRow.width - fleetWorkspaceRow.spacing) * 0.40)
                        Layout.minimumWidth: 320
                        Layout.maximumWidth: Layout.preferredWidth
                        Layout.fillHeight: true
                        color: designTokens.surface
                        border.color: designTokens.border
                        radius: 14
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: window.height < 800 ? 14 : 18
                            spacing: window.height < 800 ? 8 : 11
                            RowLayout {
                                Label {
                                    text: fleet.selectedId === "" ? "Vehicle details" : "Selected vehicle"
                                    color: navy; font.pixelSize: 17
                                    font.weight: Font.DemiBold
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
                            Rectangle {
                                objectName: "fleetInspectorEmptyArt"
                                visible: fleet.selectedId === ""
                                Layout.fillWidth: true
                                Layout.preferredHeight: 128
                                color: ice
                                radius: 10
                                VehicleSilhouette {
                                    anchors.centerIn: parent
                                    vehicleType: "Car"
                                }
                            }
                            Rectangle {
                                id: fleetInspectorHero
                                objectName: "fleetInspectorSelectedArt"
                                visible: fleet.selectedId !== ""
                                Layout.fillWidth: true
                                // Dark contextual selected-vehicle header remains
                                // compact enough to preserve lifecycle controls.
                                Layout.preferredHeight: window.height < 800 ? 180 : 204
                                Layout.minimumHeight: window.height < 800 ? 170 : 188
                                color: "#072A28"
                                radius: 12
                                clip: true
                                Accessible.role: Accessible.Grouping
                                Accessible.name: "Selected " + fleet.selectedName +
                                                 ", " + fleet.selectedId + ", " +
                                                 (fleet.selectedAvailable ? "available" : "rented")
                                Rectangle {
                                    anchors.fill: parent
                                    anchors.topMargin: 43
                                    color: "#123B35"
                                    radius: 9
                                    z: 0
                                }
                                Column {
                                    id: fleetSelectedHeroCaption
                                    objectName: "fleetSelectedHeroCaption"
                                    x: 14
                                    y: 6
                                    width: parent.width - 28
                                    spacing: 1
                                    z: 4
                                    Label {
                                        objectName: "fleetSelectedHeroName"
                                        width: parent.width
                                        text: fleet.selectedName
                                        color: "#FFFFFF"
                                        font.pixelSize: window.height < 800 ? 15 : 17
                                        font.weight: Font.DemiBold
                                        elide: Text.ElideRight
                                    }
                                    Label {
                                        objectName: "fleetSelectedHeroIdentity"
                                        width: parent.width
                                        text: fleet.selectedId + " · " + fleet.selectedType +
                                              " · " + (fleet.selectedAvailable ? "Available" : "Rented")
                                        color: "#A9E8D5"
                                        font.pixelSize: 11
                                        elide: Text.ElideRight
                                    }
                                }
                                Image {
                                    id: inspectorPhoto
                                    objectName: "fleetInspectorPhoto"
                                    anchors.fill: parent
                                    anchors.topMargin: 43
                                    readonly property bool photoAvailable:

                                        fleetPhotos.revision >= 0 &&

                                        fleetPhotos.hasPhoto(fleet.selectedId)

                                    source: photoAvailable

                                        ? "image://fleetphotos/" + fleet.selectedId

                                          + "?v=" + fleetPhotos.revision : ""

                                    // Failed or loading image cannot conceal the fallback silhouette.

                                    visible: photoAvailable && status === Image.Ready
                                    // The original uncropped photo is still available
                                    // via View full; its recorded credit is retained.
                                    fillMode: Image.PreserveAspectCrop
                                    cache: false
                                    Accessible.name: "Illustrative model photo for " + fleet.selectedName
                                    Accessible.description: "Reference picture only, not the actual rental vehicle"
                                }
                                VehicleSilhouette {
                                    objectName: "fleetInspectorFallbackArt"
                                    anchors.centerIn: parent
                                    anchors.verticalCenterOffset:
                                        fleet.selectedType === "Motorcycle" ? -10 : 0
                                    visible: !inspectorPhoto.visible
                                    vehicleType: fleet.selectedType
                                }
                                Label {
                                    objectName: "fleetInspectorFallbackModelLabel"
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottomMargin: 4
                                    visible: !inspectorPhoto.visible &&
                                        fleet.selectedType === "Motorcycle" &&
                                        fleet.selectedId !== ""
                                    // Bind to the selected C++ model, not a stale ID->name map.
                                    text: fleet.selectedName
                                    width: Math.min(implicitWidth, parent.width - 16)
                                    elide: Text.ElideRight
                                    font.pixelSize: 11
                                    font.bold: true
                                    color: navy
                                    padding: 3
                                    z: 1
                                    Accessible.name: "Generic motorcycle illustration for " + text
                                    Accessible.description:
                                        "Text identifies the fictional fleet model; the drawing is not model-specific"
                                    background: Rectangle {
                                        color: "#F3FFFFFF"
                                        radius: 5
                                    }
                                }
                                // A compact top-left marker never overflows into the
                                // vehicle heading or fights the photo action.
                                Label {
                                    objectName: "fleetPhotoDisclaimer"
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 6
                                    anchors.topMargin: 50
                                    font.pixelSize: 10
                                    text: inspectorPhoto.visible ? "Reference image" : "Illustration"
                                    color: navy
                                    visible: fleet.selectedId !== ""
                                    Accessible.name: text
                                    Accessible.description: inspectorPhoto.visible
                                        ? "Reference picture only, not the actual rental vehicle"
                                        : "Generic vehicle artwork; no photograph is displayed"
                                    background: Rectangle {
                                        color: "#EFFFFFFF"
                                        radius: 4
                                    }
                                }
                                // Optional full-size, uncropped inspection of
                                // already decoded media. Does not modify source
                                // images or imply this is the stock unit.
                                Button {
                                    id: fleetViewFullPhotoButton
                                    objectName: "fleetViewFullPhotoButton"
                                    text: "View full"
                                    // The restore control occupies bottom-right
                                    // when a disposable custom photo is present.
                                    // Keep both read-only/photo actions reachable.
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 6
                                    height: window.height < 800 ? 27 : 30
                                    padding: 4
                                    font.pixelSize: 11
                                    z: 2
                                    visible: inspectorPhoto.visible
                                    activeFocusOnTab: true
                                    Accessible.name: "View uncropped illustrative photo for " +
                                                     fleet.selectedName
                                    onClicked: window.openFullFleetPhoto()
                                }
                                // Overlay, not an extra layout row. Preserve
                                // the Book action's room at compact desktop sizes.
                                Button {
                                    id: fleetReplacePhotoButton
                                    objectName: "fleetReplacePhotoButton"
                                    text: window.height < 800 ? "Change" : "Change photo"
                                    font.pixelSize: 11
                                    padding: 4
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.margins: 6
                                    anchors.topMargin: 50
                                    z: 2
                                    visible: !persistentFictionalDemo
                                    activeFocusOnTab: true
                                    height: window.height < 800 ? 27 : 32
                                    Accessible.name: "Choose a new local illustration for selected fictional vehicle"
                                    onClicked: {
                                        window.photoChangeTargetId = fleet.selectedId
                                        window.photoChangeNotice = ""
                                        selectedFleetPhotoDialog.open()
                                    }
                                }
                                Button {
                                    id: fleetRestoreDefaultPhotoButton
                                    objectName: "fleetRestoreDefaultPhotoButton"
                                    text: window.height < 800 ? "Reset" : "Restore default"
                                    font.pixelSize: 11
                                    padding: 4
                                    anchors.bottom: parent.bottom
                                    anchors.right: parent.right
                                    anchors.margins: 6
                                    z: 2
                                    height: window.height < 800 ? 27 : 32
                                    visible: !persistentFictionalDemo && fleet.selectedId !== "" &&
                                             fleetPhotos.revision >= 0 &&
                                             fleetPhotos.hasCustomPhoto(fleet.selectedId)
                                    activeFocusOnTab: true
                                    Accessible.name: "Restore the original fictional vehicle image"
                                    onClicked: {
                                        window.photoResetTargetId = fleet.selectedId
                                        window.photoChangeNotice = ""
                                        fleetRestorePhotoDialog.open()
                                    }
                                }
                            }
                            // Exact image attribution belongs to white factual
                            // details, separate from the selected photograph.
                            Label {
                                objectName: "fleetInspectorPhotoCredit"
                                visible: fleet.selectedId !== "" && inspectorPhoto.visible
                                readonly property var record:
                                    fleetPhotos.revision >= 0 && fleet.selectedId !== ""
                                        ? fleetPhotos.attributionFor(fleet.selectedId) : ({})
                                text: record.kind === "custom"
                                    ? "Custom demo image · unverified"
                                    : record.creator
                                      ? record.creator + " · " + record.licence
                                      : "Source details unavailable"
                                color: designTokens.secondaryText
                                font.pixelSize: 10
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                Accessible.name: text
                                Accessible.description: "Image credits follow the exact selected source"
                            }
                            // Selection context is in the dark photographic header.
                            // The neutral empty selection remains explicit and honest.
                            Label {
                                visible: fleet.selectedId === ""
                                text: "Select a vehicle"
                                color: navy
                                font.pixelSize: window.height < 800 ? 18 : 20
                                font.weight: Font.DemiBold
                                Layout.fillWidth: true
                            }
                            Label {
                                visible: fleet.selectedId === ""
                                text: "Choose a Gallery card or Table row to see verified vehicle details."
                                color: ink
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                            }
                            Label {
                                objectName: "fleetInspectorDetailsHeading"
                                visible: fleet.selectedId !== ""
                                text: "VEHICLE DETAILS"
                                color: designTokens.secondaryText
                                font.pixelSize: 11
                                font.weight: Font.DemiBold
                                font.letterSpacing: 0.6
                                Layout.fillWidth: true
                            }
                            // Actual selected C++ identity, never invented specs.
                            RowLayout {
                                objectName: "fleetInspectorIdentityFacts"
                                visible: fleet.selectedId !== "" && window.height >= 800
                                Layout.fillWidth: true
                                spacing: 8
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 1
                                    Label { text: "VEHICLE ID"; color: designTokens.secondaryText; font.pixelSize: 10 }
                                    Label {
                                        objectName: "fleetInspectorIdentityId"
                                        text: fleet.selectedId
                                        color: navy; font.pixelSize: 13; font.weight: Font.DemiBold
                                    }
                                }
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 1
                                    Label { text: "CATEGORY"; color: designTokens.secondaryText; font.pixelSize: 10 }
                                    Label {
                                        objectName: "fleetInspectorIdentityType"
                                        text: fleet.selectedType
                                        color: navy; font.pixelSize: 13; font.weight: Font.DemiBold
                                    }
                                }
                            }
                            Rectangle { Layout.fillWidth: true; height: 1; color: designTokens.border }
                            Label {
                                text: fleet.selectedId === "" ? "" : fleet.selectedDetails
                                color: ink; wrapMode: Text.WordWrap
                            }
                            Rectangle {
                                objectName: "fleetInspectorRateBand"
                                visible: fleet.selectedId !== ""
                                Layout.fillWidth: true
                                Layout.preferredHeight: window.height < 800 ? 60 : 66
                                radius: 10
                                color: fleet.selectedAvailable ? designTokens.mint :
                                       designTokens.quietSurface
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 11
                                    spacing: 7
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 1
                                        Label {
                                            text: "DAILY RENTAL RATE"
                                            color: ink
                                            font.pixelSize: 10
                                            font.weight: Font.DemiBold
                                        }
                                        Label {
                                            objectName: "fleetInspectorRateValue"
                                            text: "R " + fleet.selectedRate
                                            color: navy
                                            font.pixelSize: 19
                                            font.weight: Font.DemiBold
                                            Accessible.name: "Daily rental rate " + text +
                                                ". No payment has been collected."
                                        }
                                    }
                                    FleetStatusPill {
                                        objectName: "fleetInspectorStatusPill"
                                        available: fleet.selectedAvailable
                                    }
                                }
                            }
                            Item { Layout.fillHeight: true }
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
                                Layout.minimumHeight: 44
                                text: "Book selected vehicle"
                                hoverEnabled: true
                                background: Rectangle {
                                    radius: 8
                                    color: !bookSelectedFleetButton.enabled ? "#E6EAEE" :
                                           bookSelectedFleetButton.down ? "#0C625C" :
                                           bookSelectedFleetButton.hovered ? "#0C625C" : teal
                                    border.width: bookSelectedFleetButton.activeFocus ? 3 : 0
                                    border.color: navy
                                }
                                contentItem: Text {
                                    text: bookSelectedFleetButton.text
                                    font.bold: true
                                    color: bookSelectedFleetButton.enabled ? "#FFFFFF" : ink
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
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
                            DangerButton {
                                id: removeSelectedFleetButton
                                objectName: "fleetRemoveSelectedButton"
                                Layout.fillWidth: true
                                Layout.minimumHeight: 44
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
                        fleetController: fleet
                        focusReturn: removeSelectedFleetButton
                        fallbackFocusReturn: fleetAddButton
                    }
                }

                // UX-S1: page-level scroll keeps lower rental controls reachable.
                Flickable {
                    id: rentalsPageScroll
                    objectName: "rentalsPageScroll"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentWidth: width
                    contentHeight: rentalPageContent.implicitHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    ScrollBar.vertical: ScrollBar {
                        objectName: "rentalsPageScrollBar"
                        policy: ScrollBar.AlwaysOn
                    }
                    ColumnLayout {
                        id: rentalPageContent
                        width: Math.max(0, rentalsPageScroll.width - 18)
                        spacing: window.height < 800 ? 8 : 10
                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            objectName: "rentalSectionHeading"
                            text: "Contract management"
                            color: navy; font.pixelSize: 20; font.weight: Font.DemiBold
                        }
                        Item { Layout.fillWidth: true }
                        Label {
                            text: rentalsModel.snapshotAvailable ? "C++ SNAPSHOT · FICTIONAL" : "RECORDS UNAVAILABLE"
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
                            Layout.minimumHeight: 44
                            hoverEnabled: true
                            background: Rectangle {
                                radius: 8
                                color: newBookingButton.hovered || newBookingButton.down
                                    ? "#0C625C" : teal
                                border.width: newBookingButton.activeFocus ? 3 : 0
                                border.color: navy
                            }
                            contentItem: Text {
                                text: newBookingButton.text
                                font.bold: true
                                color: "#FFFFFF"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            activeFocusOnTab: true
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalActionFocus = 0
                            }
                            Keys.onPressed: (event) => window.rentalActionKey(event,0)
                            Accessible.name: "Create a new fictional rental"
                            onClicked: window.beginNewRental(false)
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
                        parent: Overlay.overlay
                        anchors.centerIn: Overlay.overlay
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
                                if (window.bookingFromSidebar && sidebarNewRentalButton.visible &&
                                        sidebarNewRentalButton.enabled)
                                    sidebarNewRentalButton.forceActiveFocus(Qt.TabFocusReason)
                                else if (newBookingButton.visible && newBookingButton.enabled)
                                    newBookingButton.forceActiveFocus(Qt.TabFocusReason)
                                window.bookingFromSidebar = false
                            })
                        }
                        contentItem: ColumnLayout {
                            spacing: 10
                            Label {
                                text: "VEHICLE  ·  CUSTOMER  ·  REVIEW"
                                color: teal
                                font.pixelSize: 12
                                font.bold: true
                                Accessible.name: "Vehicle, Customer, Review"
                            }
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
                                Layout.minimumHeight: 44
                                hoverEnabled: true
                                background: Rectangle {
                                    radius: 8
                                    color: bookingPreviewButton.hovered ? mint : "#FFFFFF"
                                    border.color: bookingPreviewButton.activeFocus ? navy : teal
                                    border.width: bookingPreviewButton.activeFocus ? 3 : 1
                                }
                                contentItem: Text {
                                    text: bookingPreviewButton.text
                                    color: teal
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                activeFocusOnTab: true
                                Accessible.name: bookingActions.needsFreshQuote
                                    ? "Refresh outdated rental quote" : "Preview current C++ rental quote"
                                Accessible.description: bookingActions.needsFreshQuote
                                    ? "The previous quote cannot be confirmed. Review current availability and price."
                                    : "Review a current domain quote before enabling Confirm booking"
                                onClicked: bookingActions.preview(bookingVehicleId.text, bookingDays.value)
                            }
                            Rectangle {
                                objectName: "bookingQuotePanel"
                                Layout.fillWidth: true
                                Layout.preferredHeight: Math.max(76, quotePanelContent.implicitHeight + 24)
                                color: mint
                                border.color: designTokens.border
                                radius: 10
                                ColumnLayout {
                                    id: quotePanelContent
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 6
                                    Label {
                                        text: "LIVE QUOTE · NOT A PAYMENT"
                                        color: teal
                                        font.bold: true
                                        font.pixelSize: 12
                                    }
                                    DomainMessage {
                                        objectName: "bookingQuoteSummary"
                                        emphasized: bookingActions.canConfirm
                                        text: bookingActions.quoteSummary !== ""
                                            ? bookingActions.quoteSummary
                                            : "Enter a vehicle and duration, then preview the current quote."
                                    }
                                }
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
                                    id: bookingCancelButton
                                    objectName: "bookingCancelButton"
                                    text: "Cancel"
                                    Layout.minimumHeight: 44
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: bookingCancelButton.hovered ? ice : "#FFFFFF"
                                        border.color: bookingCancelButton.activeFocus ? navy : designTokens.border
                                        border.width: bookingCancelButton.activeFocus ? 3 : 1
                                    }
                                    contentItem: Text {
                                        text: bookingCancelButton.text
                                        color: navy
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    activeFocusOnTab: true
                                    onClicked: bookingDialog.close()
                                }
                                Item { Layout.fillWidth: true }
                                Button {
                                    id: bookingConfirmButton
                                    objectName: "bookingConfirmButton"
                                    text: "Confirm booking"
                                    Layout.minimumHeight: 44
                                    enabled: bookingActions.canConfirm
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: !bookingConfirmButton.enabled ? "#E6EAEE" :
                                               bookingConfirmButton.hovered || bookingConfirmButton.down
                                               ? "#0C625C" : teal
                                        border.color: navy
                                        border.width: bookingConfirmButton.activeFocus ? 3 : 0
                                    }
                                    contentItem: Text {
                                        text: bookingConfirmButton.text
                                        font.bold: true
                                        color: bookingConfirmButton.enabled ? "#FFFFFF" : ink
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
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

                    ConfirmActionDialog {
                        id: returnConfirmation
                        objectName: "rentalReturnDialog"
                        // Never let a live selection swap the target reviewed
                        // in this modal. The C++ controller repeats the ID guard.
                        property string targetId: ""
                        property bool reviewInvalidated: false
                        property string reviewInvalidationReason: ""
                        parent: Overlay.overlay
                        anchors.centerIn: Overlay.overlay
                        title: "Confirm rental return"
                        question: "Mark " + returnConfirmation.targetId + " as returned today?" +
                                  (returnConfirmation.reviewInvalidated
                                      ? "\n" + returnConfirmation.reviewInvalidationReason +
                                        " Close and reopen to review this return."
                                      : "")
                        acceptText: "Confirm return"
                        acceptName: "rentalReturnConfirm"
                        cancelName: "rentalReturnCancel"
                        canAccept: returnConfirmation.targetId !== "" &&
                                   !returnConfirmation.reviewInvalidated &&
                                   returnConfirmation.targetId === rentalsModel.selectedRentalId &&
                                   rentalActions.canReturnSelected
                        restoreFocusTo: returnSelectedButton
                        fallbackFocusTo: rentalList
                        onConfirmed: rentalActions.returnSelectedFor(returnConfirmation.targetId)
                    }
                    ConfirmActionDialog {
                        id: archiveConfirmation
                        objectName: "rentalArchiveDialog"
                        property string targetId: ""
                        property bool reviewInvalidated: false
                        property string reviewInvalidationReason: ""
                        parent: Overlay.overlay
                        anchors.centerIn: Overlay.overlay
                        title: "Archive returned rental"
                        question: "Move " + archiveConfirmation.targetId +
                                  " to archived history? The record will not be deleted." +
                                  (archiveConfirmation.reviewInvalidated
                                      ? "\n" + archiveConfirmation.reviewInvalidationReason +
                                        " Close and reopen to review this archive."
                                      : "")
                        acceptText: "Confirm archive"
                        acceptName: "rentalArchiveConfirm"
                        cancelName: "rentalArchiveCancel"
                        canAccept: archiveConfirmation.targetId !== "" &&
                                   !archiveConfirmation.reviewInvalidated &&
                                   archiveConfirmation.targetId === rentalsModel.selectedRentalId &&
                                   archiveActions.canArchiveSelected
                        restoreFocusTo: archiveActionButton
                        fallbackFocusTo: rentalList
                        onConfirmed: archiveActions.archiveSelectedFor(archiveConfirmation.targetId)
                    }
                    P6ArchivedDeleteDialog {
                        id: archivedDeleteDialog
                        objectName: "rentalDeleteArchivedDialog"
                        parent: Overlay.overlay
                        anchors.centerIn: Overlay.overlay
                        command: archivedDelete
                        rentals: rentalsModel
                        focusReturn: deleteArchivedButton
                        fallbackFocusReturn: rentalList
                    }
                    DomainMessage {
                        objectName: "rentalDeleteMessage"
                            visible: text !== ""
                        text: archivedDelete.lastMessage
                    }
                    DomainMessage {
                        objectName: "rentalArchiveMessage"
                            visible: text !== ""
                        text: archiveActions.lastArchiveMessage
                    }
                    // Quality-first compact desktop layout: filters and
                    // rental ID lookup have separate, predictable rows.
                    // This is presentation only. C++ still owns all filters,
                    // record selection, persisted operations and validation.
                    RowLayout {
                        objectName: "rentalEditorialSummary"
                        Layout.fillWidth: true
                        spacing: 10
                        Repeater {
                            model: [
                                { label: "ACTIVE CONTRACTS", count: rentalsModel.activeCount, tint: teal },
                                { label: "OVERDUE RETURNS", count: rentalsModel.overdueCount, tint: designTokens.warningInk },
                                { label: "RETURNED / ARCHIVED", count: rentalsModel.historyCount, tint: navy }
                            ]
                            delegate: Rectangle {
                                required property var modelData
                                Layout.fillWidth: true
                                Layout.preferredHeight: 62
                                radius: 12
                                color: designTokens.surface
                                border.color: designTokens.border
                                Accessible.role: Accessible.StaticText
                                Accessible.name: modelData.label + ": " + modelData.count
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 10
                                    Label {
                                        text: rentalsModel.snapshotAvailable
                                            ? String(modelData.count).padStart(2, "0") : "—"
                                        color: modelData.tint
                                        font.pixelSize: 25
                                        font.weight: Font.DemiBold
                                    }
                                    Label {
                                        text: modelData.label
                                        color: navy
                                        font.pixelSize: 11
                                        font.weight: Font.DemiBold
                                        Layout.fillWidth: true
                                        wrapMode: Text.WordWrap
                                    }
                                }
                            }
                        }
                    }
                    RowLayout {
                        objectName: "rentalContractWorkspace"
                        Layout.fillWidth: true
                        spacing: 12
                        ColumnLayout {
                            objectName: "rentalRegisterColumn"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            spacing: window.height < 800 ? 8 : 10
                    Rectangle {
                        objectName: "rentalFilterPanel"
                        Layout.fillWidth: true
                        implicitHeight: rentalToolbar.implicitHeight + 22
                        radius: 12
                        color: designTokens.surface
                        border.color: designTokens.border
                        border.width: 1
                    ColumnLayout {
                        id: rentalToolbar
                        objectName: "rentalToolbar"
                        anchors.fill: parent
                        anchors.margins: 11
                        spacing: 5
                        Label {
                            text: "CONTRACT FILTERS · VIEWS DO NOT EDIT RECORDS"
                            color: navy
                            font.pixelSize: 12
                            font.weight: Font.DemiBold
                        }
                        RowLayout {
                            objectName: "rentalStatusRow"
                            Layout.fillWidth: true
                            spacing: 8
                            Label {
                                text: "Status"
                                color: ink
                                font.pixelSize: 12
                                Accessible.name: "Filter rentals by status"
                            }
                            Repeater {
                                // History remains a combined view; Returned
                                // and Archived have distinct C++ lifecycle filters.
                                model: ["All", "Active", "Returned", "Archived", "History"]
                                id: rentalStatusRepeater
                                delegate: Button {
                                    required property string modelData
                                    required property int index
                                    objectName: "rentalFilter" + modelData
                                    text: modelData
                                    activeFocusOnTab: true
                                    hoverEnabled: true
                                    Keys.onPressed: (event) => window.rentalStatusKey(event,index)
                                    onActiveFocusChanged: {
                                        if (activeFocus) window.lastRentalStatusFocus = index
                                    }
                                    Layout.minimumHeight: 44
                                    Accessible.role: Accessible.RadioButton
                                    Accessible.name: modelData + " rentals"
                                    Accessible.checkable: true
                                    Accessible.checked: rentalsModel.statusFilter === modelData
                                    Accessible.description: "Filter fictional rentals by lifecycle status"
                                    onClicked: rentalsModel.statusFilter = modelData
                                    background: Rectangle {
                                        radius: 8
                                        color: rentalsModel.statusFilter === parent.modelData ? mint :
                                               parent.hovered ? designTokens.quietSurface : designTokens.ice
                                        border.width: parent.activeFocus ? designTokens.focusWidth :
                                                      (rentalsModel.statusFilter === parent.modelData ? 1 : 0)
                                        border.color: parent.activeFocus ? navy : teal
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: rentalsModel.statusFilter === parent.modelData ? teal : navy
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.bold: rentalsModel.statusFilter === parent.modelData
                                    }
                                }
                            }
                            Item { Layout.fillWidth: true }
                            Label {
                                objectName: "rentalVisibleCount"
                                text: rentalsModel.count + (rentalsModel.count === 1
                                      ? " matching contract" : " matching contracts")
                                color: ink
                                font.pixelSize: 12
                                Accessible.name: text
                            }
                        }
                        RowLayout {
                            objectName: "rentalDueRow"
                            Layout.fillWidth: true
                            spacing: 8
                            Label {
                                text: "Return timing"
                                color: ink
                                font.pixelSize: 12
                                Accessible.name: "Filter active rentals by due date"
                            }
                            Repeater {
                                // Derived from typed C++ due state; selection only.
                                model: [
                                    { value: "Overdue", label: "Overdue" },
                                    { value: "DueToday", label: "Due today" }
                                ]
                                id: rentalDueRepeater
                                delegate: Button {
                                    required property var modelData
                                    required property int index
                                    objectName: "rentalFilter" + modelData.value
                                    text: modelData.label
                                    activeFocusOnTab: true
                                    hoverEnabled: true
                                    Keys.onPressed: (event) => window.rentalDueKey(event,index)
                                    onActiveFocusChanged: {
                                        if (activeFocus) window.lastRentalDueFocus = index
                                    }
                                    Layout.minimumHeight: 44
                                    Accessible.role: Accessible.RadioButton
                                    Accessible.name: modelData.label + " rentals"
                                    Accessible.checkable: true
                                    Accessible.checked: rentalsModel.statusFilter === modelData.value
                                    Accessible.description: "Filter active fictional rentals by return timing, without changing records"
                                    onClicked: rentalsModel.statusFilter = modelData.value
                                    background: Rectangle {
                                        radius: 8
                                        color: rentalsModel.statusFilter === parent.modelData.value
                                               ? designTokens.warningSurface :
                                               parent.hovered ? designTokens.quietSurface : designTokens.ice
                                        border.width: parent.activeFocus ? designTokens.focusWidth :
                                                      (rentalsModel.statusFilter === parent.modelData.value ? 1 : 0)
                                        border.color: parent.activeFocus ? navy : designTokens.warningInk
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: rentalsModel.statusFilter === parent.modelData.value ? designTokens.warningInk : navy
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.bold: rentalsModel.statusFilter === parent.modelData.value
                                    }
                                }
                            }
                            Item { Layout.fillWidth: true }
                            Label {
                                text: "Active contracts only · read-only"
                                color: ink
                                font.pixelSize: 12
                                Accessible.name: text
                            }
                        }
                        ColumnLayout {
                            objectName: "rentalLookupRow"
                            Layout.fillWidth: true
                            spacing: 4
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 10
                                Label {
                                    text: "Find rental"
                                    color: ink
                                    font.pixelSize: 12
                                    Accessible.name: "Find rental by rental or vehicle ID"
                                }
                                AccessibleTextField {
                                    id: rentalLookupField
                                    objectName: "rentalLookupField"
                                    fieldPurpose: "Find rental by rental or vehicle ID"
                                    placeholderText: "Rental or vehicle ID"
                                    Layout.preferredWidth: 220
                                    Layout.minimumWidth: 150
                                    onTextEdited: window.rentalLookupFeedback = ""
                                    onAccepted: window.findRentalById()
                                    Keys.onPressed: (event) => {
                                        if (event.modifiers !== Qt.NoModifier ||
                                                inputMethodComposing) return
                                        if (event.key === Qt.Key_Up &&
                                                window.focusRentalDue())
                                            event.accepted = true
                                        else if (event.key === Qt.Key_Down &&
                                                 window.enterRentalRecords())
                                            event.accepted = true
                                    }
                                }
                                Button {
                                    id: rentalLookupButton
                                    objectName: "rentalLookupButton"
                                    text: "Find rental"
                                    activeFocusOnTab: true
                                    Layout.minimumHeight: 44
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: parent.hovered ? designTokens.neutralHover : ice
                                        border.width: parent.activeFocus
                                                      ? designTokens.focusWidth : 1
                                        border.color: parent.activeFocus ? navy : designTokens.border
                                    }
                                    Keys.onPressed: (event) => {
                                        if (window.activateFocusedButton(event, rentalLookupButton))
                                            return
                                        if (event.modifiers !== Qt.NoModifier) return
                                        if (event.key === Qt.Key_Left) {
                                            rentalLookupField.forceActiveFocus(Qt.TabFocusReason)
                                            event.accepted = true
                                        } else if (event.key === Qt.Key_Up &&
                                                   window.focusRentalDue())
                                            event.accepted = true
                                        else if (event.key === Qt.Key_Down &&
                                                 window.enterRentalRecords())
                                            event.accepted = true
                                    }
                                    Accessible.name: "Find rental by rental or vehicle ID"
                                    onClicked: window.findRentalById()
                                }
                                Item { Layout.fillWidth: true }
                            }
                            Label {
                                objectName: "rentalLookupFeedback"
                                Layout.fillWidth: true
                                text: window.rentalLookupFeedback
                                visible: text !== ""
                                color: ink
                                font.pixelSize: 12
                                wrapMode: Text.WordWrap
                                Accessible.name: text
                            }
                        }
                    }
                    }
                    Rectangle {
                        id: rentalRecordsPanel
                        objectName: "rentalRecordsPanel"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        Layout.preferredHeight: window.height < 800 ? 420 : 445
                        color: designTokens.surface
                        radius: 12
                        border.color: designTokens.border
                        border.width: 1
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    text: "CONTRACT REGISTER"
                                    color: navy
                                    font.pixelSize: 12
                                    font.weight: Font.DemiBold
                                }
                                Item { Layout.fillWidth: true }
                                Label {
                                    objectName: "rentalRegisterCount"
                                    text: rentalsModel.count + (rentalsModel.count === 1 ?
                                          " record shown" : " records shown")
                                    color: ink
                                    font.pixelSize: 12
                                    Accessible.name: text
                                }
                            }
                            RowLayout {
                                objectName: "rentalTableHeader"
                                Layout.fillWidth: true
                                Layout.preferredHeight: 28
                                spacing: 16
                                Label { text: "RENTAL ID"; color: ink; font.pixelSize: 11; Layout.preferredWidth: 74 }
                                Label { text: "VEHICLE"; color: ink; font.pixelSize: 11; Layout.preferredWidth: 94 }
                                Label { text: "STATUS"; color: ink; font.pixelSize: 11; Layout.preferredWidth: 100 }
                                Label { text: "RETURN TIMING"; color: ink; font.pixelSize: 11; Layout.fillWidth: true }
                                Label { text: "BOOKED VALUE"; color: ink; font.pixelSize: 11 }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: designTokens.border
                            }
                            Item {
                                // The actual list retains its size and keyboard behavior.
                                // A zero-result filter must never look like an app failure.
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            ListView {
                                id: rentalList
                                objectName: "rentalList"
                                anchors.fill: parent
                                clip: true
                                spacing: 7
                                activeFocusOnTab: true
                                keyNavigationEnabled: false
                                // With a short list the wheel scrolls the page;
                                // larger sets keep their own virtualized list scroll.
                                interactive: rentalsModel.count > 4
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
                                    hoverEnabled: true
                                    // Include all the visible record context and selection
                                    // in one spoken name; never expose customer PII here.
                                    Accessible.name: (rentalRow.rentalId === rentalsModel.selectedRentalId
                                                      ? "Selected rental " : "Rental ") +
                                                     rentalId + ", " + status +
                                                     ", vehicle " + vehicleId +
                                                     ", " + window.dueStateLabel(dueState) +
                                                     ", total R " + Number(total).toFixed(2)
                                    onClicked: rentalsModel.selectById(rentalId)
                                    background: FocusFrame {
                                        hovered: rentalRow.hovered
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
                                             objectName: "rentalStatusPill"
                                             statusValue: rentalRow.status
                                             Layout.preferredWidth: 100
                                        }
                                        Label {
                                            objectName: "rentalDueLabel" + rentalRow.rentalId
                                            text: window.dueStateLabel(rentalRow.dueState)
                                            color: rentalRow.dueState === "Overdue" ||
                                                   rentalRow.dueState === "DueToday"
                                                ? designTokens.warningInk : ink
                                            font.bold: rentalRow.dueState === "Overdue"
                                            Layout.fillWidth: true
                                            Accessible.name: "Return due: " + text
                                        }
                                        Label {
                                            text: "R " + Number(rentalRow.total).toFixed(2)
                                            color: navy; font.bold: true
                                        }
                                    }
                                }
                            }

                                ColumnLayout {
                                    objectName: "rentalEmptyState"
                                    anchors.centerIn: parent
                                    width: Math.min(parent.width - 32, 420)
                                    spacing: 10
                                    visible: rentalsModel.count === 0
                                    Label {
                                        objectName: "rentalEmptyMessage"
                                        Layout.fillWidth: true
                                        horizontalAlignment: Text.AlignHCenter
                                        wrapMode: Text.WordWrap
                                        color: ink
                                        font.pixelSize: 14
                                        text: rentalsModel.statusFilter === "All" ?
                                              "No fictional rentals yet. Use New rental to create the first contract." :
                                              rentalsModel.statusFilter === "Overdue" ?
                                               "No overdue active rentals. Show all rentals to see other contracts." :
                                               rentalsModel.statusFilter === "DueToday" ?
                                               "No active rentals due today. Show all rentals to see other contracts." :
                                               "No " + rentalsModel.statusFilter + " rental records in this view. Show all rentals to see other contracts."
                                        Accessible.name: text
                                    }
                                    Button {
                                        id: rentalEmptyReset
                                        objectName: "rentalEmptyReset"
                                        Keys.onPressed: (event) => {
                                            if (window.activateFocusedButton(event,rentalEmptyReset))
                                                return
                                            if (event.modifiers === Qt.NoModifier &&
                                                    event.key === Qt.Key_Up &&
                                                    window.focusEnabled(rentalLookupField))
                                                event.accepted = true
                                        }
                                        Layout.alignment: Qt.AlignHCenter
                                        text: "Show all rentals"
                                        visible: rentalsModel.statusFilter !== "All"
                                        enabled: rentalsModel.count === 0
                                        activeFocusOnTab: true
                                        Layout.minimumHeight: 44
                                        Accessible.name: "Show all rental records"
                                        Accessible.description: "Clear only the current rental list filter. No records are changed."
                                        onClicked: rentalsModel.statusFilter = "All"
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
                                    Layout.minimumHeight: 44
                                    activeFocusOnTab: true
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: !showContractDetailsButton.enabled
                                            ? designTokens.disabledSurface
                                            : showContractDetailsButton.hovered
                                              ? designTokens.neutralHover : designTokens.ice
                                        border.width: showContractDetailsButton.activeFocus
                                                      ? designTokens.focusWidth : 1
                                        border.color: showContractDetailsButton.activeFocus
                                                      ? navy : designTokens.border
                                    }
                                    contentItem: Text {
                                        text: showContractDetailsButton.text
                                        color: showContractDetailsButton.enabled
                                            ? navy : designTokens.disabledInk
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    enabled: rentalsModel.selectedContract.rentalId !== undefined
                                    Accessible.name: "View selected rental contract details"
                                    Accessible.description: "Read-only dates, status, duration and booked amount. No customer contact."
                                    onClicked: window.openSelectedRentalDetails(false)
                                    Keys.onPressed: (event) => {
                                        if (window.activateFocusedButton(event,showContractDetailsButton))
                                            return
                                        if (event.modifiers === Qt.NoModifier &&
                                                event.key === Qt.Key_Up &&
                                                window.enterRentalRecords())
                                            event.accepted = true
                                    }
                                }
                            }
                        }
                    }
                        }
                    Rectangle {
                        objectName: "rentalActionPanel"
                        // Content-sized inspector stays top-aligned beside filters.
                        // Stretching it to the register column used to distribute
                        // spare vertical space and clip destructive actions at 720px.
                        Layout.alignment: Qt.AlignTop
                        Layout.fillHeight: false
                        Layout.preferredHeight: rentalActionContent.implicitHeight + 28
                        Layout.minimumWidth: 305
                        Layout.preferredWidth: window.width < 1400 ? 305 : 328
                        Layout.maximumWidth: Layout.preferredWidth
                        implicitHeight: rentalActionContent.implicitHeight + 28
                        radius: 12
                        color: designTokens.surface
                        border.color: designTokens.border
                        border.width: 1
                        ColumnLayout {
                            id: rentalActionContent
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 5
                            Label {
                                text: "SELECTED CONTRACT"
                                color: ink
                                font.pixelSize: 11
                                font.weight: Font.DemiBold
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                Label {
                                    objectName: "rentalInspectorId"
                                    text: rentalsModel.selectedContract.rentalId || "Select a contract"
                                    color: navy
                                    font.pixelSize: 23
                                    font.weight: Font.DemiBold
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }
                                RentalStatusLabel {
                                    objectName: "rentalInspectorStatus"
                                    visible: rentalsModel.selectedContract.status !== undefined
                                    statusValue: rentalsModel.selectedContract.status || ""
                                }
                            }
                            Label {
                                objectName: "rentalInspectorVehicle"
                                text: rentalsModel.selectedContract.vehicleId !== undefined
                                    ? ((fleet.vehicleNames[rentalsModel.selectedContract.vehicleId] ||
                                       ("Vehicle " + rentalsModel.selectedContract.vehicleId)) +
                                       " · " + rentalsModel.selectedContract.vehicleId)
                                    : "Select a contract from the register"
                                color: navy
                                font.pixelSize: 12
                                font.weight: Font.DemiBold
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            Label {
                                objectName: "rentalInspectorDate"
                                text: rentalsModel.selectedContract.expectedReturnDate !== undefined
                                    ? "Expected return · " +
                                      rentalsModel.selectedContract.expectedReturnDate
                                    : "No rental selected"
                                color: ink
                                font.pixelSize: 11
                                Layout.fillWidth: true
                            }
                            Label {
                                objectName: "rentalInspectorValue"
                                text: rentalsModel.selectedContract.total !== undefined
                                    ? "Booked value · R " +
                                      Number(rentalsModel.selectedContract.total).toFixed(2)
                                    : "Contract values are not payments"
                                color: navy
                                font.pixelSize: 12
                                font.weight: Font.DemiBold
                                Layout.fillWidth: true
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: designTokens.border
                            }
                            Label {
                                text: "CONTRACT ACTIONS"
                                color: navy
                                font.pixelSize: 12
                                font.weight: Font.DemiBold
                            }
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5
                        Button {
                            id: returnSelectedButton
                            objectName: "rentalReturnButton"
                            text: "Return selected rental"
                            activeFocusOnTab: true
                            hoverEnabled: true
                            Layout.minimumHeight: 44
                            Layout.fillWidth: true
                            background: Rectangle {
                                radius: 8
                                color: !returnSelectedButton.enabled ? designTokens.disabledSurface :
                                       returnSelectedButton.hovered ? mint : designTokens.surface
                                border.color: returnSelectedButton.activeFocus ? navy : teal
                                border.width: returnSelectedButton.activeFocus ? designTokens.focusWidth : 1
                            }
                            contentItem: Text {
                                text: returnSelectedButton.text
                                color: returnSelectedButton.enabled ? teal : designTokens.disabledInk
                                font.weight: Font.DemiBold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalActionFocus = 1
                            }
                            Keys.onPressed: (event) => window.rentalActionKey(event,1)
                            enabled: rentalActions.canReturnSelected
                            Accessible.name: "Return the selected active rental"
                            onClicked: {
                                returnConfirmation.targetId = rentalsModel.selectedRentalId
                                returnConfirmation.reviewInvalidated = false
                                returnConfirmation.reviewInvalidationReason = ""
                                returnConfirmation.open()
                            }
                        }
                        Button {
                            id: archiveActionButton
                            objectName: "rentalArchiveButton"
                            text: "Archive returned"
                            activeFocusOnTab: true
                            hoverEnabled: true
                            Layout.minimumHeight: 44
                            Layout.fillWidth: true
                            background: Rectangle {
                                radius: 8
                                color: !archiveActionButton.enabled ? designTokens.disabledSurface :
                                       archiveActionButton.hovered ? designTokens.neutralHover : designTokens.surface
                                border.color: archiveActionButton.activeFocus ? navy : designTokens.border
                                border.width: archiveActionButton.activeFocus ? designTokens.focusWidth : 1
                            }
                            contentItem: Text {
                                text: archiveActionButton.text
                                color: archiveActionButton.enabled ? navy : designTokens.disabledInk
                                font.weight: Font.DemiBold
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalActionFocus = 2
                            }
                            Keys.onPressed: (event) => window.rentalActionKey(event,2)
                            enabled: archiveActions.canArchiveSelected
                            Accessible.name: "Archive selected returned rental"
                            onClicked: {
                                archiveConfirmation.targetId = rentalsModel.selectedRentalId
                                archiveConfirmation.reviewInvalidated = false
                                archiveConfirmation.reviewInvalidationReason = ""
                                archiveConfirmation.open()
                            }
                        }
                        DangerButton {
                            id: deleteArchivedButton
                            objectName: "rentalDeleteArchivedButton"
                            text: "Delete archived"
                            activeFocusOnTab: true
                            Layout.fillWidth: true
                            Layout.minimumHeight: 44
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalActionFocus = 3
                            }
                            Keys.onPressed: (event) => window.rentalActionKey(event,3)
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
                            visible: text !== ""
                            text: rentalActions.lastReturnMessage
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        AccessibleTextField {
                            id: returnLookupField
                            objectName: "returnLookupField"
                            fieldPurpose: "Find active rental to return by rental ID or vehicle ID"
                            placeholderText: "Rental ID or vehicle ID"
                            Layout.fillWidth: true
                            Layout.minimumWidth: 100
                            onTextEdited: {
                                // Editing a new target must never leave the
                                // previous contract eligible for confirmation.
                                rentalsModel.clearSelection()
                                window.returnLookupFeedback = ""
                            }
                            onAccepted: window.findActiveReturn()
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalReturnFocus = 0
                            }
                            Keys.onPressed: (event) => {
                                if (event.modifiers !== Qt.NoModifier ||
                                        inputMethodComposing) return
                                if (event.key === Qt.Key_Up &&
                                        window.focusRentalAction())
                                    event.accepted = true
                                else if (event.key === Qt.Key_Down &&
                                         window.focusRentalStatus())
                                    event.accepted = true
                            }
                        }
                        Button {
                            id: returnLookupButton
                            objectName: "returnLookupButton"
                            text: "Locate return"
                            activeFocusOnTab: true
                            onActiveFocusChanged: {
                                if (activeFocus) window.lastRentalReturnFocus = 1
                            }
                            Keys.onPressed: (event) => {
                                if (window.activateFocusedButton(event,returnLookupButton))
                                    return
                                if (event.modifiers !== Qt.NoModifier) return
                                if (event.key === Qt.Key_Left)
                                    window.focusEnabled(returnLookupField)
                                else if (event.key === Qt.Key_Up)
                                    window.focusRentalAction()
                                else if (event.key === Qt.Key_Down)
                                    window.focusRentalStatus()
                                else return
                                event.accepted = true
                            }
                            Layout.minimumHeight: 44
                            Layout.preferredWidth: 108
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
                        }
                    }
                    }
                    Dialog {
                        id: contractDetailsDialog
                        objectName: "rentalContractDetailsDialog"
                        // Keep the semantic title for assistive technology, but suppress
                        // Qt's default small title bar. The approved contract card already
                        // provides its own prominent RENTAL CONTRACT heading.
                        title: "Rental contract"
                        header: Item {
                            objectName: "rentalContractSuppressedDefaultHeader"
                            implicitHeight: 0
                            visible: false
                        }
                        width: Math.min(600, window.width - 48)
                        height: Math.min(650, window.height - 64)
                        parent: Overlay.overlay
                        anchors.centerIn: Overlay.overlay
                        modal: true
                        focus: true
                        padding: window.width < 1100 ? 16 : 24
                        closePolicy: Popup.CloseOnEscape
                        standardButtons: Dialog.NoButton
                        onOpened: Qt.callLater(function() {
                            if (contractDetailsDialog.visible)
                                detailsCloseButton.forceActiveFocus(Qt.TabFocusReason)
                        })
                        onClosed: {
                            window.contractDetailsOpenedId = ""
                            Qt.callLater(function() {
                                if (window.workspace !== 2) return
                                if (window.contractDetailsFromRow && rentalList.visible)
                                    rentalList.forceActiveFocus(Qt.TabFocusReason)
                                else if (showContractDetailsButton.visible &&
                                         showContractDetailsButton.enabled)
                                    showContractDetailsButton.forceActiveFocus(Qt.TabFocusReason)
                                else if (rentalList.visible)
                                    rentalList.forceActiveFocus(Qt.TabFocusReason)
                            })
                        }
                        background: Rectangle {
                            color: designTokens.surface
                            radius: 14
                            border.width: 1
                            border.color: designTokens.border
                        }
                        contentItem: ColumnLayout {
                            spacing: 12
                            RowLayout {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 92
                                spacing: 14
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Label {
                                        text: "RENTAL CONTRACT"
                                        color: ink
                                        font.pixelSize: 12
                                        font.bold: true
                                        Accessible.name: text
                                    }
                                    Label {
                                        objectName: "rentalDetailIdentity"
                                        text: rentalsModel.selectedContract.rentalId || "No contract"
                                        color: navy
                                        font.pixelSize: 26
                                        font.bold: true
                                        Accessible.name: "Rental ID: " + text
                                    }
                                    Label {
                                        objectName: "rentalDetailVehicle"
                                        text: "Vehicle " +
                                              (rentalsModel.selectedContract.vehicleId || "not selected")
                                        color: ink
                                        font.pixelSize: 14
                                        Accessible.name: text
                                    }
                                }
                                ColumnLayout {
                                    spacing: 5
                                    Layout.alignment: Qt.AlignTop
                                    Rectangle {
                                        Layout.alignment: Qt.AlignRight
                                        implicitWidth: Math.max(92, rentalDetailStatus.implicitWidth + 22)
                                        implicitHeight: 30
                                        radius: 15
                                        color: rentalsModel.selectedContract.status === "Active" ? mint : ice
                                        Label {
                                            id: rentalDetailStatus
                                            objectName: "rentalDetailStatus"
                                            anchors.centerIn: parent
                                            text: rentalsModel.selectedContract.status || "Unavailable"
                                            color: text === "Active" ? teal : navy
                                            font.pixelSize: 12
                                            font.bold: true
                                            Accessible.name: "Rental status: " + text
                                        }
                                    }
                                    Rectangle {
                                        objectName: "rentalDetailDueChip"
                                        visible: rentalsModel.selectedContract.dueState === "Overdue" ||
                                                 rentalsModel.selectedContract.dueState === "DueToday"
                                        Layout.alignment: Qt.AlignRight
                                        implicitWidth: Math.max(92, dueChipText.implicitWidth + 22)
                                        implicitHeight: 28
                                        radius: 14
                                        color: designTokens.warningSurface
                                        Label {
                                            id: dueChipText
                                            anchors.centerIn: parent
                                            text: window.dueStateLabel(rentalsModel.selectedContract.dueState)
                                            color: designTokens.warningInk
                                            font.bold: true
                                            font.pixelSize: 12
                                            Accessible.name: "Return timing: " + text
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 1
                                color: designTokens.border
                            }
                            GridLayout {
                                objectName: "rentalDetailGrid"
                                Layout.fillWidth: true
                                columns: width < 460 ? 1 : 2
                                columnSpacing: 12
                                rowSpacing: 12
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 76
                                    color: ice
                                    radius: 12
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Label { text: "Rental duration"; color: ink; font.pixelSize: 12 }
                                        Label {
                                            objectName: "rentalDetailDuration"
                                            text: String(rentalsModel.selectedContract.days || 0) + " days"
                                            color: navy; font.bold: true; font.pixelSize: 16
                                            Accessible.name: "Rental duration: " + text
                                        }
                                    }
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 76
                                    color: ice
                                    radius: 12
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Label { text: "Daily rate"; color: ink; font.pixelSize: 12 }
                                        Label {
                                            objectName: "rentalDetailRate"
                                            text: window.rentalMoney(rentalsModel.selectedContract.dailyRate)
                                            color: navy; font.bold: true; font.pixelSize: 16
                                            Accessible.name: "Daily rate: " + text
                                        }
                                    }
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 76
                                    color: ice
                                    radius: 12
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Label { text: "Start date"; color: ink; font.pixelSize: 12 }
                                        Label {
                                            objectName: "rentalDetailStart"
                                            text: rentalsModel.selectedContract.startDate || "Not recorded"
                                            color: navy; font.pixelSize: 16
                                            Accessible.name: "Start date: " + text
                                        }
                                    }
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 76
                                    color: ice
                                    radius: 12
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Label { text: "Expected return"; color: ink; font.pixelSize: 12 }
                                        Label {
                                            objectName: "rentalDetailExpected"
                                            text: rentalsModel.selectedContract.expectedReturnDate || "Not recorded"
                                            color: navy; font.pixelSize: 16
                                            Accessible.name: "Expected return: " + text
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 68
                                color: ice
                                radius: 12
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 3
                                    Label { text: "Actual return"; color: ink; font.pixelSize: 12 }
                                    Label {
                                        objectName: "rentalDetailActual"
                                        text: rentalsModel.selectedContract.actualReturnDate || "Not returned"
                                        color: navy; font.pixelSize: 16
                                        Accessible.name: "Actual return: " + text
                                    }
                                }
                            }
                            Rectangle {
                                objectName: "rentalDetailTotalPanel"
                                Layout.fillWidth: true
                                Layout.preferredHeight: 110
                                color: mint
                                radius: 12
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 14
                                    spacing: 3
                                    Label {
                                        text: "BOOKED CONTRACT TOTAL"
                                        color: navy
                                        font.pixelSize: 12
                                        font.bold: true
                                    }
                                    Label {
                                        objectName: "rentalDetailTotal"
                                        text: window.rentalMoney(rentalsModel.selectedContract.total)
                                        color: navy
                                        font.pixelSize: 26
                                        font.bold: true
                                        Accessible.name: "Booked contract total: " + text
                                    }
                                    Label {
                                        text: "Booked value, not a payment receipt"
                                        color: ink
                                        font.pixelSize: 12
                                        Accessible.name: text
                                    }
                                }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12
                                Label {
                                    Layout.fillWidth: true
                                    text: "Read-only verified rental summary"
                                    color: ink
                                    font.pixelSize: 12
                                    wrapMode: Text.WordWrap
                                    Accessible.name: text
                                }
                                Button {
                                    id: detailsCloseButton
                                    objectName: "rentalDetailsClose"
                                    text: "Close"
                                    Layout.minimumHeight: 44
                                    activeFocusOnTab: true
                                    hoverEnabled: true
                                    background: Rectangle {
                                        radius: 8
                                        color: detailsCloseButton.hovered
                                               ? designTokens.neutralHover : ice
                                        border.width: detailsCloseButton.activeFocus ? 3 : 1
                                        border.color: detailsCloseButton.activeFocus ? navy :
                                                      designTokens.border
                                    }
                                    Accessible.name: "Close rental contract details"
                                    onClicked: contractDetailsDialog.close()
                                }
                            }
                        }
                    }
                    }
                }
                // Slot 4 loads ONLY for the explicit fictional-only SQL
                // mode. The three legacy workspaces retain their exact data
                // services, operational commands and default indices.
                Loader {
                    id: p7SqlLabLoader
                    objectName: "p7SqlLabLoader"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    active: p7SqlLabEnabled
                    sourceComponent: Component { P7FictionalSqlLab {} }
                }
            }
        }
    }
}
