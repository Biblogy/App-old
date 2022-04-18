//
//  ChallengeView.swift
//  EBookTracking
//
//  Created by Veit Progl on 05.12.20.
//

import SwiftUI

public struct ChallengeView: View {
    @State private var selected = 1
    
    @EnvironmentObject var sheetData: AddSheetData
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)],predicate: NSPredicate(format: "isDone == false"), animation: .default)
    
    private var items: FetchedResults<Challenges>
    
    public init() {}
    
    public var body: some View {
        VStack() {
            VStack() {
                List() {
                    ChallengeSectionNotDone()
                    ChallengeSectionDone()
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(content: {
                Button(action: {
                    sheetData.selectedSheet = .AddChallenge
                    sheetData.isOpen.toggle()
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            })
        })
        .padding([.top], 10)
    }
}

struct ChallengeSectionNotDone: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)],predicate: NSPredicate(format: "isDone == false"), animation: .default)
    
    private var items: FetchedResults<Challenges>
    
    var body: some View {
        Section(header: Text("ToDo:"), content: {
            ForEach(items) { item in
                HStack() {
                    ChallengeItemView(data: item)
                }
            }
        })
    }
}

struct ChallengeSectionDone: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)],predicate: NSPredicate(format: "isDone == true"), animation: .default)
    
    private var items: FetchedResults<Challenges>
    
    var body: some View {
        Section(header: Text("Done:"), content: {
            ForEach(items) { item in
                ChallengeItemView(data: item)
            }
        })
    }
}

struct ChallengeItemView: View {
    @ObservedObject var data: Challenges
    
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack() {
            GroupBox() {
                HStack() {
                    Text(String(data.challengeBook?.title ?? "error"))
                    Spacer()
                    if data.isFailed {
                        Text("Failed")
                            .foregroundColor(Color.red)
                            .bold()
                    } else if data.isDone {
                        Text("Done")
                            .foregroundColor(Color.green)
                            .bold()
                    } else {
                        Text(String("\(data.streak)/\(data.time)"))
                            .foregroundColor(Color.green)
                            .bold()
                    }
                }
                .font(.system(.title))
            }
            
            Image(systemName: "xmark")
                .onTapGesture {
                    alertData.item = data
                    alertData.objectName = data.challengeBook?.title ?? "error"
                    alertData.type = "challenge"
                    alertData.show = true
                }
        }
    }
}

public enum time:String {
    case days, weeks, month, years
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
