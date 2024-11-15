//
//  Combine_3.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 27.10.24.
//

import Foundation
import Combine

struct FibonacciPublisher: Publisher {
    typealias Output = Int

    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FibanachiSubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

class FibanachiSubscription<S: Subscriber>: Subscription where S.Input == Int {
    private var subscriber: S?

    init(subscriber: S) {
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        switch demand {
        case .none:
            subscriber?.receive(completion: .finished)
        case .unlimited:
        case .max(let value):
        }
    }

    func cancel() {
        subscriber = nil
    }
}
