//
//  AddViewMacOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI
import CoreData
import Combine
import Booer_Shared

struct AddViewMacOS: View {
    @Binding var isOpen: Bool
    @ObservedObject var book: AddBookData
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        SheetViewModifiyable(content: {
            TextField("Search", text: self.$book.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing, .top])

            List() {
                if !books.isEmpty {
                    Text("Search Results").font(Font.subheadline).padding([.leading], 7)
                }
                
                ForEach(books) { book in
                    GroupBox() {
                        VStack() {
                            HStack() {
                                DisplayInformation(book: book)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            Button(action: {
                                self.book.title = book.title ?? ""
                                self.book.author = book.authorName?.first ?? ""
                                self.book.pages = book.pages ?? ""
                                self.book.isbn = book.isbn?.first ?? ""
                                
                                self.isOpen.toggle()
                            }, label: {
                                Text("Use")
                            })
                        }
                    }
                }
            }
        }, conformAction: {
            Button(action: {
                OpenLibary().getBooks(bookTitle: self.book.title) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        books = value
                        print(books)
                    }
                }
            }, label: {
                Text("Search")
            })
        }, cancelAction: {
            isOpen.toggle()
        })
        .onAppear(perform: {
            if self.book.title != "" {
                
                OpenLibary().getBooks(bookTitle: self.book.title) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        books = value
                        print(books)
                    }
                }
            }
        })
    }
}
