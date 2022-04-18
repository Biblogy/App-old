//
//  NavigationNew.swift
//  
//
//  Created by Veit Progl on 13.06.21.
//

import SwiftUI
import UIKit
import Booer_Shared

public struct NavigationNew: View {
    public init() {}
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext
    
    public var body: some View {
        Group(){
            if sizeClass == .compact {
                DashboardView()
            } else {
                NavigationView() {
                    if #available(iOS 15.0, *) {
                        Sidebar(content: {
                            NavigationLink(destination: NavigationIos(), label: {
                                Label("Books to read", systemImage: "book")
                            })
                            NavigationLink(destination: BooksDoneRead(), label: {
                                Label("Books Done", systemImage: "book.closed")
                            })
                            NavigationLink(destination: ChallengeViewMobile(), label: {
                                Label("Challenges", systemImage: "book.closed")
                            })
                            NavigationLink(destination: LibaryList(), label: {
                                Label("Libary", systemImage: "book.closed")
                            })
                        })
                        
                        NavigationIos()
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
        .alert(isPresented: self.$alertData.show, content: self.alertData.getAlert)
        .sheet(isPresented: self.$sheetData.isOpen, content: {
            if sheetData.selectedSheet == .AddBook {
                AddView(isOpen: self.$showAddView)
            } else if sheetData.selectedSheet == .AddChallenge {
                AddChallengeMobile(isOpen: self.$showAddView)
                    .environmentObject(alertData)
            } else if sheetData.selectedSheet == .AddLibary {
                AddViewLibary()
            }
        })
    }
}

struct NavigationNew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNew()
    }
}
