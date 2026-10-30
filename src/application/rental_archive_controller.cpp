#include "src/application/rental_archive_controller.h"
#include "src/application/rental_list_model.h"
#include "rentalsystem.h"

RentalArchiveService::RentalArchiveService(
        RentalSystem &system, const RentalReadService &reads)
    : m_system(system), m_reads(reads) {}

RentalArchiveResult RentalArchiveService::archiveById(const QString &id) {
    const auto item=m_reads.recordById(id);
    if (!item)
        return {RentalArchiveError::MissingRental, {}};
    if (item->status==RentalRecordStatus::Archived)
        return {RentalArchiveError::AlreadyArchived, {}};
    if (item->status!=RentalRecordStatus::Returned)
        return {RentalArchiveError::NotReturned, {}};
    // The domain is the only writer and rolls status back if QSaveFile fails.
    if (!m_system.archiveRental(item->rentalId))
        return {RentalArchiveError::CommitFailed, {}};
    return {RentalArchiveError::None, item->rentalId};
}

RentalArchiveController::RentalArchiveController(
        RentalSystem &system, const RentalReadService &reads,
        RentalListModel &rentals, QObject *parent)
    : QObject(parent), m_service(system,reads), m_reads(reads),
      m_rentals(rentals) {
    connect(&m_rentals,&RentalListModel::selectionChanged,
            this,&RentalArchiveController::stateChanged);
    connect(&m_rentals,&QAbstractItemModel::modelReset,
            this,&RentalArchiveController::stateChanged);
}

bool RentalArchiveController::canArchiveSelected() const {
    const QString id=m_rentals.selectedRentalId();
    if (id.isEmpty() || m_rentals.selectedRow()<0)
        return false;
    const auto item=m_reads.recordById(id);
    return item && item->status==RentalRecordStatus::Returned;
}

bool RentalArchiveController::archiveSelected() {
    const QString id=m_rentals.selectedRentalId();
    const auto result=(id.isEmpty() || m_rentals.selectedRow()<0)
            ? RentalArchiveResult{RentalArchiveError::MissingRental,{}}
            : m_service.archiveById(id);
    if (!result.ok()) {
        switch(result.error) {
        case RentalArchiveError::MissingRental:
            m_message=QStringLiteral("Select a visible returned rental.");
            break;
        case RentalArchiveError::NotReturned:
            m_message=QStringLiteral("Only returned rentals may be archived.");
            break;
        case RentalArchiveError::AlreadyArchived:
            m_message=QStringLiteral("This rental is already archived.");
            break;
        case RentalArchiveError::CommitFailed:
            m_message=QStringLiteral("Archive not saved. No change confirmed.");
            break;
        case RentalArchiveError::None:
            m_message=QStringLiteral("Archive not completed.");
            break;
        }
        emit stateChanged();
        emit archiveRejected(result.error);
        return false;
    }
    // Archive does not change vehicle occupancy: only rental model refreshes.
    m_rentals.refresh();
    m_message=QStringLiteral("Rental %1 archived.").arg(result.rentalId);
    emit stateChanged();
    emit archiveSucceeded(result.rentalId);
    return true;
}
