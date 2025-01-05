//
//  UITextView+.swift
//  JSKit
//
//  Created by leejaesung on 1/6/25.
//

import UIKit

extension UITextView {

    /// 전체 라인 수를 반환합니다.
    /// 내부 마진 사이즈에 따라 라인 수 계산법이 달라지므로 위/아래 마진값을 파라미터로 받습니다.
    public func countOfLines(topMargin: CGFloat, bottomMargin: CGFloat) -> Int {
        guard let font = self.font else { return 0 }
        return Int((self.contentSize.height - topMargin - bottomMargin) / font.lineHeight)
    }


    /// https://stackoverflow.com/questions/34922331/getting-and-setting-cursor-position-of-uitextfield-and-uitextview-in-swift
    /// 왼쪽으로 한칸 이동
    public func setCursorToOneLeftPosition() {
        self.setCursorPosition(to: -1)
    }

    /// 오른쪽으로 한칸 이동
    public func setCursorToOneRightPosition() {
        self.setCursorPosition(to: 1)
    }

    private func setCursorPosition(to count: Int) {
        guard let selectedRange = self.selectedTextRange,
              let newPosition = self.position(from: selectedRange.start, offset: count) else { return }
        self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
    }

    /// 현재 라인의 맨 왼쪽으로 이동
    public func setCursorToStartOfLine() {
        self.setCursorLine(to: .storage(.backward))
    }

    /// 현재 라인의 맨 오른쪽으로 이동
    public func setCursorToEndOfLine() {
        self.setCursorLine(to: .storage(.forward))
    }

    private func setCursorLine(to direction: UITextDirection) {
        guard let selectedRange = self.selectedTextRange,
              let endOfLinePosition = self.tokenizer.position(from: selectedRange.start,
                                                              toBoundary: .line,
                                                              inDirection: direction) else { return }
        self.selectedTextRange = self.textRange(from: endOfLinePosition, to: endOfLinePosition)
    }

    /// 맨 위로 이동
    public func setCursorToTheBeginning() {
        self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.beginningOfDocument)
    }

    /// 맨 아래로 이동
    public func setCursorToTheEnd() {
        self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
    }

}
