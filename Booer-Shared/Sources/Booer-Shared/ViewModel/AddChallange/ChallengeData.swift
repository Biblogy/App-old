//
//  challengeData.swift
//  EBookTracking
//
//  Created by Veit Progl on 03.03.21.
//

import Foundation
import Combine
import SwiftUI
import CoreData

public class ChallengeData: ObservableObject {
    public init () {
        self.bookTitle = ""
    }
    
    public init(bookTitle: String) {
        self.bookTitle = bookTitle
    }
    
    @Published public var isNotValid = false
    @Published public var menuTime: time = .days
    @Published public var selected = 1
    @Published public var time = ""
    
    @Published public var bookID: String = "-404"
    @Published public var bookTitle: String
    @Published public var book: Book?
        
    public func validatingData() {
        if self.bookID != "" &&
            self.time != "" &&
            self.menuTime.rawValue != "" &&
            self.book != nil {
            self.isNotValid = false
        } else {
            self.isNotValid = true
        }
    }
    
    public func addChallenge(context: NSManagedObjectContext) {
        guard let time = Int16(time) else { return }
        
        let newItem = Challenges(context: context)
        newItem.id = UUID().uuidString
        newItem.time = time
        newItem.timeType = self.menuTime.rawValue
        newItem.start = Date()
        newItem.book = self.bookID
        newItem.challengeBook = self.book

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
