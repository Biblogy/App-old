//
//  File.swift
//  
//
//  Created by Veit Progl on 13.03.22.
//

import Foundation
import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    @ObservedObject var calendarFullModel = CalendarFullViewModel()

    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(calendarFullModel.months(interval: interval), id: \.self) { month in
                Section(header: header(for: month)) {
                    ForEach(calendarFullModel.days(for: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date).id(date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
            }
        }
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
}

struct CalenderFullsize: View {
    @Binding var isOpen: Bool
    @ObservedObject var interactor: CalendarInteractor
    @EnvironmentObject var dashboadState: DashboardState

    var body: some View {
        NavigationView(){
            ScrollViewReader { proxy in
                ScrollView(){
                    VStack() {
                        ForEach(self.interactor.state.monthList){ month in
                            VStack {
                                CalendarView(interval: month.interval) { day in
                                    Text("\(interactor.getDay(from: day))")
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 28)
                                        .padding(8)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                        .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(interactor.checkIfDateIsToday(date: day) ? Color.green : Color.clear, lineWidth: 4)
                                            )
                                        .onTapGesture {
                                            interactor.setActive(date: day)
                                            dashboadState.activeDate = day
                                            isOpen = false
                                        }
                                }.padding()
                            }.id(month.id)
                        }
                    }
                    .onAppear(perform: {
                        withAnimation {
                            proxy.scrollTo(interactor.getCurrentMonthID(), anchor: .top)
                        }
                    })
                }
            }.navigationTitle("Calendar")
                .navigationBarItems(trailing: VStack{
                    Button("close") {
                        isOpen = false
                    }
                })
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(interval: .init()) { _ in
            Text("30")
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}
