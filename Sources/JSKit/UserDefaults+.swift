//
//  UserDefaults+.swift
//
//
//  Created by leejaesung on 9/2/24.
//

import Foundation

extension UserDefaults {

    func standardSet<Element: Codable>(value: Element, with key: String) {
        let encoded = try? JSONEncoder().encode(value)
        UserDefaults.standard.set(encoded, forKey: key)
    }

    func standardGet<Element: Codable>(with key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }

        return try? JSONDecoder().decode(Element.self, from: data)
    }

    func set<Element: Codable>(value: Element, with key: String, in appGroup: String) {
        let encoded = try? JSONEncoder().encode(value)
        UserDefaults(suiteName: appGroup)?.set(encoded, forKey: key)
    }

    func get<Element: Codable>(with key: String, in appGroup: String) -> Element? {
        guard let data = UserDefaults(suiteName: appGroup)?.data(forKey: key) else { return nil }

        return try? JSONDecoder().decode(Element.self, from: data)
    }
}
