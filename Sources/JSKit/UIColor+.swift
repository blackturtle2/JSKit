//
//  UIColor+.swift
//  JSKit
//
//  Created by leejaesung on 2/4/25.
//

import Foundation
import UIKit

extension UIColor {

    /// https://gyuios.tistory.com/25
    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        /// assert는 디버깅 환경에서만 작동
        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    /// https://gyuios.tistory.com/25
    public var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format: "#%06x", rgb)
    }

    /// 보색을 계산하여 반환
    public func complementaryColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        // UIColor의 RGBA 값을 추출
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        // 각 채널을 반전 (1.0 - 원래 값)
        let invertedRed = 1.0 - red
        let invertedGreen = 1.0 - green
        let invertedBlue = 1.0 - blue

        // 반전된 색상 반환
        return UIColor(red: invertedRed, green: invertedGreen, blue: invertedBlue, alpha: alpha)
    }

}
