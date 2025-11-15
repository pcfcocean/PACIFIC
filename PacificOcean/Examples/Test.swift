//
//  Test.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 4.04.24.
//

import Foundation

class Test {
    var completion: (() -> Void)?

    init() {}

    func test() {
        completion = { [weak self] in
            print("+375447212371")
            self?.completion = nil
        }
        completion?()
        completion?()
    }

    func test2() {
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.global().sync {
                print("2")
                DispatchQueue.global().async {
                    print("3")
                }
                print("4")
            }
            print("5")
        }
    }

    func test3() {
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.global().async {
                print("2")
                DispatchQueue.global().async {
                    print("3")
                }
                print("4")
            }
            print("5")
        }
    }

    func test4() {
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.global().async {
                print("2")
                DispatchQueue.global().sync {
                    print("3")
                }
                print("4")
            }
            print("5")
        }
    }

    func test5() {
        print("1")
        DispatchQueue.global().async {
            print("2")
        }
        DispatchQueue.global().sync {
            print("3")
        }
        print("4")
    }

    func test6() {
        DispatchQueue.global().sync {
            print("1")
            DispatchQueue.global().async {
                print("2")
            }
            DispatchQueue.global().sync {
                print("3")
            }
            DispatchQueue.global().async {
                print("4")
            }
            print("5")
        }
        var dog = Dog()
        dog.name = "Lucy"

        print(dog.name)
    }
}

protocol Animal {
    var name: String { get }
}

struct Dog: Animal {
    var name: String = "Charlie"
}
