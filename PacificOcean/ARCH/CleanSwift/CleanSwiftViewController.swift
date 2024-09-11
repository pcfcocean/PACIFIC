//
//  CleanSwiftViewController.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 25.03.24.
//

import UIKit

final class CleanSwiftViewController: UIViewController, CleanSwiftDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let buttonTopOffset: CGFloat = 20
    }
    // MARK: - Private properties
    private let interactor: CleanSwiftBusinessLogic
    private let router: CleanSwiftRoutingLogic

    // MARK: - Private UI elements
    private let label: UILabel = {
        let label = UILabel()
        label.text = "CleanSwiftViewController"
        label.numberOfLines = .zero
        return label.prepareForAutoLayout()
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить цвет бекграунда", for: .normal)
        return button.prepareForAutoLayout()
    }()

    // MARK: - Init
    init(interactor: CleanSwiftBusinessLogic, router: CleanSwiftRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        interactor.requestInitForm(CleanSwift.InitForm.Request())
    }

    // MARK: - Private methods
    private func configureNavigationBar() {
        navigationItem.leftItemsSupplementBackButton = true
    }

    private func configureView() {
        addSubviews()
        makeConstraints()
        setupActions()
    }

    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(button)
    }

    private func makeConstraints() {
        label.pinToCenterSuperview()
        button.topAnchor ~= label.bottomAnchor + Constants.buttonTopOffset
    }

    private func setupActions() {
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }

    @objc private func buttonDidTap() {
        interactor.requestButtonDidTap(CleanSwift.ButtonDidTap.Request())
    }

    // MARK: - CleanSwiftDisplayLogic
    func displayInitForm(_ viewModel: CleanSwift.InitForm.ViewModel) {
        button.setTitle(viewModel.buttonTitle, for: .normal)
        interactor.requestTimer(CleanSwift.Timer.Request())
    }

    func displayButtonDidTap(_ viewModel: CleanSwift.ButtonDidTap.ViewModel) {
        label.backgroundColor = UIColor(
            red: .random(in: (0 ... 1)),
            green: .random(in: (0 ... 1)),
            blue: .random(in: (0 ... 1)),
            alpha: .random(in: (0 ... 1))
        )
    }

    func displayTimer(_ viewModel: CleanSwift.Timer.ViewModel) {
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.isEnabled = viewModel.buttonIsEnabled
    }

    func displayAlertForm(_ viewModel: CleanSwift.AlertForm.ViewModel) {
        router.routeToAlert()
    }
}
