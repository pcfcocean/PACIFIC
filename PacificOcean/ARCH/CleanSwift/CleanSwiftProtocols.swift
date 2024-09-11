//
//  CleanSwiftProtocols.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import Foundation

protocol CleanSwiftDataStore {
    /// Модель алерта
    var alert: CleanSwift.AlertModel? { get }
}

protocol CleanSwiftBusinessLogic {
    func requestInitForm(_ request: CleanSwift.InitForm.Request)
    func requestButtonDidTap(_ request: CleanSwift.ButtonDidTap.Request)
    func requestTimer(_ request: CleanSwift.Timer.Request)
}

protocol CleanSwiftPresentationLogic {
    func presentInitForm(_ response: CleanSwift.InitForm.Response)
    func presentButtonDidTap(_ response: CleanSwift.ButtonDidTap.Response)
    func presentTimer(_ response: CleanSwift.Timer.Response)
    func presentAlertForm(_ response: CleanSwift.AlertForm.Response)
}

protocol CleanSwiftDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CleanSwift.InitForm.ViewModel)
    func displayButtonDidTap(_ viewModel: CleanSwift.ButtonDidTap.ViewModel)
    func displayTimer(_ viewModel: CleanSwift.Timer.ViewModel)
    func displayAlertForm(_ viewModel: CleanSwift.AlertForm.ViewModel)
}

protocol CleanSwiftRoutingLogic {
    func routeToClose()
    func routeToAlert()
}

protocol CleanSwiftWorkerLogic {}
