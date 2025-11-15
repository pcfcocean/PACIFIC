//
//  ViewController.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import UIKit

class LIFE_ViewController: UIViewController {
    // MARK: - Private UI properties
    let lifeView = LIFE_View()

    // MARK: - Init

    init() {
        print("init [UIViewController]")
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit [UIViewController]")
    }

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()
        print("loadView [UIViewController]")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad [UIViewController]")
        addSubviews()
        makeConstraints()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("\n", "-> lifeView.removeFromSuperview", "\n")
            self.lifeView.removeFromSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print("\n", "-> lifeView addSubviews + makeConstraints", "\n")
            self.addSubviews()
            self.makeConstraints()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            print("\n", "-> lifeView remakeConstraints", "\n")
            self.remakeConstraints()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            print("\n", "-> lifeView.frame = CGRect(x: 40, y: 40, width: 200, height: 200)", "\n")
            self.lifeView.frame = CGRect(x: 40, y: 40, width: 200, height: 200)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear [UIViewController]")
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewIsAppearing [UIViewController]")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews [UIViewController]")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews [UIViewController]")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear [UIViewController]")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear [UIViewController]")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear [UIViewController]")
    }

    // MARK: - Private methods

    private func addSubviews() {
        print("ENTER view.addSubview(lifeView)")
        view.addSubview(lifeView)
        print("LEAVE view.addSubview(lifeView)")
    }

    private func makeConstraints() {
        print("ENTER makeConstraints")
        lifeView.translatesAutoresizingMaskIntoConstraints = false
        lifeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lifeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lifeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lifeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        print("LEAVE makeConstraints")
    }

    private func remakeConstraints() {
        print("ENTER remakeConstraints")
        lifeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lifeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lifeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lifeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        print("LEAVE remakeConstraints")
    }
}
