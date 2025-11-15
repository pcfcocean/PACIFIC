//
//  LIFE_View.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 15.08.24.
//

import UIKit

final class LIFE_View: UIView {
    // MARK: - Private UI properties
    let life: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    // MARK: - Init

    public init() {
        print (" init [UIView]")
        super.init(frame: .zero)
        backgroundColor = .gray
        addSubview()
        makeConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // Вызывается, когда view собирается быть добавленным или удаленным из superview
        if newSuperview != nil {
            print(" willMove(toSuperview - UIView собирается быть добавленным к superview [UIView]")
        } else {
            print(" willMove(toSuperview - UIView собирается быть удаленным из superview  [UIView]")
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // Вызывается, когда view было добавлено или удалено из его superview.
        if superview != nil {
            print(" didMoveToSuperview - UIView было добавлено к superview [UIView]")
        } else {
            print(" didMoveToSuperview - UIView было удалено из его superview [UIView]")
        }
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        // Вызывается, когда view было добавлен или удалено из window
        if window != nil {
            print(" didMoveToWindow - UIView было добавлено в window [UIView]")
        } else {
            print(" didMoveToWindow - UIView было удалено из window [UIView]")
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print(" layoutSubviews [UIView]")
        // Вызывается при изменении frame или constraint view
        // Здесь выполняются задачи, связанные с layout, такие как обновление frame или constraints
    }

    override func removeFromSuperview() {
        // Perform cleanup tasks here
        // Remove any observers, release resources, etc.
        super.removeFromSuperview()
        print(" removeFromSuperview [UIView]")
    }

    override func updateConstraints() {
        super.updateConstraints()
        print(" updateConstraints [UIView]")
    }

    override func draw(_ rect: CGRect) {
        print(" draw [UIView]", rect)
//        super.draw(rect)
        // Called to draw the view's content
        // Perform custom drawing here using Core Graphics or other drawing APIs
    }

    // MARK: - Private methods

    private func addSubview() {
        print(" -> ENTER addSubview")
        addSubview(life)
        print(" -> LEAVE addSubview")
    }

    private func makeConstraints() {
        print(" -> ENTER makeConstraints")
        life.translatesAutoresizingMaskIntoConstraints = false
        life.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        life.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        life.widthAnchor.constraint(equalToConstant: 50).isActive = true
        life.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(" -> LEAVE makeConstraints")
    }
}
