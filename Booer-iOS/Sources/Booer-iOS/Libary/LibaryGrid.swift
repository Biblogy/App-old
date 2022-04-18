//
//  SwiftUIView.swift
//  
//
//  Created by Veit Progl on 17.09.21.
//

import SwiftUI
import Booer_Shared

struct VisualBlur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct LibaryGrid: View {
    var book: Book
    @State var width: CGFloat = 163
    @State var height: CGFloat = 244
    
    var body: some View {
        NavigationLink(destination: {
            LibaryDetails(data: BookDetailsData(book: book))
        }, label: {
            VStack() {
                ZStack() {
                    Group() {
                        if book.thumbnail != nil {
                            GeometryReader() {geo in
                                Image(uiImage: UIImage(data: book.thumbnail!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width, height: geo.size.height)
                            }
                            .frame(width: width)
                            .background(book.coverColor)
                        } else {
                            GeometryReader() { geo in
                                Image("cover")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(7)
                                    .frame(width: 80, height: geo.size.height)
                            }
                            .frame(width: 80)
                            .padding([.leading, .bottom], 10)
                        }
                    }.drawingGroup()
                    
                    VStack() {
                        Spacer()
                        VStack() {
                            Text(book.title!).bold()
                            Text(book.author!).font(.subheadline)
                        }
                        .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding([.leading, .trailing], 3)
                        .padding([.top, .bottom], 5)
                        .background(VisualBlur(style: .systemMaterialLight))
                    }
                    .frame(minHeight: 0 , maxHeight: .infinity)
                }
                .frame(width: width, height: height)
                .cornerRadius(7)
                .shadow(radius: 7)
                .padding(.bottom, 20)
            }
        })
    }
}
