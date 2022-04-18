//
//  File.swift
//  
//
//  Created by Veit Progl on 03.06.21.
//

import Foundation
import SwiftUI
import Combine

struct TimeCounter: View {
    @State private var startDate = Date()
    @State private var time = 0
    @State private var timeS = 0
    @State private var timeM = 0
    @State private var timeH = 0
    @State private var running = false
    var body: some View {
        VStack {
            if running {
                Text(startDate, style: .timer)
                Button(action: {
                    self.time = Int(Date() - startDate)
                    (timeH,timeM,timeS) = secondsToHoursMinutesSeconds(seconds: self.time)
                    self.running = false
                }, label: {
                    Text("stop")
                })
            } else {
                Text("\(timeH):\(timeM):\(timeS)")
                Button(action: {
                    self.startDate = Date()
                    self.running = true
                }, label: {
                    Text("start")
                })
            }
        }
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
