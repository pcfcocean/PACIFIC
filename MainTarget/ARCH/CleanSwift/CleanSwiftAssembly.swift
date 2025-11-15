//
//  CleanSwiftAssembly.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import UIKit

enum CleanSwiftAssembly {
    static func build(config: CleanSwift.Config) -> UIViewController {
        let worker: CleanSwiftWorkerLogic = CleanSwiftWorker()
        let presenter = CleanSwiftPresenter()
        let interactor = CleanSwiftInteractor(
            config: config,
            presenter: presenter,
            worker: worker
        )
        let router = CleanSwiftRouter(dataStore: interactor)
        let viewController = CleanSwiftViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
