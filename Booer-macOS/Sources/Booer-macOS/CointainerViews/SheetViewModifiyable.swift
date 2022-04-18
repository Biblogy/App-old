//
//  SheetViewModifiyable.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 23.01.21.
//

import SwiftUI

struct SheetViewModifiyable<Content: View, ConformAction: View>: View {
    var content: () -> Content
    var conformAction: () -> ConformAction
    var cancelAction: () -> Void

    init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder conformAction: @escaping () -> ConformAction,
        cancelAction: @escaping () -> Void) {
            self.content = content
            self.conformAction = conformAction
            self.cancelAction = cancelAction
   }

    var body: some View {
        VStack(){
            VStack(content: content)
            Spacer()
        }
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                Button(action: cancelAction, label: {
                    Text("Close")
                })
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.confirmationAction, content: conformAction)
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewModifiyable(content: {
            Text("test")
        }, conformAction: {
            Text("ww")
        }, cancelAction: {
            
        })
    }
}
