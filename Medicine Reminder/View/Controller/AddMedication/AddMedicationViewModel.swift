//
//  AddMedicationViewModel.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation
import UserNotifications

import Foundation
import UserNotifications

class AddMedicationViewModel {
    private let repository: MedicationRepository
    
    // Properties to store medication details
    var name: String = ""
    var dosage: String = ""
    var frequency: String = ""
    var time: Date = Date()
    var refillDate: Date?
    var reminderTime: String = ""
    var icons: IconString = .capsule
    var reminderInterval: String? = "daily"
    var reminderType: String? = "one-time"
    // Default to test in 10 seconds
    var refillInterval: Int16 = 10
    
    // Initializer
    init(repository: MedicationRepository) {
        self.repository = repository
    }
    
    // To save medication details and schedule notifications
    func saveMedication() {
        repository.addMedication(
            name: name,
            dosage: dosage,
            frequency: frequency,
            time: time,
            refillDate: refillDate,
            reminderTime: reminderTime,
            icons: icons.rawValue,
            reminderInterval: reminderInterval ?? "",
            reminderType: reminderType ?? "", 
            refillInterval: refillInterval
        )
        scheduleNotifications(
            for: name,
            dosage: dosage,
            time: time,
            refillInterval: refillInterval
        )
    }
    
    // To schedule all necessary notifications
    private func scheduleNotifications(
        for name: String,
        dosage: String,
        time: Date,
        refillInterval: Int16
    ) {
        // Schedule the medication reminder notification
        scheduleMedicationReminder(
            for: name,
            dosage: dosage,
            time: time,
            reminderInterval: reminderInterval,
            reminderType: reminderType
        )
        // Schedule a test refill notification to trigger in 10 seconds
        scheduleTestRefillNotification(for: name, dosage: dosage, secondsFromNow: TimeInterval(refillInterval))
        // Schedule the missed dose notification
        scheduleMissedDoseNotification(for: name, dosage: dosage, time: time)
    }
    
    // To schedule a medication reminder notification
    private func scheduleMedicationReminder(
        for name: String,
        dosage: String,
        time: Date,
        reminderInterval: String?,
        reminderType: String?
    ) {
        let content = UNMutableNotificationContent()
        content.title = "Medicine Reminder"
        content.body = "It's time to take your \(name) (\(dosage))"
        
        let trigger: UNNotificationTrigger
        
        switch reminderInterval {
        case "daily":
            let triggerDate = Calendar.current.dateComponents(
                [.hour, .minute],
                from: time
            )
            trigger = UNCalendarNotificationTrigger(
                dateMatching: triggerDate,
                repeats: true
            )
        case "weekly":
            var triggerDate = Calendar.current.dateComponents(
                [.hour, .minute, .weekday],
                from: time
            )
            triggerDate.weekday = Calendar.current.component(
                .weekday,
                from: time
            )
            trigger = UNCalendarNotificationTrigger(
                dateMatching: triggerDate,
                repeats: true
            )
        case "monthly":
            var triggerDate = Calendar.current.dateComponents(
                [.hour, .minute, .day],
                from: time
            )
            triggerDate.day = Calendar.current.component(
                .day,
                from: time
            )
            trigger = UNCalendarNotificationTrigger(
                dateMatching: triggerDate,
                repeats: true
            )
        default:
            trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: time.timeIntervalSinceNow,
                repeats: false
            )
        }
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(
            request,
            withCompletionHandler: nil
        )
    }

    // To schedule a refill notification
    func scheduleTestRefillNotification(
        for name: String,
        dosage: String, 
        secondsFromNow: TimeInterval
    ) {
        let content = UNMutableNotificationContent()
        content.title = "Test Refill Reminder"
        content.body = "Time to refill your \(name)"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: secondsFromNow,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "\(name)_refill_test",
            content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(
            request, withCompletionHandler: { error in
            if let error = error {
                print("Error scheduling test refill notification: \(error)")
            } else {
                print("Test refill notification scheduled successfully!")
            }
        })
    }

    
    // To schedule a missed dose notification
    private func scheduleMissedDoseNotification(
        for name: String,
        dosage: String,
        time: Date
    ) {
        let content = UNMutableNotificationContent()
        content.title = "Missed Dose"
        content.body = "You missed your \(name) (\(dosage)) dose"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 60 * 60,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(
            request,
            withCompletionHandler: nil
        )
    }
}

