//
//  MASK.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 5.02.24.
//

import Foundation

struct MASK {
    private enum Constants {
        static let maskedData: (String) -> (String) = { "•••\($0.suffix(2))" }
        static let formattedPhoneNumber: (String) -> (String) = { data in
            var formattedPhoneNumber: String = ""
            data.enumerated().forEach { (index, character) in
                guard
                    index == 0 || index == 1 || index == data.count - 1 || index == data.count - 2
                else {
                    formattedPhoneNumber.append("•")
                    return
                }
                formattedPhoneNumber.append(character)
            }
            return formattedPhoneNumber
        }
        static let format4: (String) -> (String) = { phoneNumber in
            guard phoneNumber.count > 4 else { return phoneNumber }
                let prefix = "\(phoneNumber.prefix(2))"
                let suffix = "\(phoneNumber.suffix(2))"
                let middlePart = String(repeating: "•", count: phoneNumber.count - 4)
                return "\(prefix) \(middlePart) \(suffix)"
        }
    }

    init() {
        print(Constants.format4("+375447212371"))
        print(Constants.format4("371"))
        print(Constants.format4("3719"))
        print(Constants.format4("37109"))
        print(Constants.format4("37109"))
        print(Constants.format4("3"))
        
    }
}
