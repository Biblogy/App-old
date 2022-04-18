//
//  File.swift
//  
//
//  Created by Veit Progl on 27.02.22.
//

import Foundation

public struct CalendarDate: Identifiable, Equatable {
    public var date: Date
    public var id = UUID().uuidString
    public var isToday: Bool
    public var active: Bool
    
    public init(date: Date, today: Bool) {
        self.date = date
        self.isToday = today
        self.active = false
    }
}
