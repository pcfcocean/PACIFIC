//
//  FontsRegistrator.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 21.03.24.
//

import CoreGraphics
import CoreText
import Foundation

final public class FontRegistrator {
    public static var appFonts: [String] {
        return [
            "CustomFont.ttf"
        ]
    }

    public static func registerFonts(fontNames: [String] = appFonts) {
        fontNames.forEach { registerFont(name: $0) }
    }

    private static func registerFont(name: String) {
        guard let font = getFont(name: name) else { return }
        var error: Unmanaged<CFError>? = nil
        CTFontManagerRegisterGraphicsFont(font, &error)
    }

    private static func getFont(name: String) -> CGFont? {
        guard
            let fontUrl: URL = Bundle.main.url(forResource: name, withExtension: nil),
            let fontData: NSData = NSData(contentsOf: fontUrl),
            let fontDataProvider: CGDataProvider = CGDataProvider(data: fontData),
            let font: CGFont = CGFont(fontDataProvider)
        else { return nil }
        return font
    }
}
