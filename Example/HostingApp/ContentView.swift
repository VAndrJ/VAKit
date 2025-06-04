//
//  ContentView.swift
//  HostingApp
//
//  Created by VAndrJ on 5/21/25.
//

import SwiftUI
import VAKit

enum Destination {
    case constraintsDSL
}

struct ContentView: View {
    @State private var path: [Destination] = []

    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink("ConstraintsDSL", value: Destination.constraintsDSL)
            }
            .navigationTitle("Examples")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .constraintsDSL:
                    ConstraintsDSLExampleView().embeddedInController.representable
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
