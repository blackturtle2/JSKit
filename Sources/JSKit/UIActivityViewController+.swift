//
//  UIActivityViewController.swift
//  JSKit
//
//  Created by leejaesung on 12/30/24.
//

import UIKit

extension UIActivityViewController {

    func iPadAvailable(with parentVC: UIViewController?) {
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
