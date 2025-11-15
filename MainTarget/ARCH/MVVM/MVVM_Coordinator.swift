//
//  MVVM_Coordinator.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 26.08.24.
//

import UIKit

class MVVM_Coordinator {

    private let assembly: MVVM_Assembly
    private var navigationController: UINavigationController?

    init(assembly: MVVM_Assembly) {
        self.assembly = assembly
    }

    func start(window: UIWindow) {
        let viewController = assembly.build_module_1(output: self)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension MVVM_Coordinator: MVVM_Module_1_Output {
    func showModule2() {
        let module2 = assembly.build_module_2(output: self)
        navigationController?.pushViewController(module2, animated: true)
    }
}

extension MVVM_Coordinator: MVVM_Module_2_Output {}
