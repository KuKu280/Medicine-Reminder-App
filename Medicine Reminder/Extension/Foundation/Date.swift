//
//  Date.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation

extension Date {
    
    func toString() -> String {
        DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
    }
}
