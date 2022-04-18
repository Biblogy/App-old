//
//  File.swift
//  
//
//  Created by Veit Progl on 03.06.21.
//

import Foundation
import SwiftUI

public enum BookProgressState: Int16 {
    case progress = 2
    case done = 3
    case bookshelf = 1
}

extension Book {
    public var state: BookProgressState {
        get {
            return BookProgressState(rawValue: self.stateValue) ?? BookProgressState.bookshelf
        }
        set{
            self.stateValue = newValue.rawValue
        }
    }
}

extension Book {
    public var coverColor: Color {
        get {
            return Color(hexString: self.avgCoverColor ?? "") ?? Color.gray
        }
        set {
            self.avgCoverColor = UIColor(newValue).htmlRGBaColor
        }
    }
}
