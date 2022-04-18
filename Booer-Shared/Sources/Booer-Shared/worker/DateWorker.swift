//
//  File.swift
//  
//
//  Created by Veit Progl on 09.03.22.
//

import Foundation

public protocol DateWorkerProtocol {
    func removeTime(from: Date)  -> Date
    func getDay(from: Date) -> Int
}

class DateWorker: DateWorkerProtocol {
    func getDay(from: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: from)
        return components.day!
    }
    
    func getMonth(from: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: from)
        return components.month!
    }
    
    func removeTime(from date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return Calendar.current.date(from: components)!
    }
}
