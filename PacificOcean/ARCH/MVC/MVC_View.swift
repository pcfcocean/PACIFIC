//
//  MVC_View.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 23.06.24.
//

import UIKit

public final class MVC_View: UIView {
    // MARK: - Constants
    private enum Constants {
        static let stackViewSpacing: CGFloat = 10
        static let imageSize: CGSize = CGSize(width: 24, height: 24)
    }

    // MARK: - Public properties
    public var title: String? {
        get { button.titleLabel?.text }
        set { button.setTitle(newValue, for: .normal) }
    }

    public var leftImage: UIImage? {
        get { leftImageView.image }
        set {
            leftImageView.image = newValue
            leftImageView.isHidden = newValue == nil
        }
    }

    // MARK: - Public callback
    public var didTap: (() -> Void)?

    // MARK: - Private UIViews
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor ~= Constants.imageSize.height
        imageView.widthAnchor ~= Constants.imageSize.width
        imageView.isHidden = true
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()

    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        setupGestures()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func addSubviews() {
        addSubview(container)
        container.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(leftImageView)
        horizontalStackView.addArrangedSubview(button)
    }

    private func makeConstraints() {
        container.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .horizontal)
    }

    private func setupGestures() {
        isUserInteractionEnabled = true
        button.isUserInteractionEnabled = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAction))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func didTapAction() {
        didTap?()
    }
}
