//
//  SwiftUIView.swift
//  
//
//  Created by Veit Progl on 05.06.21.
//

import SwiftUI
import Booer_Shared
import Combine

struct DisplayBook: View {
    @State var book: Book
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack() {
            VStack() {
                Text(book.title ?? "error")
                    .font(.headline)
                    .bold()
                Text(book.author ?? "error")
                    .font(.subheadline)
            }
            Spacer()
            VStack() {
                Button(action: {
                    saveToCD(book: book, state: .bookshelf)
                }) {
                    Text("Bookshelf") // maybe booksheelf
                }.buttonStyle(DefaultButtonStyle())
                
                Button(action: {
                    saveToCD(book: book, state: .progress)
                }, label: {
                    Text("Progress") // maybe reading
                }).buttonStyle(DefaultButtonStyle())

                Button(action: {
                    saveToCD(book: book, state: .progress)
                }, label: {
                    Text("Done")
                }).buttonStyle(DefaultButtonStyle())
            }
        }
    }
    
    func saveToCD(book: Book, state: BookProgressState) {
        book.state = state
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

struct AddViewLibary: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 1"), animation: .default)
    private var itemsNotStarted: FetchedResults<Book>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 2"), animation: .default)
    private var itemsProgress: FetchedResults<Book>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 3"), animation: .default)
    private var itemsDone: FetchedResults<Book>
    
    var body: some View {
        NavigationView() {
            List(){
                Section(header: Text("Not started")) {
                    ForEach(itemsNotStarted) { book in
                        DisplayBook(book: book)
                    }
                }
                Section(header: Text("Progress")) {
                    ForEach(itemsProgress) { book in
                        DisplayBook(book: book)
                    }
                }
                Section(header: Text("Done")) {
                    ForEach(itemsDone) { book in
                        DisplayBook(book: book)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Change Book State")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddViewLibary()
    }
}
