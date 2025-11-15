//
//  TypeErasure.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 23.06.24.
//

import Foundation

protocol ProtocolWithAssociatedType {
    associatedtype Element
    func f(_ element: Element)
}

struct One: ProtocolWithAssociatedType {
    typealias Element = Int

    func f(_ element: Element) {
        print(element)
    }
}

struct Two: ProtocolWithAssociatedType {
    typealias Element = Double

    func f(_ element: Element) {
        print(element)
    }
}

class AnyProtocolWarpper {
    private let _f: (Any) -> Void

    init<EraseType: ProtocolWithAssociatedType>(wrapped: EraseType) {
        _f = { element in
            guard let element = element as? EraseType.Element else { fatalError("Incorrect type") }
            wrapped.f(element)
        }
    }

    func f(_ element: Any) {
        _f(element)
    }
}

//struct TypeErasure {
//    let one = One()
//    let two = Two()
//    func f() {
//        let arr: [ProtocolWithAssociatedType] = [one, two]
//        arr[0].f(10)
//    }
//}

struct TypeErasure {
    init() {
        let one = AnyProtocolWarpper(wrapped: One())
        let two = AnyProtocolWarpper(wrapped: Two())
        let arr: [AnyProtocolWarpper] = [one, two]
        arr[0].f(10)
        arr[1].f(10.10)
    }
}


