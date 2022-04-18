import SwiftUI
import Booer_Shared

public struct TabbarView: View {
    public init() {}
    
    public var body: some View {
        TabView {
            NavigationView() {
                NavigationIos()
            } .tabItem { Label("Books to read", systemImage: "text.book.closed.fill") }
//            TimeCounter()
//                .tabItem { Label("Timer", systemImage: "stopwatch") }
            NavigationView() {
                LibaryList()
            }.tabItem { Label("Bookshelf", systemImage: "books.vertical.fill") }
            
            NavigationView() {
            ChallengeViewMobile()
            } .tabItem { Label("Challenges", systemImage: "checkmark.seal") }
       }
    }
}

public struct NavigationIos: View {
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    public init() {}

    public var body: some View {
//        NavigationView() {
            BookOverview()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                       EditButton()
                    })

                    ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                        Button(action: {
                                self.sheetData.selectedSheet = .AddBook
                                self.sheetData.isOpen.toggle()
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    })
                })
                .navigationBarTitle("Booer")
//        }
//
    }
}
