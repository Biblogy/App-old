//
//  File.swift
//  
//
//  Created by Veit Progl on 17.03.22.
//

import Foundation

public struct CalendarIntervall: Identifiable, Equatable {
    public var interval: DateInterval
    public let id: String
    
    public init(interval: DateInterval){
        self.interval = interval
        self.id = UUID().uuidString
    }
    
    public init(interval: DateInterval, id: String){
        self.interval = interval
        self.id = id
    }
}
