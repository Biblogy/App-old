//
//  File.swift
//  
//
//  Created by Veit Progl on 17.05.21.
//

import Foundation
import SwiftUI
import Booer_Shared

struct ChallengeViewMobile: View {
    @State private var selected = 1
    
    @EnvironmentObject var sheetData: AddSheetData
    
    var body: some View {
//        NavigationView() {
            List() {
                ChallengeSectionNotDone()
                ChallengeSectionDone()
            }
            .navigationTitle("Challenges")
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
//        }
    }
}

struct ChallengeSectionNotDone: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)],
                  predicate: NSPredicate(format: "isDone == false"),
                  animation: .default)
    
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

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)],
                  predicate: NSPredicate(format: "isDone == true"),
                  animation: .default)
    
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
        VStack() {
            HStack() {
                Group() {
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
                        alertData.alertType = .delete
                        alertData.show = true
                    }
            }
            Text("You want to read \(String(data.challengeBook?.title ?? "error")) in \(data.time) days")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}

public enum time:String {
    case days, weeks, month, years
}
