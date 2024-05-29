//
//  MedicationEntity+CoreDataProperties.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//
//

import Foundation
import CoreData


extension MedicationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicationEntity> {
        return NSFetchRequest<MedicationEntity>(entityName: "MedicationEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dose: String?
    @NSManaged public var frequency: String?
    @NSManaged public var time: Date?
    @NSManaged public var refillDate: Date?
    @NSManaged public var reminderTime: String?
    @NSManaged public var icons: String?
    @NSManaged public var reminderInterval: String?
    @NSManaged public var reminderType: String?
    @NSManaged public var refillInterval: Int16

}

extension MedicationEntity : Identifiable {

}
