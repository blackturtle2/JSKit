//
//  File.swift
//  JSKit
//
//  Created by leejaesung on 4/11/25.
//

import Foundation

extension String {

    public var removingWhitespaces: String {
        return self.components(separatedBy: .whitespaces).joined()
    }

}
