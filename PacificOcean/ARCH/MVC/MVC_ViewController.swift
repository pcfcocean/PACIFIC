//
//  MVC_ViewController.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 23.06.24.
//

import UIKit
import AudioToolbox
import UserNotifications


final class MVC_ViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        // Преобразование секунд в формат "00:45"
        static let formattedTime: (Int) -> (String) = {
            let minutes = String(format: "%02d", $0 / 60)
            let seconds = String(format: "%02d", $0 % 60)
            return "\(minutes):\(seconds)"
        }
    }
    // MARK: - Private properties
    private let mvcView: MVC_View
    private let mvcModel: MVC_Model

    // MARK: - Init
    init() {
        self.mvcModel = MVC_Model()
        self.mvcView = MVC_View()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func loadView() {
        view = self.mvcView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupActions()
        initForm()
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.leftItemsSupplementBackButton = true
    }

    private func setupActions() {
        mvcView.didTap = { [weak self] in
            AudioServicesPlaySystemSound(SystemSoundID(1003))
            self?.mvcView.leftImage = UIImage(systemName: "plus")
        }
    }

    private func initForm() {
        mvcView.title = "Timer"
        mvcModel.launchTimer { [weak self] timerCondition in
            switch timerCondition {
            case .time(let secondsLeft):
                self?.mvcView.title = "Осталось: \(Constants.formattedTime(secondsLeft))"
            case .timeOver:
                self?.mvcView.title = "Время вышло. Повторите запрос"
            }
        }
    }
}
