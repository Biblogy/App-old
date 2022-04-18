//
//  SearchBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
import SwiftUI
import Booer_Shared

struct SearchBook: View {
    @Binding var isOpen: Bool
    @ObservedObject var book: AddBookData
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var api = OpenLibary.shared
    
    fileprivate func search() {
        if self.book.title != "" {
            api.getBooks(bookTitle: self.book.title) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    books = value
//                    print(books)
                }
            }
        }
    }
    
    var body: some View {
       NavigationView() {
            VStack() {
                List() {
                    HStack() {
                        TextField("Search", text: self.$book.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            search()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    }
                    
                    
                    if !books.isEmpty {
                        Section(header: Text("Search Results"), content: {
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
                        })
                    }
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }.navigationTitle("Seach Book")
        }
       .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.cancellationAction, content: {
                Text("Cancel")
            })
       })
        .onAppear(perform: {
            search()
        })
    }
}
