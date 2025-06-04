//
//  Representable.swift
//  HostingApp
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit
import SwiftUI

extension UIView {
    var representable: some View { RepresentableView(wrapped: self) }
}

struct RepresentableView: UIViewRepresentable {
    let wrapped: UIView

    func makeUIView(context: Context) -> UIView {
        return wrapped
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIViewController {
    var representable: AnyView { AnyView(RepresentableScreenView(wrapped: self)) }
}

struct RepresentableScreenView: UIViewControllerRepresentable {
    let wrapped: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return wrapped
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
