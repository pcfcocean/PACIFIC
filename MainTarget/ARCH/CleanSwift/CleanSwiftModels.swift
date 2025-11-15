//
//  CleanSwiftModels.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import UIKit

enum CleanSwift {
    struct Config {
        let initialData: Data?
    }

    enum InitForm {
        struct Request {}
        struct Response {
            let timeLeft: Int
        }
        struct ViewModel {
            let buttonTitle: String?
        }
    }

    enum Timer {
        struct Request {}
        struct Response {
            let timerCondition: Condition
        }
        struct ViewModel {
            let buttonTitle: String
            let buttonIsEnabled: Bool
        }
    }

    enum ButtonDidTap {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum AlertForm {
        struct Request {}
        struct Response {
            let alert: AlertModel?
        }
        struct ViewModel {}
    }

    class AlertModel {
        struct Action {
            var title: String?
            var style: UIAlertAction.Style?
            let completion: (() -> Void)?
        }
        var title: String?
        var message: String?
        var firstAction: Action?
        var secondAction: Action?
    }

    enum Condition {
        case time(Int)
        case timeOver
    }
}
