//
//  Questions.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 3.07.25.
//

struct Questions {

    init() {
        // Пример использования:
        let testString = "abca"
        if isAlmostPalindrome(testString) {
            print("\(testString) — почти полиндром")
        } else {
            print("\(testString) — не полиндром и не почти полиндром")
        }

        print(maxUniqueCount([1,1,1,2,2]))
        print(maxUniqueCount([4,4,2]))
        print("-----")
    }
    func isAlmostPalindrome(_ s: String) -> Bool {
        var chars = Array(s)
        for index in 0..<chars.count {
            var temp = chars
            temp.remove(at: index) // удаляем символ по индексу i
            let newString = String(temp)
            if isPalindrome(newString) {
                print("YES")
                return true
            }
            print("NO")
        }
        return false
    }
    func isPalindrome(_ s: String) -> Bool {
        return s == String(s.reversed())
    }


    func maxDiffSum(processingArray: [Int]) -> Int {
        var array = processingArray
        var maxDiffSum = 0
        repeat {
            guard array.count >= 2 else { return maxDiffSum }

            var maxDiff = abs(array[1] - array[0])
            var maxIndex = 0 // индекс первого элемента пары с максимальной разницей

            for i in 1..<array.count - 1 {
                let diff = abs(array[i+1] - array[i])
                if diff > maxDiff {
                    maxDiff = diff
                    maxIndex = i
                }
            }

            array.remove(at: maxIndex + 1)
            array.remove(at: maxIndex)

            maxDiffSum += maxDiff
        } while array.count >= 2

        return maxDiffSum
    }

    func maxUniqueCount(_ array: [Int]) -> Int {
        var unique = Set<Int>()
        for value in array {
            if !unique.insert(value).inserted {
                var divBy2 = value
                repeat {
                    divBy2 /= 2
                    unique.insert(divBy2)
                } while !unique.contains(divBy2)
            }
        }
        print(unique.count)
        return unique.count
    }

}
