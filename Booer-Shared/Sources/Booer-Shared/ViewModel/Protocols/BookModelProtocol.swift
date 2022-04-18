//
//  BookModelProtocol.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 29.03.21.
//

import Foundation

public protocol BookModelProtocol {
    func editItem()
    func updateItem(read: Float) -> Bool
    func getChallenge()
    func saveBook()
}
