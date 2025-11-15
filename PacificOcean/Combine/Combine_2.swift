//
//  Combine_2.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 27.10.24.
//

import UIKit
import Combine

// Combine. Publishers, Subjects
// https://www.youtube.com/watch?v=t7Nv_I-Haaw&list=PLtUCU7XGn_c4Fg6P6isW-c8ePR99V1N_W&index=2

enum CombineError: Error {
    case myError
    case failed
}

class Combine_2 {
    // Data
    var data = ["One", "Two", "Three"]
    var store: Set<AnyCancellable> = []

    init() {
        print("JUST Publisher")
        just()
        print()

        print("SEQUANCE Publisher")
        sequance()
        print()

        print("FUTURE Publisher")
        furure()
        print()

        print("DEFERRED Publisher")
        deferred()
        print() 

        print("EMPTY Publisher")
        empty()
        print()

        print("FAIL Publisher")
        fail()
        print()

        print("any Publisher")
        eraseToAnyPublisher()
        print()

        print("EXAMPLE")
        examples()
        print()

        print("PASSTHROUGH_SUBJECT")
        passthroughSubject()
        print()

        print("CURRENT_VALUE_SUBJECT")
        currentValueSubject()
        print()
    }

    deinit {
        print("DEINIT")
    }

    func just() {
        let just: Just<String> = Just("Just message")

        just.sink { value in
            print(" Value of JUST Publisher:", value)
        }.store(in: &store)
    }

    func sequance() {
        data.publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("SEQUANCE Publisher finished")
                case .failure(let failure):
                    print("SEQUANCE Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of SEQUANCE Publisher:", value)
            }
        ).store(in: &store)
    }

    func furure() {
        let future: Future<UIImage, Error> = Future { promise in
            print("START FUTURE")
            let url = URL(string: "https://developer.apple.com/assets/elements/icons/swift/swift-96x96_2x.png")!
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    return promise(.failure(error))
                }

                if let data = data, let image = UIImage(data: data) {
                    return promise(.success(image))
                }
            }.resume()
        }

        future.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("FUTURE Publisher finished")
                case .failure(let failure):
                    print("FUTURE Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of FUTURE Publisher:", value)
            }
        ).store(in: &store)

        sleep(1)

        future.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("FUTURE Publisher finished - 2 sink")
                case .failure(let failure):
                    print("FUTURE Publisher failure - 2 sink", failure)
                }
            },
            receiveValue: { value in
                print("Value of FUTURE Publisher (2 sink):", value)
            }
        ).store(in: &store)
        sleep(1)
    }

    func deferred() {
        let deferred: Deferred<Future<UIImage, Error>> = Deferred {
            print("START DEFERRED")
            let future: Future<UIImage, Error> = Future { promise in
                print("START FUTURE INTO DEFERRED")
                let url = URL(string: "https://developer.apple.com/assets/elements/icons/swift/swift-96x96_2x.png")!
                URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                    if let error = error {
                        return promise(.failure(error))
                    }

                    if let data = data, let image = UIImage(data: data) {
                        return promise(.success(image))
                    }
                }.resume()
            }
            return future
        }

        deferred.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("DEFERRED Publisher finished")
                case .failure(let failure):
                    print("DEFERRED Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of DEFERRED Publisher:", value)
            }
        ).store(in: &store)

        sleep(1)

        deferred.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("DEFERRED Publisher finished - 2 sink")
                case .failure(let failure):
                    print("DEFERRED Publisher failure - 2 sink", failure)
                }
            },
            receiveValue: { value in
                print("Value of DEFERRED Publisher (2 sink):", value)
            }
        ).store(in: &store)

        sleep(1)
    }

    func empty() {
        let empty = Empty<String, Error>()

        empty.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("EMPTY Publisher finished")
                case .failure(let failure):
                    print("EMPTY Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of EMPTY Publisher:", value)
            }
        ).store(in: &store)

        sleep(1)
    }

    func fail() {
        let fail: Fail<String, Error> = Fail<String, Error>(error: CombineError.myError)

        fail.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("FAIL Publisher finished")
                case .failure(let failure):
                    print("FAIL Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of FAIL Publisher:", value)
            }
        ).store(in: &store)

        sleep(1)
    }

    func eraseToAnyPublisher() {
        let fail: Fail<String, Error> = Fail<String, Error>(error: CombineError.myError)
        let anyPublisher: any Publisher<String, Error> = Fail<String, Error>(error: CombineError.myError).eraseToAnyPublisher()
        fail.sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("any Publisher finished")
                case .failure(let failure):
                    print("any Publisher failure", failure)
                }
            },
            receiveValue: { value in
                print("Value of any Publisher:", value)
            }
        ).store(in: &store)

        sleep(1)

    }

    func examples() {
        let viewModel = ViewModel()
        viewModel.loadData(url: "https://developer.apple.com/assets/elements/icons/swift/swift-96x96_2x.png")
    }
}

class NetworkLayer {
    func getData(url: String) -> any Publisher<Data, CombineError> {
        guard let url = URL(string: url) else {
            return Fail<Data, CombineError>(error: CombineError.failed).eraseToAnyPublisher()
        }
        return Future<Data, CombineError> { promise in
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                guard error != nil else { return promise(.failure(.failed)) }
                guard let imageData = data else { return promise(.failure(.failed)) }
                promise(.success(imageData))

            }.resume()
        }.eraseToAnyPublisher()
    }
}

class ViewModel {
    private let layer = NetworkLayer()
    var store: Set<AnyCancellable> = []

    func loadData(url: String) {
        layer.getData(url: url).sink(
            receiveCompletion: { completion in
                print("EXAMPLE receiveCompletion:",  completion)
            },
            receiveValue: { value in
                print("EXAMPLE Value")
            }
        ).store(in: &store)

        sleep(1)
    }
}

// Subjects
extension Combine_2 {
    func passthroughSubject() {
        let passthroughSubject: PassthroughSubject<String, Never> = PassthroughSubject()

        passthroughSubject.sink(
            receiveValue: { value in
                    print("PASSTHROUGH_SUBJECT value", value)
            }
        ).store(in: &store)

        passthroughSubject.send("--- PASSTHROUGH_SUBJECT VALUE # 1---")
        sleep(1)
        passthroughSubject.send("--- PASSTHROUGH_SUBJECT VALUE # 2---")
        sleep(1)
        passthroughSubject.send("--- PASSTHROUGH_SUBJECT VALUE # 3---")
        sleep(1)

        passthroughSubject.sink(
            receiveValue: { value in
                    print("PASSTHROUGH_SUBJECT 2 value", value)
            }
        ).store(in: &store)

        passthroughSubject.send("--- PASSTHROUGH_SUBJECT VALUE # 4---")
    }

    func currentValueSubject() {
        let currentValueSubject: CurrentValueSubject<String, Never> = CurrentValueSubject("#0")

        currentValueSubject.sink(
            receiveValue: { value in
                    print("CURRENT_VALUE_SUBJECT value", value)
            }
        ).store(in: &store)

        currentValueSubject.send("--- CURRENT_VALUE_SUBJECT VALUE # 1---")
        sleep(1)
        currentValueSubject.send("--- CURRENT_VALUE_SUBJECT VALUE # 2---")
        sleep(1)
        currentValueSubject.send("--- CURRENT_VALUE_SUBJECT VALUE # 3---")
        sleep(1)

        currentValueSubject.sink(
            receiveValue: { value in
                    print("CURRENT_VALUE_SUBJECT 2 value", value)
            }
        ).store(in: &store)

        currentValueSubject.send("--- CURRENT_VALUE_SUBJECT VALUE # 4---")
    }
}
