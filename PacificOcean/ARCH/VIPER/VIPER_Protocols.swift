//
//  VIPER_Protocols.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 17.08.24.
//

import Foundation

protocol VIPER_ViewControllerLogic: AnyObject {
    // Define methods for updating the view
}

protocol VIPER_InteractorLogic: AnyObject {
    // Define methods for business logic
}

protocol VIPER_PresenterLogic: AnyObject {
    // Define methods for updating the view and handling user input
}

protocol VIPER_RouterLogic: AnyObject {
    // Define navigation methods
}

protocol VIPER_WorkerLogic: AnyObject {
    // Define separated logic
}
