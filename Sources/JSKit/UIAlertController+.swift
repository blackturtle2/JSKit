//
//  UIAlertController+.swift
//  JSKit
//
//  Created by leejaesung on 6/11/25.
//

import UIKit

extension UIAlertController {

    public func iPadAvailable(with parentVC: UIViewController?) {
        guard let parentVC else { return }
        if let popoverController = self.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2,
                                                  y: UIScreen.main.bounds.height / 2,
                                                  width: 0, height: 0)
            popoverController.sourceView = parentVC.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
    }

}
