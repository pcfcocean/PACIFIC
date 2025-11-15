//
//  MVC_Model.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 23.06.24.
//

import Foundation

final class MVC_Model {
    // MARK: - Nested types
    enum TimerCondition {
        case time(Int)
        case timeOver
    }

    // MARK: - Constants
    private enum Constants {
        static var initTimerDuration = 1
    }

    // MARK: - Private properties
    private var timer: Timer?
    private var timeLeft: Int = Constants.initTimerDuration

    // MARK: - Init
    init() {}

    // MARK: - Model methods
    func launchTimer(completion: @escaping (TimerCondition) -> Void) {
        timer?.invalidate()
        timer = nil
        timeLeft = Constants.initTimerDuration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            guard self.timeLeft > 0 else {
                timer.invalidate()
                completion(.timeOver)
                return
            }
            self.timeLeft -= 1
            completion(.time(self.timeLeft))
        }
    }
}
