//
//  File.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//
import UIKit

protocol RBOptionItem {
    var text: String { get }
    var isSelected: Bool { get set }
    var font: UIFont { get set }
}

extension RBOptionItem {
    func sizeForDisplayText() -> CGSize {
        return text.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
