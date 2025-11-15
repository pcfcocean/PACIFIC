//
//  CLEANSWIFT.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 1.07.24.
//

import UIKit

protocol CSBusinessLogic {
    func requestInitForm(_ request: CS.VIP.Request)
}
protocol CSPresentationLogic {
    func presentInitForm(_ response: CS.VIP.Response)
}
protocol CSDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CS.VIP.ViewModel)
}
protocol CSRoutingLogic {
    func routeTo()
}
protocol CSDataStore {
    var data: Data? { get }
}

enum CS {
    enum VIP {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}

enum CSAssembly {
    static func build() -> UIViewController {
        let presenter = CSPresenter()
        let interactor = CSInteractor(presenter: presenter)
        let router = CSRouter(dataStore: interactor)
        let viewController = CSViewController(interactor: interactor, router: router)
        presenter.view = viewController
        router.viewController = viewController
        return viewController
    }
}



final class CSInteractor: CSBusinessLogic, CSDataStore {
    private let presenter: CSPresentationLogic
    private(set) var data: Data?
    init(presenter: CSPresentationLogic) {
        self.presenter = presenter
    }
    func requestInitForm(_ request: CS.VIP.Request) {
        presenter.presentInitForm(CS.VIP.Response())
    }
}

final class CSPresenter: CSPresentationLogic {
    weak var view: CSDisplayLogic?
    func presentInitForm(_ response: CS.VIP.Response) {
        view?.displayInitForm(CS.VIP.ViewModel())
    }
}

final class CSRouter: CSRoutingLogic {
    weak var viewController: UIViewController?
    private let dataStore: CSDataStore
    init(dataStore: CSDataStore) {
        self.dataStore = dataStore
    }
    func routeTo() {}
}


final class CSViewController: UIViewController, CSDisplayLogic {
    private let interactor: CSBusinessLogic
    private let router: CSRoutingLogic
    init(interactor: CSBusinessLogic, router: CSRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func displayInitForm(_ viewModel: CS.VIP.ViewModel) {}
}

