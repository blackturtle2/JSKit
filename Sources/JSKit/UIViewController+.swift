//
//  UIViewController+.swift
//  JSKit
//
//  Created by leejaesung on 3/26/25.
//

import UIKit
import SafariServices

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

    // MARK: - Present SafariView

    /// SFSafariViewController를 띄우는 함수
    /// - Parameters:
    ///   - parentView: 띄우기를 원하는 마더 뷰
    ///   - stringUrl: String 타입의 URL
    ///   - completion: SFSafariViewController를 띄운 후, 작동할 completion
    public func presentSafariViewTo(_ stringUrl: String,
                                    tintColor: UIColor? = nil,
                                    in parentVC: UIViewController,
                                    completion: (() -> Void)? = nil) {
        guard let url = URL(string: stringUrl) else { return }

        let safariVC = SFSafariViewController(url: url)
        if let tintColor {
            safariVC.preferredControlTintColor = tintColor
        }

        parentVC.present(safariVC, animated: true, completion: completion)
    }

}
