//
//  ItemFormater.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Foundation

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
