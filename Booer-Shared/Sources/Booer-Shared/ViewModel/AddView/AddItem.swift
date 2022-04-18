//
//  AddItem.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Combine
import CoreData
import SwiftUI


public func addItem(book: BookItem, viewContext: NSManagedObjectContext) {
    withAnimation {
        let newItem = Book(context: viewContext)
//            newItem.timestamp = Date()
        newItem.title = book.title
        newItem.progress = 0
        newItem.author = "veit"
        newItem.isbn = "w"
        newItem.year = Date()
        newItem.addedAt = Date()
        newItem.id = UUID().uuidString
        newItem.done = false
        newItem.pages = Float(book.pages ?? "0") ?? 0

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
