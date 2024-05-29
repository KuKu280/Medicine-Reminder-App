//
//  NSObject.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
