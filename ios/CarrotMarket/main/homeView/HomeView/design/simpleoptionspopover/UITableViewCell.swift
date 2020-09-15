//
//  File3.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//
import UIKit

extension UITableViewCell {
    func configure(with optionItem: RBOptionItem) {
        textLabel?.text = optionItem.text
        textLabel?.font = optionItem.font
    }
}
