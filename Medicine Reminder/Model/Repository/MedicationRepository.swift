//
//  MedicationRepository.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation
import CoreData
import UIKit

protocol MedicationRepository {
    func fetchMedications() -> [MedicationEntity]
    func addMedication(
        name: String,
        dosage: String,
        frequency: String,
        time: Date,
        refillDate: Date?,
        reminderTime: String,
        icons: String,
        reminderInterval: String,
        reminderType: String,
        refillInterval: Int16
    )
    func updateMedication(_ medication: MedicationEntity)
    func deleteMedication(by id: UUID)
}

class MedicationRepositoryImpl: MedicationRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    func fetchMedications() -> [MedicationEntity] {
        let request: NSFetchRequest<MedicationEntity> = MedicationEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func addMedication(
        name: String,
        dosage: String,
        frequency: String,
        time: Date,
        refillDate: Date?,
        reminderTime: String,
        icons: String,
        reminderInterval: String,
        reminderType: String,
        refillInterval: Int16
    ) {
        let medication = MedicationEntity(context: context)
        medication.id = UUID()
        medication.name = name
        medication.dose = dosage
        medication.frequency = frequency
        medication.time = time
        medication.refillDate = refillDate
        medication.reminderTime = reminderTime
        medication.icons = icons
        medication.reminderInterval = reminderInterval
        medication.reminderType = reminderType
        medication.refillInterval = refillInterval
        
        do {
            try context.save()
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func updateMedication(_ medication: MedicationEntity) {
        do {
            try context.save()
        } catch {
            print("Update failed: \(error)")
        }
    }
    
    func deleteMedication(by id: UUID) {
        let fetchRequest: NSFetchRequest<MedicationEntity> = MedicationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let result = try context.fetch(fetchRequest).first {
                context.delete(result)
                try context.save()
            }
        } catch {
            print("Delete failed: \(error)")
        }
    }
}
