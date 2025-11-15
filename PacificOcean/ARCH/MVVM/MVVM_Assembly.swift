//
//  MVVM_Assembly.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 26.08.24.
//

import UIKit

class MVVM_Assembly {
    func build_module_1(output: MVVM_Module_1_Output) -> UIViewController {
        let viewModel = MVVM_ViewModel_1(output: output)
        let viewController = MVVM_ViewController_1(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }

    func build_module_2(output: MVVM_Module_2_Output) -> UIViewController {
        let viewModel = MVVM_ViewModel_2(output: output)
        let viewController = MVVM_ViewController_2(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}
