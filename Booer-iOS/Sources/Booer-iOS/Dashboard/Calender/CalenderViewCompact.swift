//
//  SwiftUIView.swift
//  
//
//  Created by Veit Progl on 07.02.22.
//

import SwiftUI
import Relay
import Booer_Shared

struct CalenderViewCompact: View {
    @StateObject var interactor = CalendarInteractor()
    @State var openSheet = false
    @EnvironmentObject var dashboadState: DashboardState
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text(interactor.state.month)
                    .bold()
                Spacer()
                Image(systemName: "calendar")
                    .onTapGesture {
                        self.openSheet.toggle()
                    }
            }
            
            HStack() {
                ForEach($interactor.state.weekDays) { day in
                    VStack(){
                        HStack() {
                            Spacer()
                            Text(String(self.interactor.getDay(from: day.wrappedValue.date)))
                                .font(.system(size: 15))
                                .minimumScaleFactor(0.01)
                            Spacer()
                        }
                        .padding([.top, .bottom], 5)
                        .frame(minHeight: 0, maxHeight: .infinity)
                    }
                    .background(dashboadState.activeDate == day.wrappedValue.date ? Color.red : Color.green)
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(day.isToday.wrappedValue ? Color.blue : Color.clear , lineWidth: 4)
                        )
                    .cornerRadius(5)
                    .padding(1)
                    .onTapGesture {
                        self.interactor.onDayTap(on: day.wrappedValue)
                        self.dashboadState.activeDate = day.wrappedValue.date
                    }
                    .frame(height: 35)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }.onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willEnterForegroundNotification
        )) { _ in
            interactor.loadData()
        }
        .onAppear(perform: {
            interactor.loadData()
        })
        .sheet(isPresented: self.$openSheet, onDismiss: {}, content: {
            CalenderFullsize(isOpen: self.$openSheet, interactor: self.interactor)
        })
    }
}


struct Calender_Previews: PreviewProvider {
    static var previews: some View {
        CalenderViewCompact()
    }
}
