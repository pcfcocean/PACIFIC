import Foundation


let group = DispatchGroup()
let lock = NSLock()

var _count = 0
var count: Int {
    get { lock.withLock { _count } }
    set { lock.withLock { _count = newValue } }
}

DispatchQueue.global().async() {
    group.enter()
    for _ in 0...9999 {
        count += 1
    }
    group.leave()
}


DispatchQueue.global().async() {
    group.enter()
    for _ in 0...9999 {
        count += 1
    }
    group.leave()
}

group.notify(queue: DispatchQueue.global()) {
    print(count) // ?
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
