//
//  AddViewMac.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 23.01.21.
//

import SwiftUI
import Booer_Shared

struct AddViewMac: View {
    @Binding var isOpen: Bool
    @ObservedObject var book = AddBookData()
    
    @State private var isCorrect = true
    @State private var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    @State private var booktitle = ""
    
    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    fileprivate func LabeledTextedField(title: String, textField: Binding<String>) -> some View {
        return HStack() {
            Text(title + ":").bold()
            TextField(title, text: textField)
                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
        }
    }
    
    static var numerDottetFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.isLenient = false
        return nf
    }
    
    func saveToDB() {
        if self.book.title != "" && self.book.pages != "" {
            let newItem = Book(context: viewContext)
            newItem.title = self.book.title
            newItem.progress = self.book.progress
            newItem.author = self.book.author
            newItem.isbn = self.book.isbn
            newItem.year = self.book.baugtAt
            newItem.id = self.book.id
            newItem.pages = Float(self.book.pages) ?? 0

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            isCorrect = false
        }
    }
    
    var body: some View {
        SheetViewModifiyable(content: {
            VStack() {
                if !isCorrect {
                    Text("There is some required feld missing, plase check")
                        .foregroundColor(Color.red)
                }
                GroupBox(label: Text("Required")) {
                    VStack() {
                        HStack() {
                            LabeledTextedField(title: "Search", textField: self.$book.title)
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }, label: {
                                Image(systemName: "magnifyingglass")
                            })
                        }
                        LabeledTextedField(title: "Author", textField: self.$book.author)
                        
                        HStack() {
                            Text("Pages:").bold()
                            TextField("Pages", text: self.$book.pages)
                                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
                        }
                    }
                }
                
                GroupBox(label: Text("Optional")) {
                    DatePicker(selection: self.$book.baugtAt, displayedComponents: .date, label: {
                        Text("Baugt at:").bold()
                    })
                        .datePickerStyle(CompactDatePickerStyle())
                }
            }
            .padding()
        }, conformAction: {
            Button(action: {
                self.saveToDB()
            }, label: {
                Text("Add")
            })
        }, cancelAction: {
            isOpen.toggle()
        })
        .sheet(isPresented: self.$showSheet, content: {
            AddViewMacOS(isOpen: self.$showSheet, book: self.book)
        })
    }
}
