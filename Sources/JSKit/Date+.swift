//
//  Date+.swift
//  JSKit
//
//  Created by leejaesung on 3/27/25.
//

import Foundation

extension Date {

    public var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour < 12
    }

    public var isEvening: Bool {
        return !isMorning
    }

}
