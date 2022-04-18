//
//  File.swift
//  
//
//  Created by Veit Progl on 16.02.22.
//

import Foundation
import Booer_Shared
import Relay

protocol CalenderInteractorProtocol {
}

class CalendarInteractor: CalenderInteractorProtocol, ObservableObject {
    @Published public var state: CalenderStateProtocol = CalenderState()
    let calendar = Calendar.current

    @Injected var dateWorker: DateWorkerProtocol
    
    func loadData() {
        state.weekDays = self.weekdays()
        state.month = self.getMonth()
        state.monthList = self.getMonths()
    }
    
    private func createCalenderDate(day forDate: Int, dayOfWeek: Int, dateInWeek: Date) -> CalendarDate {
        let day = calendar.date(byAdding: .day, value: forDate - dayOfWeek, to: dateInWeek)!
        let today = getToday(for: day)
        return CalendarDate(date: day, today: today)
    }
    
    func weekdays(from dateInWeek: Date = Date()) -> [CalendarDate] {
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound).map {
            createCalenderDate(day: $0, dayOfWeek: dayOfWeek, dateInWeek: dateInWeek)
        }
        
        return days
    }
    
    func getMonths() -> [CalendarIntervall] {
        var monthCounter = 1
        var monthsList: [CalendarIntervall] = []
        while monthCounter <= 12 {
            monthsList.append(CalendarIntervall(interval: calendar.dateInterval(of: .month, for: createFirstDay(month: monthCounter))!))
            monthCounter = monthCounter + 1
        }
        return monthsList
    }
    
    func getMonth(for date: Date = Date()) -> String {
        let month = calendar.component(.month, from: date)
        let monthString = calendar.monthSymbols[month - 1]
        return monthString
    }
    
    func getToday(for checkDate: Date) -> Bool {
        let check = dateWorker.removeTime(from: checkDate)
        let today = dateWorker.removeTime(from: Date())
        if today == check {
            return true
        }
        return false
    }
    
    func onDayTap(on date: CalendarDate) {
//        let currentActive = self.state.weekDays.firstIndex(where: { $0.active == true })
//        if currentActive != nil {
//            self.state.weekDays[currentActive!].active = false
//        }
//
//        let newActive = self.state.weekDays.firstIndex(where: { $0.id == date.id })
//        if newActive != nil && newActive != currentActive {
//            self.state.weekDays[newActive!].active = true
//        }
        self.setActive(date: date.date)
    }
    
    func getDay(from date: Date) -> Int {
        return dateWorker.getDay(from: date)
    }
    
    private func createFirstDay(month: Int) -> Date {
        let year = calendar.component(.year, from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "\(year)/\(month)/01 13:42")
        
        let date = Date(timeInterval: 0, since: someDateTime!)
        return date
    }
    
    func getCurrentMonthID() -> String? {
        for month in state.monthList {
            if month.interval.contains(Date()) {
                return month.id
            }
        }
        return nil
    }
    
    func checkIfDateIsToday(date: Date) -> Bool {
        if dateWorker.removeTime(from: date) == dateWorker.removeTime(from: Date()) {
            return true
        }
        return false
    }
    
    func setActive(date: Date) {
        state.activeDate = date
        state.weekDays = weekdays(from: date)
    }
}

public enum CalenderPresentationStyle {
    case compact
    case overview
}

protocol CalenderStateProtocol {
    var weekDays: [CalendarDate] { get set }
    var month: String { get set }
    var monthList: [CalendarIntervall] { get set }
    var activeDate: Date { get set }
}

class CalenderState: CalenderStateProtocol, ObservableObject {
    var viewStyle: CalenderPresentationStyle = .compact
    var weekDays: [CalendarDate] = []
    var month: String = ""
    var monthList: [CalendarIntervall] = []
    var activeDate: Date = Date()
}
