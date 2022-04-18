//
//  AddChallenge.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 06.12.20.
//

import SwiftUI
import Combine

public struct AddChallenge: View {
    @Binding var isOpen: Bool
    
    @ObservedObject var data = ChallengeData(bookTitle: "select a book")
    @Environment(\.managedObjectContext) private var viewContext

    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    public var body: some View {
            VStack() {
                Text("I will read")
                    .font(.title).bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                daysTextField(data: data)
                bookPicker(data: data)
                Spacer()
            }
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Close")
                    })
                }

                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
                    Button(action: {
                        validatingData(bookId: data.bookID, time: Int16(data.time) ?? -404, timeType: data.menuTime.rawValue, book: self.data.book)
                        if !data.isNotValid {
                            addChallenge(bookId: data.bookID, time: Int16(data.time) ?? -404, timeType: data.menuTime.rawValue, book: self.data.book!)
                        }
                    }, label: {
                        Text("Add")
                    })
                }
            })
            .padding([.top, .leading, .trailing], 20)
            .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
    
    func validatingData(bookId: String, time: Int16, timeType: String, book: Book?) {
        if bookId != "" &&
            time != -404 &&
            timeType != "" &&
            book != nil {
            self.data.isNotValid = false
        } else {
            self.data.isNotValid = true
        }
    }
    
    func addChallenge(bookId: String, time: Int16, timeType: String, book: Book) {
            let newItem = Challenges(context: viewContext)
            newItem.id = UUID().uuidString
            newItem.time = time
            newItem.timeType = timeType
            newItem.start = Date()
            newItem.book = bookId
            newItem.challengeBook = book

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

//struct AddChallenge_Previews: PreviewProvider {
//    @State private var isOpen = true
//    static var previews: some View {
//        AddChallenge(isOpen: self.$isOpen)
//    }
//}
