//
//  CoreDataSimpleExample.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 9.07.25.
//

import Foundation
import Security

struct CoreDataSimpleExample {
    func save() {
        let password = "password".data(using: .utf8)

        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "EXAMPLE2",
            kSecAttrService: "EXAMPLE2",
            kSecValueData: password,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
        ]

//        query[kSecAttrAccessGroup] = accessGroup

        // Удаляем старый элемент для этого аккаунта и сервиса, если он есть
        SecItemDelete(query as CFDictionary)

        // Добавляем новый элемент
        SecItemAdd(query as CFDictionary, nil)
    }

    func get() -> String? {
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "EXAMPLE2",
            kSecAttrService: "EXAMPLE2",
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]

//        query[kSecAttrAccessGroup] = accessGroup

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let password = String(data: data, encoding: .utf8) else {
            return nil
        }

        return password
    }

}
