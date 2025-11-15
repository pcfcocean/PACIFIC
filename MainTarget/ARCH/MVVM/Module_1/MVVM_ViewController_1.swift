//
//  MVVM_ViewController.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 25.08.24.
//

import UIKit

protocol MVVM_ViewController_1_Logic: AnyObject {
}

class MVVM_ViewController_1: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let buttonTopOffset: CGFloat = 20
    }
    // MARK: - Private properties
    private let viewModel: MVVM_ViewModel_1

    // MARK: - Private UI elements
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Вперед", for: .normal)
        return button.prepareForAutoLayout()
    }()

    // MARK: - Init
    init(viewModel: MVVM_ViewModel_1) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Private methods
    private func configureView() {
        addSubviews()
        makeConstraints()
        setupActions()
    }

    private func addSubviews() {
        view.addSubview(button)
    }

    private func makeConstraints() {
        button.pinToCenterSuperview(yOffset: Constants.buttonTopOffset)
    }

    private func setupActions() {
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }

    @objc private func buttonDidTap() {
        viewModel.buttonDidTap()
    }

}

extension MVVM_ViewController_1: MVVM_ViewController_1_Logic {

}
