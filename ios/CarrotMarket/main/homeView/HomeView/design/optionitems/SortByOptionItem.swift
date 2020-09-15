//
//  SortOrderOptionItem.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

enum SortBy {
    case updatedAt
    case alphabet
}

struct SortByOptionItem: RBOptionItem {
    var text: String
    var font = UIFont.systemFont(ofSize: 15)
    var isSelected: Bool
    var sortyBy: SortBy
}
