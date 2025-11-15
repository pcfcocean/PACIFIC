//
//  OnlyDigits.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 5.07.24.
//

import Foundation

struct OnlyDigits {
    init() {
        let stringToTrim = "+12345678910"
        let cardtrim = stringToTrim.trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
        print(cardtrim)
    }
}
