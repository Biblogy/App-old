//
//  testExtension.swift
//  
//
//  Created by Veit Progl on 12.02.22.
//

import Foundation
import XCTest

extension XCTestCase {
    func test<T>(_ description: String, block: () throws -> T) rethrows -> T {
        try XCTContext.runActivity(named: description, block: { _ in try block() })
    }
}
