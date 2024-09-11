//
//  MVVM_ViewModel.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 25.08.24.
//

import Foundation

protocol MVVM_ViewModel_2_Logic {
    func buttonDidTap()
}

class MVVM_ViewModel_2 {
    weak var view: MVVM_ViewController_2_Logic?
    private weak var output: MVVM_Module_2_Output?

    init(output: MVVM_Module_2_Output?) {
        self.output = output
    }
}

extension MVVM_ViewModel_2: MVVM_ViewModel_2_Logic {
    func buttonDidTap() {
    }
}
