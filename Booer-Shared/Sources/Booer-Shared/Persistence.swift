//
//  Persistence.swift
//  Shared
//
//  Created by Veit Progl on 24.04.21.
//

import CoreData

public struct PersistenceController {
    public static let shared = PersistenceController()

    public static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Book(context: viewContext)
            newItem.title = "demo"
            newItem.progress = 0
            newItem.author = "veit"
            newItem.isbn = "w"
            newItem.year = Date()
            newItem.id = UUID().uuidString
            newItem.pages = 100
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    public let container: NSPersistentCloudKitContainer

    public init(inMemory: Bool = false) {
        let modelURL = Bundle.module.url(forResource:"BooerCloud", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        
        container = NSPersistentCloudKitContainer(name: "BooerCloud", managedObjectModel: model!)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
