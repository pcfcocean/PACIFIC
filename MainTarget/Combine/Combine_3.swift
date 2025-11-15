//
//  Combine_3.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 27.10.24.
//

import Foundation
import Combine

// Combine. Custom Publishers
// https://www.youtube.com/watch?v=2yyaZzQrpyk&list=PLtUCU7XGn_c4Fg6P6isW-c8ePR99V1N_W&index=3

struct FibonacciPublisher: Publisher {
    typealias Output = Int

    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FibanachiSubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

// 0, 1, 1, 2, 3,5
class FibanachiSubscription<S: Subscriber>: Subscription where S.Input == Int {
    private var subscriber: S?

    init(subscriber: S) {
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        print("Demand ", demand)
        guard demand > .none else {
            subscriber?.receive(completion: .finished)
            return
        }

        var count = demand
        count -= .max(1)
        subscriber?.receive(0)

        if count == .none {
            subscriber?.receive(completion: .finished)
            return
        }

        count -= .max(1)
        subscriber?.receive(1)

        if count == .none {
            subscriber?.receive(completion: .finished)
            return
        }

        var prev = 0
        var current = 1
        var temp: Int

        while true {
            temp = prev
            prev = current
            current += temp
            subscriber?.receive(current)
            count -= .max(1)
            if count == .none {
                subscriber?.receive(completion: .finished)
                return
            }
        }

    }

    func cancel() {
        subscriber = nil
    }
}

struct Combine_3 {
    init() {
        var subs: Set<AnyCancellable> = []
        let fibanchi = FibonacciPublisher()

        fibanchi.sink(
            receiveCompletion: { completion in
            },
            receiveValue: { value in
                print("FValue:)", value)
            }
        ).store(in: &subs)
    }
}
