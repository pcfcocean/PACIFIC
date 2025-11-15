//
//  ForEachFor.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 27.12.23.
//

import Foundation


struct ForEcahFor {
    func фор() {
        for element in (0 ... 20) {
            print("--- for in \(element)")
            if element == 8 { return }
        }
        print("--- выход из функции фор")
    }

    func форич() {
        (0 ... 20).forEach { element in
            print("--- forEach \(element)")
            if element == 8 { return }
        }
        print("--- выход из функции форич")
    }

    func форВместесГард() {
        for element in (0 ... 20) {
            print("--- for in \(element)")
            guard element == 20 else { continue }
            print("--- after guard \(element)")
            return
        }
        print("--- выход из функции форВместесГард")
    }

    func форичВместесГард() {
        (0 ... 20).forEach { element in
            print("--- forEach in \(element)")
            guard element == 8 else { return }
            print("--- after guard \(element)")
            return
        }
        print("--- выход из функции форВместесГард")
    }

//    Да, можно изменять элемент массива как в цикле for, так и в методе forEach(), но есть некоторые тонкости, о которых стоит помнить.
//
//    1. **Цикл for**:
//       - При использовании цикла for можно изменять элементы массива напрямую.
//       - Это особенно полезно, если вам необходимо изменить элемент на определенной позиции в массиве.
//
//    Пример:
//
//    var numbers = [1, 2, 3, 4, 5]
//
//    for i in 0..<numbers.count {
//        numbers[i] *= 2
//    }
//
//    print(numbers) // Выведет [2, 4, 6, 8, 10]
//
//    2. **Метод forEach()**:
//       - При использовании метода forEach() изменение элементов массива напрямую не поддерживается.
//       - Это связано с тем, что замыкание, переданное в метод forEach(), работает с копией элемента, а не с самим элементом из массива.
//
//    Пример:
//
//    var numbers = [1, 2, 3, 4, 5]
//
//    numbers.forEach { item in
//        // item *= 2 // Не сработает, так как изменение элемента здесь не отразится на исходном массиве
//    }
//
//    print(numbers) // Выведет [1, 2, 3, 4, 5]
//
//    Таким образом, если вам необходимо изменить элементы массива, рекомендуется использовать цикл for, а не метод forEach().
}
