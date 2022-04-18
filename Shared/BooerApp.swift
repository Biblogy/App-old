//
//  BooerApp.swift
//  Shared
//
//  Created by Veit Progl on 23.04.21.
//

import SwiftUI
import Booer_Shared
import CoreData
import Relay
import Inject

#if os(iOS)
import Booer_iOS
#else
import Booer_macOS
#endif

@main
struct BooerApp: App {
    var sheetData = AddSheetData()
    var alertData = DeleteAlert()
    let persistenceController = PersistenceController.shared
    @ObservedObject private var iO = Inject.observer
    
    var body: some Scene {
        WindowGroup {
            VStack() {
                #if os(iOS)
                    NavigationNew()
                #else
                    NavigationMac()
                #endif
            }
            .environmentObject(sheetData)
            .environmentObject(alertData)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onAppear(perform: {
                self.alertData.context = persistenceController.container.viewContext
                let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                print(urls[urls.count-1] as URL)
                registerDependencies()
            })
            .enableInjection()
        }
    }
    
    private func registerDependencies() {
        do {
            let defaultRegistry = DefaultDependencyRegistry()
            try defaultRegistry.registerDependencies()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct BooerApp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNew()
    }
}
