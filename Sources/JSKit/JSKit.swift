import UIKit

public struct JSKit {

    public static let shared = JSKit()

    public init() {
    }

    /// 디버깅 시에 프린트를 보다 편하게 하기 위한 도구입니다.
    /// - Parameters:
    ///     - messsage: 별도로 프린트하고 싶은 메시지를 추가합니다. Any 타입으로 String 등의 여러 타입이 모두 가능합니다.
    ///     - codeName: 코드네임은 프린트문 최앞단에 작성됩니다. 1234와 같은 검색하기 쉬운 코드네임을 넣으세요.
    ///     - function: 디폴트 값으로 알아서 함수명을 프린트하므로 굳이 수정할 이유는 없습니다.
    public func PRINT_LOG(_ messsage: Any? = nil, codeName: String? = nil, function: String = #function) {
#if DEBUG
        /// "\(Date()) \(#file.components(separatedBy: "/").last ?? "") \(#function) \(#line) 로그 내용"
        let codeName = codeName == nil ? "" : "[\(codeName ?? "")] "
        let msg = messsage == nil ? "" : ":\n\(String(describing: messsage ?? ""))\n"

        print(">>>>> 🧑🏻‍💻 \(codeName)\(function)\(msg)")
#endif
    }

    // MARK: - ok alert

    public func presentOkButtonAlert(with viewController: UIViewController, message m: String, title t: String = "",
                              _ okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: okHandler))

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

}
