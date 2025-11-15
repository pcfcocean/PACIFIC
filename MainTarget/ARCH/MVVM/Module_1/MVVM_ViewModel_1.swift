//
//  MVVM_ViewModel.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 25.08.24.
//

import Foundation

protocol MVVM_ViewModel_1_Logic {
    func buttonDidTap()
}

class MVVM_ViewModel_1 {
    weak var view: MVVM_ViewController_1_Logic?
    private weak var output: MVVM_Module_1_Output?

    init(output: MVVM_Module_1_Output?) {
        self.output = output
    }
}

extension MVVM_ViewModel_1: MVVM_ViewModel_1_Logic {
    func buttonDidTap() {
        output?.showModule2()
    }
}
