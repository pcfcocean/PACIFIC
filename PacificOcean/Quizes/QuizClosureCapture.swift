//
//  QuizClosureCapture.swift
//  Scramdinger
//
//  Created by Vlad Lesnichiy on 13.09.24.
//

import UIKit

class UIView1: UIView {}
class UIView2: UIView {}


class QuizClosureCapture {
    var closure: (() -> Void)?

    init() {
        test()
        test2()
        doSomething ()
        closure?()
    }
    
    private func test() {
        var view: UIView = UIView1()
        view.tag = 1
        let closure = { [view] in
            print(view.tag)
        }
        view.tag = 2
        
        view = UIView2()
        
        view.tag = 3
        
        closure()
    }

    private func test2() {
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.global().sync {
                print("2")
            }
            DispatchQueue.global().async {
                print("3")
            }
            print("4")
        }
    }
    
    func doSomething() {
        var v = 5
        closure = {
            print(v)
        }
        v = 10
    }
}
