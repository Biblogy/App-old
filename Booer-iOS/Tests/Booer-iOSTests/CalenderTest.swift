//
//  CalenderTest.swift
//  
//
//  Created by Veit Progl on 12.02.22.
//

import XCTest
import Relay
@testable import Booer_iOS
import Booer_Shared
import Foundation

final class CalenderTest: XCTestCase {
    let sut = CalendarInteractor()

    override func setUp() {
        do {
            let defaultRegistry = DefaultDependencyRegistry()
            try defaultRegistry.registerDependencies()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func test_InteractorState() throws {
        test("shoud have a state") {
            XCTAssertNotNil(sut.state)
        }
    }
    
    func test_LoadData() {
        test("month days state shoud not be empty"){
            sut.loadData()
            XCTAssert(sut.state.weekDays != [])
        }
        
        test(""){
            sut.loadData()
            XCTAssert(sut.state.month != "")
        }
    }
    
    func test_Weekdays(){
        test("return count shoud be 7") {
            let result = sut.weekdays()
            
            XCTAssert(result.count == 7)
        }
        
        test("return shoud include input date") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2021/02/27 13:42")
            
            let inputDate = Date(timeInterval: 0, since: someDateTime!)
            let result = sut.weekdays(from: inputDate)
            let resultDate = result.first(where: {$0.date == inputDate})
            XCTAssert(resultDate?.date == inputDate)
        }
        
        test("return shoud start with first weekday") {
            let result = sut.weekdays()
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: result.first!.date)
            
            XCTAssert(weekday == 1)
        }
        
        
        test("retun shoud end with last weekday") {
            let result = sut.weekdays()
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: result.last!.date)
            
            XCTAssert(weekday == 7)
        }
        
        test("shoud set today"){
            let result = sut.weekdays()
            
            XCTAssert(result.contains(where: {$0.isToday == true}))
        }
        
        test("isToday shoud only be one time true"){
            let result = sut.weekdays()
            let todays = result.filter({$0.isToday == true})
            XCTAssert(todays.count == 1)
        }
    }
    
    func test_GetMonth(){
        test("shoud return string") {
            let result = sut.getMonth()
            XCTAssert(type(of: result) == String.self)
        }
        
        test("shoud get Januar") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2021/01/27 13:42")
            
            let inputDate = Date(timeInterval: 0, since: someDateTime!)
            
            let result = sut.getMonth(for: inputDate)
            
            XCTAssert(result == "Januar")
        }
    }
    
    func test_getToday(){
        test("shoud get true"){
            let result = sut.getToday(for: Date())
            XCTAssert(result == true)
        }
        
        test("shoud return false"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2/01/27 13:42")
            let inputDate = Date(timeInterval: 0, since: someDateTime!)
            
            let result = sut.getToday(for: inputDate)
            XCTAssert(result == false)
            
        }
    }
    
//    func test_onDayTap() {
//        test("shoud remove old active") {
//            sut.state.weekDays = sut.weekdays(from: Date())
//            sut.state.weekDays[0].active = true
//            sut.onDayTap(on: sut.state.weekDays[0])
//            XCTAssert(sut.state.weekDays[0].active == false)
//        }
//    }
//
    func test_getDay() {
        test("shoud return some Int") {
            let result = sut.getDay(from: Date())
            XCTAssert(type(of: result) == Int.self)
        }
    }
    
    func test_testSomeMoreStuff() {
        test("return shoud not be empty") {
            sut.loadData()
            let result = sut.getCurrentMonthID()
            XCTAssert(!result!.isEmpty)
        }
        
        test("shoud get correct ID"){
            let dateStart = Calendar.current.date(byAdding: .day, value: -10 , to: Date())
            let dateEnd = Calendar.current.date(byAdding: .day, value: 10 , to: Date())

            let calendarIntervall = CalendarIntervall(interval: DateInterval(start: dateStart!, end: dateEnd!), id: "test1")
            sut.state.monthList = [calendarIntervall, CalendarIntervall(interval: DateInterval(start: Date(), end: Date()))]
            
            let result = sut.getCurrentMonthID()
            XCTAssert(result == "test1")
        }
    }
    
    func test_checkIfDateIsToday(){
        test("should return true"){
            let result = sut.checkIfDateIsToday(date: Date())
            
            XCTAssert(result)
        }
        
        test("shoud return false"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2/01/27 13:42")
            let inputDate = Date(timeInterval: 0, since: someDateTime!)

            let result = sut.checkIfDateIsToday(date: inputDate)
            
            XCTAssert(!result)
        }
    }
    
    func test_setActive(){
        test("shoud change active date"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2/01/27 13:42")
            let inputDate = Date(timeInterval: 0, since: someDateTime!)

            XCTAssert(sut.dateWorker.removeTime(from: sut.state.activeDate) == sut.dateWorker.removeTime(from: Date()))
            sut.setActive(date: inputDate)
            XCTAssert(sut.state.activeDate == inputDate)
        }
    }
}
