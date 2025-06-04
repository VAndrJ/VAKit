//
//  ScreenView.swift
//  HostingApp
//
//  Created by VAndrJ on 6/4/25.
//

import UIKit
import VAKit

protocol ScreenView: UIView {

    func didLoad()
    func willAppear(_ animated: Bool)
    func didAppear(_ animated: Bool)
    func willDisappear(_ animated: Bool)
    func didDisappear(_ animated: Bool)
}

extension ScreenView {
    var embeddedInController: UIViewController { ScreenViewController(contentView: self) }
}

class VAScreenView: VAView, ScreenView {

    func didLoad() {}
    func willAppear(_ animated: Bool) {}
    func didAppear(_ animated: Bool) {}
    func willDisappear(_ animated: Bool) {}
    func didDisappear(_ animated: Bool) {}

    #if DEBUG
    deinit {
        print(#function, Self.self)
    }
    #endif
}

class ScreenViewController<ContentView: ScreenView>: UIViewController {
    let contentView: ContentView

    init(contentView: ContentView) {
        self.contentView = contentView

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contentView.willAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        contentView.didAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        contentView.willDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        contentView.didDisappear(animated)
    }

    #if DEBUG
    deinit {
        print(#function, Self.self)
    }
    #endif
}
