//
//  DispatchTest.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 22.03.24.
//

import Foundation

class Apple {
}

class AppleObject: Apple {
    override func eat() {
        print("eat apple obj")
    }
}

extension Apple {
    @objc func eat() {
       print("eat extension")
    }
}

/*
 Ошибка "Non-@objc instance method 'eat()' is declared in extension of 'Apple' and cannot be overridden" возникает из-за того, что метод eat объявлен в расширении класса Apple, который не помечен атрибутом @objc. В Swift методы, объявленные в расширениях классов, по умолчанию не являются доступными для Objective-C и не могут быть переопределены в подклассах.

 Чтобы решить эту проблему, вы можете добавить атрибут @objc к методу eat в расширении класса Apple
 */
