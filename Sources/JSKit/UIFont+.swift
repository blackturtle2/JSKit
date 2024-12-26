//
//  UIFont+.swift
//  JSKit
//
//  Created by leejaesung on 12/23/24.
//

import UIKit

extension UIFont {

    public class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return systemFont
        }
    }

}
