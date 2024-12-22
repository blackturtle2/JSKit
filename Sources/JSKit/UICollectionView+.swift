//
//  UICollectionView+.swift
//  JSKit
//
//  Created by leejaesung on 12/23/24.
//

import UIKit

extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = self.indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { self.deselectItem(at: indexPath, animated: animated) }
    }
}

