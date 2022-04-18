//
//  File.swift
//  
//
//  Created by Veit Progl on 17.05.21.
//

import Foundation
import SwiftUI
import Booer_Shared

public struct BooksDone: View {
    public init() {}
    
    public var body: some View {
        NavigationView() {
            BooksDoneRead()
                .navigationTitle("Done")
        }
    }
}
