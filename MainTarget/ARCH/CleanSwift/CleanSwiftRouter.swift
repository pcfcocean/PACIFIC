//
//  CleanSwiftRouter.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import UIKit

final class CleanSwiftRouter: CleanSwiftRoutingLogic {
    weak var viewController: UIViewController?
    private let dataStore: CleanSwiftDataStore

    init(dataStore: CleanSwiftDataStore) {
        self.dataStore = dataStore
    }

    func routeToClose() {
    }

    func routeToAlert() {
        guard let alert: CleanSwift.AlertModel = dataStore.alert else { return }
        let alertViewController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        if let firstAction: CleanSwift.AlertModel.Action = alert.firstAction {
            alertViewController.addAction(
                UIAlertAction(
                    title: firstAction.title,
                    style: firstAction.style ?? .default,
                    handler: { _ in
                        firstAction.completion?()
                    }
                )
            )
        }
        if let secondAction: CleanSwift.AlertModel.Action = alert.secondAction {
            alertViewController.addAction(
                UIAlertAction(
                    title: secondAction.title,
                    style: secondAction.style ?? .default,
                    handler: { _ in
                        secondAction.completion?()
                    }
                )
            )
        }
        viewController?.present(alertViewController, animated: true)
    }
}
