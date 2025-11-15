//
//  Regexes.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 28.12.23.
//

import Foundation

struct Regexes1 {
    init() {
        let inputString: String = "©abc123defSoQlI456"

        let pattern: String = "[0-9sSoOQlIB]"
        guard
            let regularExpression: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: [])
        else {
            print("Не удалось создать регулярное выражение")
            return
        }

        let inputStringFullRange: NSRange = NSRange(location: .zero, length: inputString.utf16.count)
        let matches: [NSTextCheckingResult] = regularExpression.matches(in: inputString, range: inputStringFullRange)
        let outputString: String = matches.map { nsTextCheckingResult in
            (inputString as NSString).substring(with: nsTextCheckingResult.range)
        }.joined()

        print(outputString) // 123SoQlI456
    }
}

struct Regexes2 {
    init() {
        let inputString: String = "©abc123defSoQlI456"

        let pattern: String = "[0-9sSoOQDlIBG]"

        guard
            let rangeIndex: Range<String.Index>  = inputString.range(of: pattern, options: .regularExpression)
        else { return }
        print(rangeIndex)
        let outputString = String(inputString[rangeIndex])
        print(outputString) // 1
    }
}

struct Regexes3 {
    init() {
        let inputString: String = "©abc123defSoQlI456"

        let pattern: String = "[0-9sSoOQlIB]"
        guard
            let regex: Regex<AnyRegexOutput> = try? Regex(pattern)
        else {
            print("Не удалось создать регулярное выражение")
            return
        }
        let matches = inputString.matches(of: regex)
        let outputString: String = matches.map { match in
            inputString[match.range.lowerBound ..< match.range.upperBound]
        }.joined()

        print(outputString) // 123SoQlI456
    }
}
