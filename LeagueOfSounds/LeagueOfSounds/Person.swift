//
//  Person.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/14/21.
//

import Foundation
import SwiftUI

class Parent: ObservableObject {
    @Published var children = [Child()]
}

class Child: ObservableObject {
    @Published var name: String?

    func loadName() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Async task here...
            self.name = "Loaded name"
        }
    }
}

struct FirstChildView: View {
    @ObservedObject var child: Child
    var body: some View {
        Text(child.name ?? "null")
            .onTapGesture {
                self.child.loadName()
            }
    }
}

struct ParentContentView: View {
    @ObservedObject var parent = Parent()

    var body: some View {
        // just for demo, in real might be conditional or other UI design
        // when no child is yet available
        FirstChildView(child: parent.children.first ?? Child())
    }
}
