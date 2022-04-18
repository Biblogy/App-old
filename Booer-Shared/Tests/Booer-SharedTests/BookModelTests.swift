//
//  Tests_Shared.swift
//  Tests Shared
//
//  Created by Veit Progl on 28.11.20.
//

import Quick
import Nimble
import Cuckoo
import Foundation
@testable import Booer_Shared

class BookModelTests: QuickSpec {
    override func spec() {
        let persistenceController = PersistenceController(inMemory: true)
        var sut = BookModel(item: Book(context: persistenceController.container.viewContext), context: persistenceController.container.viewContext)
        

        beforeEach {
            sut = BookModel(item: Book(context: persistenceController.container.viewContext), context: persistenceController.container.viewContext)
        }
        
        describe("BookModel") {
            beforeEach {
                sut = BookModel(item: Book(context: persistenceController.container.viewContext), context: persistenceController.container.viewContext)
                
                sut.challenge = MockChallengeModelProtocol()
            }
            
            it("editItem") {
                sut.editItem()
                expect(sut.item.progress.doubleValue).to(beIdenticalTo(-1.0))
            }
            
            describe("setDone") {
                it("book not done") {
                    sut.item.pages = 3
                    sut.item.progress = 0
                    sut.setDone()
                    
                    expect(sut.item.done).to(beFalse())
                    expect(sut.item.doneAt).to(beNil())
                }
                
                it("book is done") {
                    sut.item.pages = 3
                    sut.item.progress = 3
                    sut.setDone()
                    
                    expect(sut.item.done).to(beTrue())
                    expect(sut.item.doneAt).toNot(beNil())
                }
            }
            
            describe("setProgress") {
                it("error bool should be true") {
                    sut.item.pages = 3
                    let errorBool = sut.setProgress(read: 5)
                    expect(errorBool).to(beTrue())
                }
                
                describe("should be true") {
                    beforeEach {
                        sut.item.pages = 3
                    }
                    
                    it("error bool should be false") {
                        let errorBool = sut.setProgress(read: 2)
                        
                        expect(errorBool).to(beFalse())
                    }
                    
                    it("should update Progress") {
                        _ = sut.setProgress(read: 2)
                        
                        expect(sut.item.bookProgress).toNot(beNil())
                        expect(sut.item.progress.doubleValue).to(beIdenticalTo(2.0))
                    }
                }
            }
            
            it("updateItem") {
                sut.item.pages = 3
                _ = sut.updateItem(read: 2)
                
                expect(sut.item.bookProgress).toNot(beNil())
                expect(sut.item.progress.doubleValue).to(beIdenticalTo(2.0))
            }
            
            it("getChallenge") {
                let challenge = Challenges(context: persistenceController.container.viewContext)
                let calcDays = MockCalcChallengeDaysProtocol()
                
                let day1 = Calendar.current.date(byAdding: .day, value: -3, to: Date())
                let day2 = Calendar.current.date(byAdding: .day, value: -2, to: Date())
                let day3 = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())

                stub(calcDays) {
                    $0.neededDays(challenge: any()).thenReturn([
                                                                tomorrow!.removeTime(),
                                                                day1!.removeTime(),
                                                                day2!.removeTime(),
                                                                day3!.removeTime()])
                    $0.readDays(challenge: any()).thenReturn([
                                                                day1!.removeTime(),
                                                                day3!.removeTime()])
                }
                
                sut.calcDays = calcDays
                
                challenge.isDone = true
                sut.item.addToBookChallenge(challenge)
                
                sut.getChallenge()
                expect(sut.challenge).toNot(beNil())
            }
        }
    }
}
