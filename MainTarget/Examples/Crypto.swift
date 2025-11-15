//
//  Crypto.swift
//  PacificOcaen
//
//

// https://stackoverflow.com/questions/73454717/how-do-i-parse-an-x509-certificate-and-extract-its-keys-signature-in-swift


import Foundation
import CryptoKit
import Security

struct RSACrypter {
    init() {}

    func test() {
        var error: Unmanaged<CFError>?
        let attributes: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 2048
        ]

        guard
            let privateKey: SecKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error),
            let publicKey: SecKey = SecKeyCopyPublicKey(privateKey),
            let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error) as Data?
        else {
            print(error.debugDescription)
            return
        }

        guard let dataToEncrypt: Data = String(repeating: "1", count: 190).data(using: .utf8) else {
            print("Ошибка создания данных")
            return
        }

        print(dataToEncrypt.count)

        guard let encryptedData = encryptData(data: dataToEncrypt, publicKey: publicKey) else { return }

        print(encryptedData.count)

        guard let decryptedData = decryptData(encryptedData: encryptedData, privateKey: privateKey) else { return }
        let decryptedString = String(data: decryptedData, encoding: .utf8)
        print(decryptedString)
    }

    /// Шифрование данных с использованием открытого ключа
    func encryptData(data: Data, publicKey: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        guard
            let encryptedData: Data = SecKeyCreateEncryptedData(
                publicKey,
                .rsaEncryptionPKCS1,
                data as CFData,
                &error
            ) as? Data
        else {
            print("Ошибка шифрования", error.debugDescription)
            return nil
        }
        return encryptedData
    }

    /// Дешифрование данных с использованием закрытого ключа
    func decryptData(encryptedData: Data, privateKey: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        guard
            let decryptedData: Data = SecKeyCreateDecryptedData(
                privateKey,
                .rsaEncryptionPKCS1,
                encryptedData as CFData,
                &error
            ) as? Data
        else {
            print("Ошибка дешифрования", error.debugDescription)
            return nil
        }
        return decryptedData
    }
}
