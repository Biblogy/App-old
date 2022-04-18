//
//  AddView.swift
//  
//
//  Created by Veit Progl on 15.05.21.
//

import Foundation
import SwiftUI
import Booer_Shared
import ImageIO

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

struct AddView: View {
    @Binding var isOpen: Bool
    @ObservedObject var book = AddBookData()
    
    @State private var isCorrect = true
    @State private var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    @State private var booktitle = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        self.book.image = inputImage
        image = Image(uiImage: inputImage)
    }
    
    fileprivate func LabeledTextedField(title: String, textField: Binding<String>) -> some View {
        return HStack() {
            Text(title + ":").bold()
            TextField(title, text: textField)
                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
        }.padding(1)
    }
    
    static var numerDottetFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.isLenient = false
        return nf
    }
    
    var body: some View {
        NavigationView() {
            Form() {
                if !isCorrect {
                    Text("There is some required feld missing, plase check")
                        .foregroundColor(Color.red)
                }
                
                Section(header: Text("Book Cover")) {
                    HStack() {
                        Spacer()
                        VStack(alignment: .center) {
                            if image != nil {
                                image!
                                    .resizable()
                                    .frame(width: 70, height: 100)
                            } else {
                                Button(action: {
                                    self.showingImagePicker = true
                                }) {
                                    Image(systemName: "text.below.photo")
                                        .resizable()
                                        .frame(width: 50, height: 60)
                                    Text("Add Cover")
                                }
                            }
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("Required")) {
                    HStack() {
                        Text("Book:").bold()
                        TextField("Title",text: self.$book.title)
                        Button(action: {
                            self.showSheet.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    }
                    HStack() {
                        Text("Author:").bold()
                        TextField("Book author", text: self.$book.author)

                    }
                    
                    HStack() {
                        Text("Pages:").bold()
                        TextField("Number of pages", text: self.$book.pages)
                    }
                }
                
                Section(header: Text("Optional")) {
                    DatePicker(selection: self.$book.baugtAt, displayedComponents: .date, label: {
                        Text("Baugt at:").bold()
                    })
                        .datePickerStyle(CompactDatePickerStyle())
                    
                    Picker(selection: self.$book.state, label: Text("Book State")) {
                        Text("Bookshelf").tag(BookProgressState.bookshelf)
                        Text("Reading").tag(BookProgressState.progress)
                        Text("Done").tag(BookProgressState.done)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add Book")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction, content: {
                    Button(action: {
                        self.isCorrect = self.book.saveToDB(context: viewContext)
                    }, label: {
                        Text("Add")
                    })
                })
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction, content: {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Canncel")
                    })
                })
            })
        }
        .sheet(isPresented: self.$showSheet, content: {
            SearchBook(isOpen: self.$showSheet, book: book)
        })
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}
