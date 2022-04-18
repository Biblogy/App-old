//
//  File.swift
//  
//
//  Created by Veit Progl on 05.04.22.
//

import XCTest
@testable import Booer_iOS

class CalenderFullViewTest: XCTestCase {
    let sut = CalendarFullViewModel()
    
    func test_generateDates() {
        test("return should be 20"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let startDateTime = formatter.date(from: "2021/02/1 13:42")
            let startDate = Date(timeInterval: 0, since: startDateTime!)
            
            let endDateTime = formatter.date(from: "2021/02/20 13:42")
            let endDate = Date(timeInterval: 0, since: endDateTime!)
            
            let dateIntervall = DateInterval(start: startDate, end: endDate)
            let result = sut.generateDates(inside: dateIntervall, matching: DateComponents(hour: 0, minute: 0, second: 0))
            print(result)
            XCTAssert(result.count == 20)
        }
        
        test("should return first date of month") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let startDateTime = formatter.date(from: "2021/02/1 13:42")
            let startDate = Date(timeInterval: 0, since: startDateTime!)
            
            let endDateTime = formatter.date(from: "2021/02/20 13:42")
            let endDate = Date(timeInterval: 0, since: endDateTime!)
            
            let dateIntervall = DateInterval(start: startDate, end: endDate)
            let result = sut.generateDates(inside: dateIntervall, matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
            XCTAssert(result.count == 1)
            XCTAssert(result.first == startDate)
        }
    }
}
