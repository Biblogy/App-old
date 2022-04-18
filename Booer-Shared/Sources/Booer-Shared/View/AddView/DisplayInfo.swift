//
//  DisplayInfo.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI
import CoreData
import Combine

public struct DisplayInformation: View {
    public let book: BookItem
    
    public init(book: BookItem) {
        self.book = book
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(book.title ?? "Error").font(.headline)
            Text("Author:")
            
            Group() {
                ForEach(Array(Set(book.authorName ?? ["Error"])).sorted(), id: \.self) { name in
                    Text(name)
                }
            }

            Text("Date:").padding([.top], 5)
            
            ForEach(Array(Set(book.publishYear ?? [])).sorted(), id: \.self) { date in
                Text(String(date))
            }
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}
