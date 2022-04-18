//
//  DashboardView.swift
//  
//
//  Created by Veit Progl on 06.03.22.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var state = DashboardState()
    
    var body: some View {
        NavigationView(){
            List(){
                Section(){
                    CalenderViewCompact()
                }
                
                Section(){
                    Text("\(state.activeDate)")
                }
            }.navigationTitle("Dashboard")
        }.environmentObject(state)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
