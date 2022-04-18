//
//  File.swift
//  
//
//  Created by Veit Progl on 04.06.21.
//

import Quick
import Nimble
import Cuckoo
@testable import Booer_Shared
import Foundation

class CalcChallengeDaysTests: QuickSpec {
    override func spec() {
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.container.viewContext
        var sut = CalcChallengeDays()
        var challenge = Challenges(context: context)
        
        beforeEach {
            sut = CalcChallengeDays()
            challenge = Challenges(context: context)
        }
        
        describe("CalcChallengeDays") {
            it("should return some read days") {
                challenge.start = Calendar.current.date(byAdding: .day, value: -2, to: Date())
                challenge.time = 2
                
                let book = Book(context: context)
                let progress1 = ReadProgress(context: context)
                progress1.date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
                
                let progress2 = ReadProgress(context: context)
                progress2.date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                
                let progress3 = ReadProgress(context: context)
                progress3.date = Calendar.current.date(byAdding: .day, value: 0, to: Date())
                
                book.bookProgress = [progress1, progress2, progress3]
                challenge.challengeBook = book
                
                
                let days = sut.readDays(challenge: challenge)
                expect(days).toNot(beEmpty())
                let day1 = Calendar.current.date(byAdding: .day, value: -2, to: Date())?.removeTime()
                let day2 = Calendar.current.date(byAdding: .day, value: -1, to: Date())?.removeTime()
                let day3 = Calendar.current.date(byAdding: .day, value: 0, to: Date())?.removeTime()
                expect(days).to(equal([day1, day2, day3]))
            }
            it("should return 3 days") {
                challenge.start = Calendar.current.date(byAdding: .day, value: -2, to: Date())
                challenge.time = 2
                
                let days = sut.neededDays(challenge: challenge)
                expect(days).toNot(beEmpty())
                let day1 = Calendar.current.date(byAdding: .day, value: -2, to: Date())?.removeTime()
                let day2 = Calendar.current.date(byAdding: .day, value: -1, to: Date())?.removeTime()
                let day3 = Calendar.current.date(byAdding: .day, value: 0, to: Date())?.removeTime()
                expect(days).to(equal([day1, day2, day3]))
            }
        }
    }
}
