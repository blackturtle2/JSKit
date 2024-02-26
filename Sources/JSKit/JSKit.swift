import UIKit

public struct JSKit {

    public static let shared = JSKit()

    public init() {}

    /// 디버깅 시에 프린트를 보다 편하게 하기 위한 도구입니다.
    /// - Parameters:
    ///     - messsage: 별도로 프린트하고 싶은 메시지를 추가합니다. Any 타입으로 String 등의 여러 타입이 모두 가능합니다.
    ///     - codeName: 코드네임은 프린트문 최앞단에 작성됩니다. 1234와 같은 검색하기 쉬운 코드네임을 넣으세요.
    ///     - function: 디폴트 값으로 알아서 함수명을 프린트하므로 굳이 수정할 이유는 없습니다.
    public func PRINT_LOG(_ messsage: Any? = nil,
                          codeName: String? = nil,
                          function: String = #function) {
#if DEBUG
        /// "\(Date()) \(#file.components(separatedBy: "/").last ?? "") \(#function) \(#line) 로그 내용"
        let codeName = codeName == nil ? "" : "[\(codeName ?? "")] "
        let msg = messsage == nil ? "" : ":\n\(String(describing: messsage ?? ""))\n"

        print(">>>>> 🧑🏻‍💻 \(codeName)\(function)\(msg)")
#endif
    }

    // MARK: - Ok and Cancel Button Alert

    private let okButtonTitle: String = {
        if #available(iOS 16, *) {
            switch (Locale.current.language.languageCode ?? .english) {
            case .korean: return "확인"
            default: return "Ok"
            }
        } else {
            return (Locale.current.languageCode ?? "en") == "kr" ? "확인" : "Ok"
        }
    }()
    private let cancelButtonTitle: String = {
        if #available(iOS 16, *) {
            switch (Locale.current.language.languageCode ?? .english) {
            case .korean: return "취소"
            default: return "Cancel"
            }
        } else {
            return (Locale.current.languageCode ?? "en") == "kr" ? "취소" : "Cancel"
        }
    }()

    public func presentOkButtonAlert(with viewController: UIViewController,
                                     message m: String,
                                     title t: String = "",
                                     _ okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: self.okButtonTitle, style: .default, handler: okHandler))

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func presentOkCancelButtonAlert(with viewController: UIViewController,
                                    message m: String,
                                    title t: String = "",
                                    _ okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: self.cancelButtonTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: self.okButtonTitle, style: .default, handler: okHandler))

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Center Activity Indicator

    /// ref: https://stackoverflow.com/questions/38457750/use-activity-indicator-in-many-vc-without-duplicating-code-swift
    func presentCenterActivityIndicator() {
        DispatchQueue.main.async {
            var keyWindow: UIWindow? {
                UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            }

            guard let window = keyWindow,
                  let rootVC = window.rootViewController else { return } // full-screen 사이즈를 알기 위해 rootVC를 사용합니다.

            let backgroundView = UIView()
            backgroundView.frame = CGRect.init(x: 0,
                                               y: 0,
                                               width: rootVC.view.bounds.width,
                                               height: rootVC.view.bounds.height)
            backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
            backgroundView.tag = 475647

            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = rootVC.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = {
                if #available(iOS 13.0, *) { return .large } else { return .white }
            }()
            activityIndicator.color = .white
            activityIndicator.startAnimating()

            backgroundView.addSubview(activityIndicator)
            window.addSubview(backgroundView)
        }
    }

    func hideCenterActivityIndicator() {
        DispatchQueue.main.async {
            var keyWindow: UIWindow? {
                UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            }

            guard let window = keyWindow else { return }

            window.subviews.forEach { view in
                if let backgroundView = view.viewWithTag(475647) {
                    backgroundView.removeFromSuperview()
                }
            }
        }
    }

}
