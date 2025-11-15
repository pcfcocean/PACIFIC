//
//  ClassDeinit.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 23.08.24.
//

import Foundation

class A {
    deinit {
        print("a")
    }
}

class B {
    let a = A()
    deinit {
        print("b")
    }
}

class C: A {
    let b = B()
    deinit {
        print("c")
    }
}

class ClassIneritence {
    var c: C? = C()

    init() {
        execute()
    }

    private func execute() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.c = nil
        }
    }
}
