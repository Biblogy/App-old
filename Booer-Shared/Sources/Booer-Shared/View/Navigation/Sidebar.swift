//
//  Sidebar.swift
//  EBookTracking
//
//  Created by Veit Progl on 17.11.20.
//

import SwiftUI
import Combine
//import Booer_Shared


public struct Sidebar<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        List() {
            #if !os(iOS)
            Text("Booer")
                .font(.title)
            #endif
            
            Group() {
               content
            }
            
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
        .toolbar {
            #if !os(iOS)
            ToolbarItem(content: {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.left")
                })
            })
            #endif
        }
        #if os(iOS)
        .navigationBarTitle("Booer")
        #endif
    }
    
    private func toggleSidebar() {
        #if !os(iOS)
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

//struct Sidebar_Previews: PreviewProvider {
//    static var previews: some View {
//        Sidebar()
//    }
//}
