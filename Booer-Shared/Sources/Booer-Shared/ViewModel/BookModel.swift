//
//  ObservableBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine
import Foundation
import SwiftUI
import CoreData

public class BookModel: ObservableObject, BookModelProtocol {
    @Published public var item: Book
    @Published var read: String
    @Published public var cover: Image?
    
    var context: NSManagedObjectContext
    var challenge: ChallengeModelProtocol?
    var calcDays: CalcChallengeDaysProtocol = CalcChallengeDays()
    
    public init(item: Book, context: NSManagedObjectContext) {
        self.item = item
        self.context = context
        self.read = "\(Int(item.progress))"
    }
    
    public func getCover() {
        if item.cover != nil {
            #if os(iOS)
                self.cover =  Image(uiImage: UIImage(data: item.cover!)!)
            #else
                self.cover = Image(nsImage: NSImage(data: item.cover!)!)
            #endif
        }
    }
    
    public func editItem() {
        item.progress -= 1
        setDone()
    }
    
    public func updateItem(read: Float) -> Bool {
        let progressError = setProgress(read: read)
        setDone()
        
        return progressError
    }
    
    internal func setDone() {
        if item.pages == item.progress {
            item.done = true
            item.doneAt = Date()
        } else {
            item.done = false
            item.doneAt = nil
        }
    }
    
    internal func setProgress(read: Float, date:Date = Date()) -> Bool {
        if read > item.pages {
            return true
        } else {
            item.progress = read
            
            let progress = ReadProgress(context: context)
            progress.date = date
            progress.progress = Int64(read)
            progress.bookid = item.id
            item.addToBookProgress(progress)
            
            return false
        }
    }
    
    public func getChallenge() {
        if item.bookChallenge != nil {
            for item in item.bookChallenge!.allObjects {
                let challenge = item as! Challenges

                self.challenge = ChallengeModel(challenge: challenge, context: context, days: calcDays)
                self.challenge?.getDays()
                self.challenge?.calcStreak()
                _ = self.challenge?.setDone()
                self.challenge?.saveItem()
            }
        }
    }
    
    public func saveBook() {
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
