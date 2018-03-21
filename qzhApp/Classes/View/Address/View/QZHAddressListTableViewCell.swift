//
//  QZHAddressListTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHAddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: QZHUILabelView!
    @IBOutlet weak var isDefault: QZHUILabelView!
    @IBOutlet weak var addressLabel: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    @IBOutlet weak var phoneLabel: QZHUILabelView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 收货人姓名
        nameLabel.setLabelView(20*PX, 25*PX, 210*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "")
        
        // 收货人电话
        phoneLabel.setLabelView(430*PX, 25*PX, 303*PX, 37*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 26, "")
        
        // 默认地址
        isDefault.isHidden = true
        
        // 地址
        addressLabel.setLabelView(20*PX, 25*PX, 713*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "")
        
        // 分割线
        line.dividers(0, y: 164*PX, width:750*PX, height: 1*PX, color: myColor().grayF0())
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
