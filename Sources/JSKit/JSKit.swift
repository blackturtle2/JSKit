import UIKit
import MessageUI
import SafariServices

/*
 ***** ***** ***** ***** Add `P.U.B.L.I.C.` Access Control (접근제어) ***** ***** ***** *****
 */

public struct JSKit {

    public static let shared = JSKit()

    public init() {}

    // MARK: - App Version

    private var marketingVersion: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    private var buildNumber: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    public var appVersionText: String { "App version: \(self.marketingVersion ?? "") (\(self.buildNumber ?? ""))" }
    private var modelIdentifier: String {
        // ref: https://www.theiphonewiki.com/wiki/Models
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return simulatorModelIdentifier
        }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine,
                                  count: Int(_SYS_NAMELEN)),
                      encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    /// 디버깅 시에 프린트를 보다 편하게 하기 위한 도구입니다.
    /// - Parameters:
    ///     - messsage  : 별도로 프린트하고 싶은 메시지를 추가합니다. Any 타입으로 String 등의 여러 타입이 모두 가능합니다.
    ///     - codeName  : 코드네임은 프린트문 최앞단에 작성됩니다. 1234와 같은 검색하기 쉬운 코드네임을 넣으세요.
    ///     - title     : message의 바로 앞에서 메시지가 무슨 뜻인지 알려줍니다.
    ///     - function  : 디폴트 값으로 알아서 함수명을 프린트하므로 굳이 수정할 이유는 없습니다.
    public func PRINT_LOG(_ messsage: Any? = nil,
                          codeName: String? = nil,
                          title: String? = nil,
                          function: String = #function) {
#if DEBUG
        /// "\(Date()) \(#file.components(separatedBy: "/").last ?? "") \(#function) \(#line) 로그 내용"
        let codeName = codeName == nil ? "" : "[\(codeName ?? "")]"
        let function = "[\(function)]"
        let title = title == nil ? "" : " \(title ?? "")"
        var message: String {
            guard let messsage else { return "" }
            let strMessage = String(describing: messsage)

            if strMessage.contains("\n") {
                return ": 👇🏻\n🔻🔻🔻\n\(strMessage)\n🔺🔺🔺\n"
            } else {
                return ": \(strMessage)\n"
            }
        }

        print(">>>>> 📍 \(codeName)\(function)\(title)\(message)")
#endif
    }

    // MARK: - OK and Cancel Button Alert

    public func presentOkButtonAlert(with parentVC: UIViewController,
                                     message m: String,
                                     title t: String = "",
                                     _ okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: okHandler))

        DispatchQueue.main.async {
            parentVC.present(alert, animated: true, completion: nil)
        }
    }

    public func presentOkCancelButtonAlert(with parentVC: UIViewController,
                                    message m: String,
                                    title t: String = "",
                                    _ okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: okHandler))

        DispatchQueue.main.async {
            parentVC.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Center Activity Indicator

    /// ref: https://stackoverflow.com/questions/38457750/use-activity-indicator-in-many-vc-without-duplicating-code-swift
    public func presentCenterActivityIndicator() {
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

    public func hideCenterActivityIndicator() {
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

    // MARK: - Send Email to Developer

    /// 개발자에게 이메일 보내기 function // `import MessageUI` 필요
    /// - Parameters:
    ///   - emailAddress: String 타입의 이메일 주소
    ///   - parentView: MFMailComposeViewController를 띄우기 원하는 마더 뷰
    public func sendEmailTo(_ emailAddress: String,
                            title: String,
                            customBody body: String? = nil,
                            tintColor: UIColor? = nil,
                            in parentVC: UIViewController) {
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion // 현재 사용자 iOS 버전
        let appVersion = self.marketingVersion ?? ""
        let mailComposeVC = MFMailComposeViewController()

        /// Delegate: 메일 보내기 Finish 이후의 액션 정의를 위한 Delegate
        mailComposeVC.mailComposeDelegate = parentVC as? MFMailComposeViewControllerDelegate

        /// configure mail contents
        mailComposeVC.setToRecipients([emailAddress]) // 받는 사람 설정
        mailComposeVC.setSubject(title) // 메일 제목 설정

        /// 메일 내용 설정
        let customBodyText: String = {
            guard let body else { return "" }
            return "\n\(body)"
        }()
        mailComposeVC.setMessageBody("# \(self.modelIdentifier) / \(systemName) \(systemVersion) / App ver.\(appVersion)\(customBodyText)",
                                     isHTML: false)

        /// App의 tintColor와 맞추고자 하면, tintColor 설정
        if let tintColor {
            mailComposeVC.navigationBar.tintColor = tintColor
        }

        /// 사용자 아이폰의 메일 주소 세팅 여부 체크
        if MFMailComposeViewController.canSendMail() {
            parentVC.present(mailComposeVC, animated: true, completion: nil)
        } // else: iOS 에서 자체적으로 메일 주소를 세팅하라는 메시지를 띄웁니다.
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

        let safariViewController = SFSafariViewController(url: url)
        if let tintColor {
            safariViewController.preferredControlTintColor = tintColor
        }

        parentVC.present(safariViewController, animated: true, completion: completion)
    }

    // MARK: - Print Process Time (함수 구동 시간 측정하기)

    /// 특정 function의 구동 시간을 측정하는 함수
    /// - Parameter blockFunction: 측정이 필요한 함수 구현
    /// - Returns: 콘솔에 processTime을 print 함
    public func printProcessTime(blockFunction: () -> Void) {
        let startTime = CFAbsoluteTimeGetCurrent()
        blockFunction()
        let processTime = CFAbsoluteTimeGetCurrent() - startTime

        self.PRINT_LOG(processTime, codeName: "processTime")
    }

}
