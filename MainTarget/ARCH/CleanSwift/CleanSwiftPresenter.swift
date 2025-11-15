//
//  CleanSwiftPresenter.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import Foundation

final class CleanSwiftPresenter: CleanSwiftPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        // Преобразование секунд в формат "00:45"
        static let formattedTime: (Int) -> (String) = {
            let minutes = String(format: "%02d", $0 / 60)
            let seconds = String(format: "%02d", $0 % 60)
            return "\(minutes):\(seconds)"
        }
    }

    // MARK: - Internal properties
    weak var view: CleanSwiftDisplayLogic?

    // MARK: - CleanSwiftPresentationLogic
    func presentInitForm(_ response: CleanSwift.InitForm.Response) {
        let formattedTimeLeft: String = Constants.formattedTime(response.timeLeft)
        let buttonTitle: String = "Timer: \(formattedTimeLeft)"
        let viewModel = CleanSwift.InitForm.ViewModel(buttonTitle: buttonTitle)
        view?.displayInitForm(viewModel)
    }

    func presentButtonDidTap(_ response: CleanSwift.ButtonDidTap.Response) {
        view?.displayButtonDidTap(CleanSwift.ButtonDidTap.ViewModel())
    }

    func presentTimer(_ response: CleanSwift.Timer.Response) {
        switch response.timerCondition {
        case .time(let seconds):
            let title = "Осталось: \(Constants.formattedTime(seconds))"
            view?.displayTimer(CleanSwift.Timer.ViewModel(buttonTitle: title, buttonIsEnabled: false))
        case .timeOver:
            let title = "Время вышло. Повторите запрос"
            view?.displayTimer(CleanSwift.Timer.ViewModel(buttonTitle: title, buttonIsEnabled: true))
        }
    }

    func presentAlertForm(_ response: CleanSwift.AlertForm.Response) {
        response.alert?.title = "Title"
        response.alert?.firstAction?.title = "Ok"
        response.alert?.firstAction?.style = .default
        view?.displayAlertForm(CleanSwift.AlertForm.ViewModel())
    }
}
