//
//  DateFormatterTest.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 25.07.25.
//

import Foundation

struct DateFormatterTest {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .ru
        return dateFormatter
    }()

    init() {
        print("---", convertDate("05.12.2024T11:19:24", from: .ddMMyyyyTHHmmss, to: .HHmm))
        print("---", convertDate("2024-12-05T11:19:25.924814", from: .yyyyMMddTHHmmssSSSSSS, to: .HHmm))
        print("---", convertDate("2024-12-05T11:19:25.924814", from: .yyyyMMddTHHmmssS, to: .HHmm))
    }

    private func convertDate(
        _ date: String,
        from inputFormate: DateFormatter.Format,
        to outputFormat: DateFormatter.Format
    ) -> String? {
        dateFormatter.dateFormat = inputFormate.rawValue
        guard let date: Date = dateFormatter.date(from: date) else { return nil }
        dateFormatter.dateFormat = outputFormat.rawValue
        return dateFormatter.string(from: date)
    }
}
