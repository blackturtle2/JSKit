//
//  File.swift
//  
//
//  Created by Leejaesung on 4/3/24.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
