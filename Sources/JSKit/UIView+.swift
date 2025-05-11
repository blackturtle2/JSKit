//
//  UIView+.swift
//  JSKit
//
//  Created by leejaesung on 12/26/24.
//

import UIKit

extension UIView {

    public func applyAllCornerRadius(with radius: CGFloat) {
        self.applyCornerRadius(with: radius, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
    }

    public func applyTopCornerRadius(with radius: CGFloat) {
        self.applyCornerRadius(with: radius, corners: [.topLeft, .topRight])
    }

    public func applyBottomCornerRadius(with radius: CGFloat) {
        self.applyCornerRadius(with: radius, corners: [.bottomLeft, .bottomRight])
    }

    private func applyCornerRadius(with radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    /// https://blog.naver.com/traeumen927/221897997210
    @IBInspectable public var isCircle: Bool {
        get {
            return self.isCircle
        }
        set (needRadius) {
            if needRadius {
                self.layer.cornerRadius = self.layer.frame.width / 2
            }
        }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set (cornerRadius) {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
