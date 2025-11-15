//
//  DelegateCompletion.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 20.08.24.
//

import UIKit

class DelegateCompletionViewController: UIViewController, ProtocolDelegate {
    let customView = View()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        customView.delegate = self

        customView.completion = {
            print("Отработал комплишн")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.customView.changeBackgroundToBlue()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.customView.changeBackgroundToOrange()
        }
    }

    // MARK: - ProtocolDelegate
    func backgroundDidChange() {
        print("Отработал метод делегата")
    }
}

class View: UIView {

    var delegate: ProtocolDelegate?

    var completion: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeBackgroundToBlue() {
        backgroundColor = .blue
        delegate?.backgroundDidChange()
    }

    func changeBackgroundToOrange() {
        backgroundColor = .orange
        completion?()
    }
}

import Foundation

protocol ProtocolDelegate {
    func backgroundDidChange()
}
