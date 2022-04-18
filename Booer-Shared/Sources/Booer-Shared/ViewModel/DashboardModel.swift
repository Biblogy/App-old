//
//  File.swift
//  
//
//  Created by Veit Progl on 30.05.21.
//

import Foundation
import CoreData
import SwiftUI
import Combine
import Relay

protocol DashboardModelProtocol {
    func calcStreak() -> Int
}

public class DashboardModel: DashboardModelProtocol, ObservableObject {
    @Injected var dateWorker: DateWorkerProtocol

    var items: FetchedResults<ReadProgress>
    public init(items: FetchedResults<ReadProgress>) {
        self.items = items
    }
    
    public var streak = 0
    public func calcStreak() -> Int {
        var index = 0
        streak = 0
        let dates = Array(Set(items.map({dateWorker.removeTime(from: $0.date!)})))
        
        for item in dates {
            let itemDate = dateWorker.getDay(from: item)
            if itemDate == dateWorker.getDay(from: Date()) {
                streak += 1
                index += 1
                let nextDay = Calendar.current.date(byAdding: .day, value: -index, to: Date())
                while itemDate == dateWorker.getDay(from: nextDay!) {
                    streak += 1
                    index += 1
                }
            } else {
                streak = 0
            }
        }
        return streak
    }
}
