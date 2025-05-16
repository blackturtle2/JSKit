//
//  UILabel+.swift
//  
//
//  Created by Leejaesung on 5/12/24.
//

import UIKit

extension UILabel {

    public func fontSize(with fontSize: CGFloat, in ranges: [String]? = nil) {
        guard let text = self.text,
              let attributedText = self.attributedText else { return }
        let font = UIFont.systemFont(ofSize: fontSize, weight: self.font.weight)
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)

        if let ranges = ranges {
            ranges.forEach { mutableAttributedString.addAttribute(.font, value: font, range: (text as NSString).range(of: $0)) }
        } else {
            [text].forEach { mutableAttributedString.addAttribute(.font, value: font, range: (text as NSString).range(of: $0)) }
        }

        self.attributedText = mutableAttributedString
    }

    public func setLineSpacing(with lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }

    public func bold(in ranges: [String], isBold: Bool) {
        guard let text = self.text,
              let attributedText = self.attributedText else { return }
        let font = isBold ? UIFont.boldSystemFont(ofSize: self.font.pointSize) : UIFont.systemFont(ofSize: self.font.pointSize)
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)

        ranges.forEach {
            mutableAttributedString.addAttribute(.font, value: font, range: (text as NSString).range(of: $0))
        }
        self.attributedText = mutableAttributedString
    }

}
