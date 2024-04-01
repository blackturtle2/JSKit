//
//  File.swift
//  
//
//  Created by Leejaesung on 4/1/24.
//

import UIKit

extension UITableView {

    /// cell이 0개일 때, 보여줄 empty message를 세팅합니다.
    /// `tableView(_:numberOfRowsInSection:)` 또는 `numberOfSections(in:)`에서
    /// 데이터의 `isEmpty` 여부로 `setEmptyMessage` 또는 `restore`을 호출합니다.
    /// ref: https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
    public func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    public func removeEmptyMessage(separatorStyle: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separatorStyle
    }
}
