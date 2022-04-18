//
//  SwiftUIView.swift
//  
//
//  Created by Veit Progl on 18.09.21.
//

import SwiftUI
import Booer_Shared

class BookDetailsData: ObservableObject {
    var coverColor: Color?
    @Published var book: Book
    
    init(book: Book) {
        self.book = book
        self.coverColor = book.coverColor
        
        if self.book.thumbnail == nil {
            self.book.thumbnail = self.generateThundnailImage().pngData()
        }
    }
    
    func generateThundnailImage() -> UIImage {
        if #available(iOS 15.0, *) {
            return (UIImage(data: book.cover!)?.preparingThumbnail(of: CGSize(width: 720, height: 1080)))!
        } else {
            // Fallback on earlier versions
            return UIImage(data: book.cover!)!
        }
    }
}

struct LibaryDetails: View {
    @ObservedObject var data: BookDetailsData
    
    var body: some View {
        ScrollView() {
            ZStack(alignment: .leading) {
                pageView(opacity: 0.5, width: 165, degrees: -3, leadingPaddig: 5, horizontalPadding: 4)

                data.coverColor
                    .opacity(0.5)
                    .frame(width: 165)
                    .cornerRadius(7)
                    .rotation3DEffect(.degrees(-3), axis: (x: 0, y: 1, z: 0))
                    .padding([.leading], 5)
                    .padding([.top, .bottom], 4)
                
                pageView(opacity: 0.4, width: 160, degrees: -4, leadingPaddig: 5, horizontalPadding: 9)
                
                pageView(opacity: 0.7, width: 155, degrees: -5, leadingPaddig: 5, horizontalPadding: 9)
                
                coverView(cover: UIImage(data: data.book.thumbnail!), color: data.coverColor ?? Color.red)
                
            }.frame(height: 250)
            
//            Text(book)
        }
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.black)
      Spacer()
    }
    .padding()
    .background(Color.gray.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct pageView: View {
    let opacity: Double
    let width: CGFloat
    let degrees: Double
    let leadingPaddig: CGFloat
    let horizontalPadding: CGFloat
    
    var body: some View {
        Color.white
            .opacity(opacity)
            .frame(width: width)
            .cornerRadius(7)
            .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
            .padding([.leading], leadingPaddig)
            .padding([.top, .bottom], horizontalPadding)
            .drawingGroup()
    }
}

struct coverView: View {
    let cover: UIImage?
    let color: Color
    
    var body: some View {
        if cover != nil {
            GeometryReader() {geo in
                Image(uiImage: cover!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 155, height: geo.size.height)
                    .scaleEffect(1.1)
            }
            .frame(width: 155)
            .background(color)
            .cornerRadius(7)
            .rotation3DEffect(.degrees(-8), axis: (x: 0, y: 1, z: 0))
        } else {
            GeometryReader() { geo in
                Image("cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(7)
                    .frame(width: 155, height: geo.size.height)
            }
            .frame(width: 155)
            .rotation3DEffect(.degrees(-8), axis: (x: 0, y: 1, z: 0))
        }
    }
}
//
//struct LibaryDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        LibaryDetails()
//    }
//}
