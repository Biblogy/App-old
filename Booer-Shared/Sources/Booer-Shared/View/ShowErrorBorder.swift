//
//  ShowErrorBorder.swift
//  EBookTracking
//
//  Created by Veit Progl on 25.01.21.
//

import SwiftUI

public struct ShowErrorBorder: ViewModifier {
    let isCorrect: Binding<Bool>
    
    public init(isCorrect: Binding<Bool>) {
        self.isCorrect = isCorrect
    }
    
    public func body(content: Content) -> some View {
        content
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(isCorrect.wrappedValue ? Color.secondary : Color.red, lineWidth: 1)
            )
    }
}
