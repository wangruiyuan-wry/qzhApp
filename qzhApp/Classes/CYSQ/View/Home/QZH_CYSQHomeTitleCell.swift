//
//  QZH_CYSQHomeTitleCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/25.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZH_CYSQHomeTitleCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: QZHUILabelView!
    @IBOutlet weak var leftLine: QZHUILabelView!


    @IBOutlet weak var rightLine: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
