//
//  BookOverview.swift
//  Booer-iOS
//
//  Created by Veit Progl on 15.11.20.
//

import SwiftUI
import CoreData
import Combine
import Booer_Shared

enum DashCellState: String {
    case total = "Total"
    case day = "Today"
    case streak = "Streak"
}

struct EmptyDataView: ViewModifier {
    let condition: Bool
    let message: String
    func body(content: Content) -> some View {
        valideView(content: content)
    }
    
    @ViewBuilder
    private func valideView(content: Content) -> some View {
        if condition {
            VStack{
                Spacer()
                Text(message)
                    .font(.title)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                Spacer()
            }.listRowBackground(Color.clear)
        } else {
            content
        }
    }
}

//MARK: View Extension
extension View {
    func onEmpty(for condition: Bool, with message: String) -> some View {
        self.modifier(EmptyDataView(condition: condition, message: message))
    }
}


struct DashCell: View {
    @State var displayType: DashCellState = .streak
    @ObservedObject var data: DashboardModel
    var body: some View {
        return Group {
            VStack() {
                Text(displayType.rawValue)
                Text("\(data.calcStreak())")
                    .font(.headline)
                Text("days streak")
            }.padding(5)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(5)
        .onTapGesture {
            switch displayType {
            case .streak:
                self.displayType = .day
            case .day:
                self.displayType = .total
            case .total:
                self.displayType = .streak
            }
        }
    }
}

public struct BookOverview: View {
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ReadProgress.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ReadProgress.date, ascending: false)])
    var items: FetchedResults<ReadProgress>
    
    public var body: some View {
        List() {
            Section() {
                HStack(){
                    
                }
            }
            Section() {
                displayAll()
            }
        }
    }
    
    struct displayAll: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
            predicate: NSPredicate(format: "stateValue == 2"), animation: .default)
        private var items: FetchedResults<Book>
        
        var body: some View {
            ForEach(items) { item in
                BookView(book: BookModel(item: item, context: viewContext))
            }.onEmpty(for: items.isEmpty, with: "Oops, loos like there's no data...") //<--- Here
        }
    }
}
