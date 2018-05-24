//
//  QZHOrderListTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHOrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var line: QZHUILabelView!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proName: QZHUILabelView!
    @IBOutlet weak var proSpec: QZHUILabelView!
    @IBOutlet weak var priceIcon: QZHUILabelView!
    @IBOutlet weak var sellPrice: QZHUILabelView!
    @IBOutlet weak var price: QZHUILabelView!
    @IBOutlet weak var proCount: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        line.dividers(20*PX, y: 180*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        
        // 产品图片
        proImg.frame = CGRect(x:20*PX,y:10*PX,width:160*PX,height:160*PX)
        proImg.image = UIImage(named:"loadPic")
        
        // 产品名称
        proName.setLabelView(200*PX, 18*PX, 496*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        proName.lineBreakMode = .byTruncatingTail 
        proName.numberOfLines = 2
        
        // 产品规格
        proSpec.setLabelView( 200*PX, 91*PX, 496*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 24, "")
        
        // 产品数量
        proCount.setLabelView(600*PX, 134*PX, 130*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 24, "")
        
        // 产品价格
        priceIcon.setLabelView(200*PX, 139*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 20, "¥")
        sellPrice.setLabelView(218*PX, 130*PX, sellPrice.autoLabelWidth(sellPrice.text!, font: 30, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 28, "")
        price.setLabelView(228*PX+sellPrice.autoLabelWidth(sellPrice.text!, font: 38, height: 40*PX), 139*PX, price.autoLabelWidth(price.text!, font: 30, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.white, myColor().gray9(), 20, "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
