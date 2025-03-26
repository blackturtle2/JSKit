//
//  UIViewController+.swift
//  JSKit
//
//  Created by leejaesung on 3/26/25.
//

import UIKit

extension UIViewController {

    // MARK: - OK Button Alert
    public func presentOkAlert(title t: String = "",
                               message m: String,
                               _ okHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: okHandler))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - OK / Cancel Button Alert
    public func presentOkCancelAlert(title t: String = "",
                                     message m: String,
                                     _ okHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: okHandler))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - TextField / OK / Cancel Button Alert
    public func presentOkCancelWithTextFieldAlert(title t: String = "",
                                                  message m: String,
                                                  placeholder p: String = "",
                                                  keyboardType: UIKeyboardType = .default,
                                                  textAlignment: NSTextAlignment = .left,
                                                  clearButtonMode: UITextField.ViewMode = .always,
                                                  _ okHandler: @escaping ((String) -> Void)) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addTextField {
            $0.placeholder = p
            $0.keyboardType = keyboardType
            $0.textAlignment = textAlignment
            $0.clearButtonMode = clearButtonMode
        }
        alert.addAction(UIAlertAction(title: String(localized: "Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: { _ in
            okHandler(alert.textFields?.first?.text ?? "")
        }))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
