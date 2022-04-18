//
//  BookView.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import SwiftUI
import Combine
#if !os(iOS)
import AppKit
#endif

//MARK: customSlider
private struct customSlider: View {
    @Binding var progress: Float
    @Binding var pages: Float
    @Binding var read: String
    
    let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       return formatter
    }()
    
    var body: some View {
        VStack() {
            HStack() {
                Text("0")
                Spacer()
                Text("\(Int(pages))")
            }.padding([.bottom], -5)
            Slider(value: $progress, in: 0...pages, step: 1)
            GeometryReader { geometry in
                HStack() {
//                    TextField("read pages", value: $progress, formatter: formatter)
//                        .position(x: CGFloat(progress) * geometry.size.width / CGFloat(pages))
//                        .frame(alignment: .center)
//                        .multilineTextAlignment(.center)
//                        .frame(maxWidth: 100)
                    Text("\(Int(progress))")
                        .position(x: CGFloat(progress) * geometry.size.width / CGFloat(pages))
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 100)
                }
            }.padding([.leading, .trailing], 12)
        }
    }
}

//MARK: BookCoverView
struct BookCoverView: View {
    @Binding var cover: Image?
    var width: CGFloat
    var body: some View {
        GeometryReader() {geo in
            if cover != nil {
                cover!
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(7)
                    .frame(width: width, height: geo.size.height)
            } else {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: width, height: geo.size.height)
//                #if os(iOS)
//                    .foregroundColor(Color(UIColor.systemBackground))
//                #else
//                    .foregroundColor(Color(NSColor.))
//                #endif
                    .background(Color.orange
                                    .opacity(0.5)
                                    .shadow(radius: 5))
                    .frame(width: width, height: geo.size.height)
            }
        }
        .padding([.bottom, .top], 10)
        .frame(width: width)
    }
}

//MARK: BookView
public struct BookView: View {
    @ObservedObject var item: BookModel
    @State private var hasError = false
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    public init(book: BookModel) {
        self.item = book
    }
    
    public var body: some View {
            HStack(alignment: .top) {
                if item.item.cover != nil {
                    BookCoverView(cover: $item.cover, width: 90)
                }
                VStack(alignment: .trailing) {
                    Text("\(item.item.title ?? "error")").font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                    Text("\(item.item.author ?? "error")").font(.subheadline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                    customSlider(progress: $item.item.progress, pages: $item.item.pages, read: $item.read)
                        .padding([.top], 10)
                        .onReceive(Just(item.item.progress), perform: { _ in
                            item.saveBook()
                        })
                }
                .padding(10)
        }
        .frame(minHeight: 100)
        .cornerRadius(10)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ww")
    }
}
