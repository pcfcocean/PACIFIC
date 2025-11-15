//
//  CleanSwiftInteractor.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import Foundation

final class CleanSwiftInteractor: CleanSwiftBusinessLogic, CleanSwiftDataStore {
    // MARK: - Constants
    private enum Constants {
        static var initTimerDuration = 10
    }

    // MARK: - CleanSwiftDataStore properties
    private(set) var alert: CleanSwift.AlertModel?

    // MARK: - Private properties
    private let presenter: CleanSwiftPresentationLogic
    private let worker: CleanSwiftWorkerLogic
    private var config: CleanSwift.Config

    private var timer: Timer?
    private var timeLeft: Int = Constants.initTimerDuration

    // MARK: - Init
    init(
        config: CleanSwift.Config,
        presenter: CleanSwiftPresentationLogic,
        worker: CleanSwiftWorkerLogic
    ) {
        self.config = config
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - CleanSwiftDataStore methods
    func requestInitForm(_ request: CleanSwift.InitForm.Request) {
        presenter.presentInitForm(CleanSwift.InitForm.Response(timeLeft: Constants.initTimerDuration))
    }

    func requestButtonDidTap(_ request: CleanSwift.ButtonDidTap.Request) {
        presenter.presentButtonDidTap(CleanSwift.ButtonDidTap.Response())
    }

    func requestTimer(_ request: CleanSwift.Timer.Request) {
        timer?.invalidate()
        timer = nil
        timeLeft = Constants.initTimerDuration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            guard self.timeLeft > 0 else {
                timer.invalidate()
                self.presenter.presentTimer(CleanSwift.Timer.Response(timerCondition: .timeOver))
                return
            }
            self.timeLeft -= 1
            self.presenter.presentTimer(CleanSwift.Timer.Response(timerCondition: .time(self.timeLeft)))
        }
    }
}
