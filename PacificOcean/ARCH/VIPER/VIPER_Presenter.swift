//
//  VIPER_Presenter.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 17.08.24.
//

import Foundation

class VIPER_Presenter: VIPER_PresenterLogic {
    weak var view: VIPER_ViewControllerLogic?

    // MARK: - Private properties
    private let interactor: VIPER_InteractorLogic
    private let router: VIPER_RouterLogic

    init(view: (any VIPER_ViewControllerLogic)?, interactor: any VIPER_InteractorLogic, router: any VIPER_RouterLogic) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - VIPER_PresenterLogic
}
