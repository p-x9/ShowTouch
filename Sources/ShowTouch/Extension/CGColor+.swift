//
//  CGColor+.swift
//  
//
//  Created by p-x9 on 2023/04/19.
//  
//

import Foundation
import CoreGraphics

extension CGColor {
    static func color(rgb code: String) -> CGColor {
        var color: UInt64 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if Scanner(string: code.replacingOccurrences(of: "#", with: "")).scanHexInt64(&color) {
            r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            b = CGFloat( color & 0x0000FF       ) / 255.0
        }
        return CGColor(srgbRed: r, green: g, blue: b, alpha: 1.0)
    }

    static func color(rgba code: String) -> CGColor {
        var color: UInt64 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1.0
        let code = code.replacingOccurrences(of: "#", with: "")
        if Scanner(string: code).scanHexInt64(&color) {
            r = CGFloat((color & 0xFF000000) >> 24) / 255.0
            g = CGFloat((color & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((color & 0x0000FF00) >> 8 ) / 255.0
            a = CGFloat( color & 0x000000FF       ) / 255.0
        }
        return CGColor(srgbRed: r, green: g, blue: b, alpha: a)
    }

    private var rgbaComponents: [CGFloat] {
        guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedSRGB),
              let converted = self.converted(to: colorSpace, intent: .defaultIntent, options: nil),
              let components = converted.components,
              converted.numberOfComponents == 4 else {
            fatalError("unsupported cgcolor")
        }
        return components
    }

    /// rgb color code
    var rgbString: String {
        let rgb: [CGFloat] = Array(rgbaComponents[0...3])
        return rgb.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }

    /// rgba color code
    var rgbaString: String {
        let rgba: [CGFloat] = rgbaComponents
        return rgba.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }
}
