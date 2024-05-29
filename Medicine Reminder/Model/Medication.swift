//
//  Medication.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation

enum IconString: String {
    case capsule = "pills"
    case inject = "drugs"
    case tablet = "medicine"
}

struct Medication {
    var id: UUID
    var name: String
    var dosage: String
    var frequency: String
    var time: Date
    var refillDate: Date?
    var reminderTime: String
    var icons: IconString
}
