//
//  Combine_1.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 26.10.24.
//

import Foundation
import Combine

// Combine Основные понятия
// https://www.youtube.com/watch?v=KQHKEETteQw&list=PLtUCU7XGn_c4Fg6P6isW-c8ePR99V1N_W&index=1&pp=iAQB

/// Publisher<Output, Failure>
///            ||                 ||               типы данных должны совпадать
/// Subscriber<Input, Failure>

class Combine_1 {
    // Data
    let singleData = "Combiner"
    var data = ["One", "Two", "Three"]

    init() {
        execte()
        execte_2()
        execte_3()
    }

    func execte() {
        // Publisher
        let simplePublisher: Just<String> = Just(singleData)
        let sequancePublisher: Publishers.Sequence<[String], Never> = data.publisher

        // Subscriber
        simplePublisher.sink { value in
            print("Value of simplePublisher:", value)
        }

        sequancePublisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("sequancePublisher finished")
                case .failure(let failure):
                    print("sequancePublisher failure", failure)
                }

            }, receiveValue: { value in
                print("Value of sequancePublisher:", value)
            }
        )

        data.append("Four")
    }

    func execte_2() {
        class User {
            var name: String
            init (name: String) {
                self.name = name
            }
        }
        let singleData = "Combiner-2"
        let user = User(name: "Empty")
        let simplePublisher_2: Just<String> = Just(singleData)
        simplePublisher_2.assign(to: \User.name, on: user)
        print (user.name)
        user.name = "Delta"
        print (user.name)
    }

    func execte_3() {
        // Subscription
        class Network {
            let requestComplete: PassthroughSubject<String, Never> = .init()
            func send() {
                // some work and request
                requestComplete.send("Complete")
            }
        }

        class ViewModel {
            let network = Network()
            let subscription: AnyCancellable
            var subscriptions: Set<AnyCancellable> = []

            init() {
                subscription = network.requestComplete.sink(
                    receiveValue: { result in
                        print("Request result:", result)
                    }
                )
                network.requestComplete.sink(
                    receiveValue: { result in
                        print("Request result:", result)
                    }
                ).store(in: &subscriptions)
            }

            func requestSometihing() {
                network.send()
            }
        }

        let viewModel = ViewModel()
        viewModel.requestSometihing()
        viewModel.requestSometihing()
        viewModel.requestSometihing()
        print("Finish execte_3")
    }

}
