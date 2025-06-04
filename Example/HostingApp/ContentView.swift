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
    case layerAnimations
}

struct ContentView: View {
    @State private var path: [Destination] = []

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("UIKit") {
                    NavigationLink("Constraints DSL", value: Destination.constraintsDSL)
                    NavigationLink("Layer Animations", value: Destination.layerAnimations)
                }
            }
            .navigationTitle("Examples")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .constraintsDSL:
                    ConstraintsDSLExampleView().embeddedInController.representable
                case .layerAnimations:
                    CALayerAnimationsExamplesView().embeddedInController.representable
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
