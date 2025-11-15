//
//  MVVM_IO_2.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 27.08.24.
//

import Foundation

//MARK: - Для передачи из координатора в модули
protocol MVVM_Module_1_Input: AnyObject {}

//MARK: - Для передачи из модулей в координатор
protocol MVVM_Module_1_Output: AnyObject {
    func showModule2()
}
