//
//  ChallengeModel.swift
//  EBookTracking
//
//  Created by Veit Progl on 07.01.21.
//

import Foundation
import Combine
import CoreData
import Relay

public class CalcChallengeDays: CalcChallengeDaysProtocol {
    @Injected var dateWorker: DateWorkerProtocol
    let calendar = Calendar.current
    
    public func neededDays(challenge: Challenges) -> Set<Date> {
        let start = dateWorker.removeTime(from: challenge.start ?? Date())
        guard let endDate = calendar.date(byAdding: .day, value: Int(challenge.time), to: challenge.start!) else { return [] }
        let end = dateWorker.removeTime(from: endDate)

        var dates = Set<Date>()
        var check = start

        while check <= end {
            dates.insert(check)
            guard let checkDate = calendar.date(byAdding: .day, value: 1, to: check) else { fatalError() }
            check = dateWorker.removeTime(from: checkDate)
        }

        return dates
    }
    
    public func readDays(challenge: Challenges) -> Set<Date> {
        if challenge.challengeBook != nil {
            var days = challenge.challengeBook!.bookProgress!.map({ time -> Date in
                guard let readProgress = time as? ReadProgress else { fatalError() }
                return dateWorker.removeTime(from: readProgress.date!)
            })
            days = days.filter { item  in
                return item >= dateWorker.removeTime(from: challenge.start!)
            }
            return Set(days)
        } else {
            return Set()
        }
    }
}

public class ChallengeModel: ChallengeModelProtocol {
    var challenge: Challenges
    var readDays: Set<Date> = []
    var days: Set<Date> = []
    var challengeDays: CalcChallengeDaysProtocol!
    
    var context: NSManagedObjectContext
    
    var bookIsRead = false
    
    @Injected var dateWorker: DateWorkerProtocol
        
    init(challenge: Challenges,
         context: NSManagedObjectContext,
         days: CalcChallengeDaysProtocol = CalcChallengeDays()) {
        self.context = context
        self.challenge = challenge
        self.challengeDays = days
    }
        
    public func getDays() {
        self.readDays = challengeDays.readDays(challenge: challenge)
        self.days = challengeDays.neededDays(challenge: challenge)
    }
    
    public func calcStreak() {
        print("===== \(challenge.challengeBook?.title ?? "ww") ======")
        print("===== \(challenge.time) ======")
        print(Array(readDays).sorted())
        print(Array(days).sorted())
        print(readDays.isSubset(of: days))
        
        var index = 0
        var failed = false

        readDays.sorted().forEach { day in
            let readDay = dateWorker.removeTime(from: day)
            let expectedDay = dateWorker.removeTime(from: Array(days).sorted()[index])
            if readDay == expectedDay {
                index += 1
                print(day)
            } else {
                failed = true
            }
        }
        if !failed {
            challenge.isFailed = false
            challenge.streak = Int16(index)
        } else {
            challenge.streak = 0
            challenge.isFailed = true
            challenge.isDone = false
        }
    }
    
    @discardableResult public func setDone() -> Bool {
        guard let start = challenge.start else { return false }
        if readDays.max() != nil {
            guard let end = Calendar.current.date(byAdding: .day, value: Int(challenge.time) - 1, to: start) else { return false }
            let maxReadDay = dateWorker.removeTime(from: readDays.max()!)
            let endDate = dateWorker.removeTime(from: end)
            
            if maxReadDay == endDate {
                challenge.isDone = true
            } else if challenge.challengeBook?.done ?? bookIsRead {
                challenge.isDone = true
            } else {
                challenge.isDone = false
            }
            return true
        }
        return false
    }
    
    @discardableResult private func setProgress(read: Float, date:Date = Date()) -> Bool {
        if read > challenge.challengeBook!.pages {
            return true
        } else {
            challenge.challengeBook!.progress = read
            
            let progress = ReadProgress(context: context)
            progress.date = date
            progress.progress = Int64(read)
            progress.bookid = challenge.challengeBook!.id
            challenge.challengeBook!.addToBookProgress(progress)
            
            return false
        }
    }
    
    public func saveItem() {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
