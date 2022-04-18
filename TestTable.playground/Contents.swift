import UIKit
import SwiftUI
import PlaygroundSupport

var greeting = "Hello, playground"

struct Example: View {
    var body: some View {
        VStack {
            HSplitView {
                Rectangle().foregroundColor(.red).frame(width: 10)
                Rectangle().foregroundColor(.orange).frame(minWidth: 20)
                Rectangle().foregroundColor(.yellow).frame(minWidth: 30)
                Rectangle().foregroundColor(.green).frame(minWidth: 40)
                Rectangle().foregroundColor(.blue).frame(minWidth: 50)
                Rectangle().foregroundColor(.purple).frame(minWidth: 60)
                Rectangle().foregroundColor(.pink).frame(maxWidth: 70)
            }
        }
    }
}

PlaygroundPage.current.setLiveView(Example())
