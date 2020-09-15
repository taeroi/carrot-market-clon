//
//  UsedTradingItemsTableViewCell.swift
//  ios
//
//  Created by 태로고침 on 2020/08/31.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class UsedTradingItemsTableViewCell: UITableViewCell {
    
    //MARK: - 게시글 제목 2줄 나오게 하는 기능 필요!
    @IBOutlet weak var usedTradingItemImg: UIImageView!
    @IBOutlet weak var usedTradingItemTitleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        usedTradingItemTitleLabel.lineBreakMode = .byWordWrapping
//        usedTradingItemTitleLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
