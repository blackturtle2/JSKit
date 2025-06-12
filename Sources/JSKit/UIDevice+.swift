//
//  UIDevice+.swift
//  JSKit
//
//  Created by leejaesung on 6/12/25.
//

import UIKit

extension UIDevice {
    private var size: CGSize { return UIScreen.main.bounds.size }

    public var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    public var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public var isPhoneSE: Bool {
        return self.isPhone && (size.height == 568 || size.width == 320)
    }

    public var isPhonePlus: Bool {
        return self.isPhone && (size.height == 736 || size.width == 414)
    }

    public var isPadPro12: Bool {
        return isPad && (size.height == 1366 || size.width == 1366)
    }
}
