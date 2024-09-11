//
//  ViewController1.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 5.01.24.
//

import UIKit

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        afterBlock(second: 2, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
//
//        afterBlock(second: 4, queue: .main) { [weak self] in
//            self?.showAlert()
//            print(Thread.current)
//        }
//
//        afterBlock(second: 6, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
    }

    func afterBlock(second: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> ()) {
        queue.asyncAfter(deadline: .now() + .seconds(second)) {
            completion()
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
