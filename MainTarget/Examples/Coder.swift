//
//  Coder.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 14.07.24.
//

import Foundation

struct Credentials: Codable {
    let login: String
    let password: String

    public init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

struct Coder {
    init() {}

    func test() {
        let credo = Credentials(
            login: "LOGIN",
            password: "PASSWORD"
        )

        guard let jsonEcodedData: Data = try? JSONEncoder().encode(credo) else { return }
        let jsonEcodedString = String(data: jsonEcodedData, encoding: .utf8) ?? ""

        print(jsonEcodedString)
    }

    func jsonerTest() {
        let jsonString = """
        {
                "login": "LOGIN",
                "password": "PASSWORD",
        }
        """
        let jsonString2 = "{\n\"login\":\"LOGIN\",\n\"password\":\"PASSWORD\"\n}"

        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // Декодируем JSON данные в объект структуры
                let decodedData = try JSONDecoder().decode(Credentials.self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        } else {
            print("Error converting string to data")
        }
    }
}

public extension Encodable {
    func toDictionary() -> [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return [:] }
        return json
    }

    func toUtf8EncodedString() -> String {
        guard let data: Data = try? JSONEncoder().encode(self) else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
