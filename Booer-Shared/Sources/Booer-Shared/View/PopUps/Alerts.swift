//
//  File.swift
//  
//
//  Created by Veit Progl on 24.04.21.
//

import Foundation
import CoreData
import SwiftUI

public class DeleteAlert: ObservableObject {    
    @Published public var objectName = ""
    @Published public var item: NSManagedObject?
    @Published public var show = false
    @Published public var type = ""
    
    public var context: NSManagedObjectContext?
    
    public init() {}
    
    
    public enum AlertType {
        case error
        case delete
        case missing
    }
    public var alertType: AlertType = .error

    public func getAlert() -> Alert {
        switch alertType {
        case .delete:
            return cancelAlert()
        case .error:
            return errorAlert()
        case .missing:
            return missingFelds()
        }
        alertType = .error
    }
    
    func cancelAlert() -> Alert {
        guard let context = self.context else { return errorAlert() }
        
        let primaryButton = Alert.Button.default(Text("Do it")) {
            context.delete(self.item!)

            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        let secondaryButton = Alert.Button.cancel(Text("Please not")) {
            print("secondary button pressed")
        }
        
        return Alert(title: Text("Sure ?"),
                     message:  Text("Do you want to delete the \(self.type): \(self.objectName)"),
                     primaryButton: primaryButton,
                     secondaryButton: secondaryButton)
    }
    
    func errorAlert() -> Alert {
        let closeButton = Alert.Button.cancel(Text("Close")) {
            self.show = false
        }
        return Alert(title: Text("Whoops"),
                     message: Text("We got a error! That shouldn't happen"),
                     dismissButton: closeButton)
    }
    
    func missingFelds() -> Alert {
        let closeButton = Alert.Button.cancel(Text("Close")) {
            self.show = false
        }
        return Alert(title: Text("Something is missing"),
                     message: Text("It seams like that something is missing"),
                     dismissButton: closeButton)
    }
}
