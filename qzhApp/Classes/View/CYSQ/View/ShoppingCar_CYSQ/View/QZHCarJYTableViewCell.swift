//
//  QZHCarJYTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHCarJYTableViewCell: UITableViewCell {

    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proName: QZHUILabelView!
    @IBOutlet weak var proSpec: QZHUILabelView!
    @IBOutlet weak var priceIcon: QZHUILabelView!
    @IBOutlet weak var sellPrice: QZHUILabelView!
    @IBOutlet weak var price: QZHUILabelView!
    @IBOutlet weak var proCount: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        proImg.frame = CGRect(x:20*PX,y:10*PX,width:160*PX,height:160*PX)
        proImg.image = UIImage(named:"loadPic")
        
        proName.setLabelView(200*PX, 18*PX, 496*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        proName.numberOfLines = 2
        proName.lineBreakMode = .byWordWrapping
        
        proSpec.setLabelView(200*PX, 91*PX, 496*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "")
        
        priceIcon.setLabelView(200*PX, 135*PX, 20*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 20, "¥")
        
        sellPrice.setLabelView(220*PX, 129*PX, sellPrice.autoLabelWidth(sellPrice.text!, font: 38, height: 40*PX) + 5*PX, 40*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 28, "")
        
        price.setLabelView(230*PX+sellPrice.autoLabelWidth(sellPrice.text!, font: 40, height: 40*PX), 139*PX, price.autoLabelWidth(price.text!, font: 30, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 20, "")
        
        proCount.setLabelView(630*PX, 134*PX, 100*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 24, "")
        
        line.dividers(20*PX, y: 180*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
