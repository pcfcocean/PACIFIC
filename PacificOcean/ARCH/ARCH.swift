//
//  ARCH.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 17.08.24.
//

import UIKit

enum ARCH {
    case lifeCycle
    case mvc
    case viper
    case cleanSwift

    var viewController: UIViewController {
        switch self {
        case .lifeCycle:
            return LIFE_ViewController()
        case .mvc:
            return MVC_ViewController()
        case .viper:
            return VIPER_Assembly.build()
        case .cleanSwift:
            return  CleanSwiftAssembly.build(config: CleanSwift.Config(initialData: nil))
        }
    }
}
