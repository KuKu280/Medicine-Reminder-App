//
//  MedicationListViewModel.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation
import UserNotifications

import Foundation

// ViewModel for handling the list of medications
class MedicationListViewModel {
    // To hold the medication repository instance
    private let repository: MedicationRepository
    
    // To fetch the list of medications from the repository
    var medications: [MedicationEntity] {
        repository.fetchMedications()
    }
    
    // To inject the repository dependency
    init(repository: MedicationRepository) {
        self.repository = repository
    }
    
    // To update an existing medication
    func updateMedication(_ medication: MedicationEntity) {
        repository.updateMedication(medication)
    }
    
    // To delete a medication by its unique identifier (UUID)
    func deleteMedication(by id: UUID) {
        repository.deleteMedication(by: id)
    }
}

