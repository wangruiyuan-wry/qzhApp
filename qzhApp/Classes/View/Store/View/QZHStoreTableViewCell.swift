
//
//  QZHStoreTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/5.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHStoreTableViewCell: UITableViewCell {
    // 整体
    @IBOutlet weak var pro1: QZHUIView!
    @IBOutlet weak var pro2: QZHUIView!
    
    // 产品图片
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    // 产品名称
    @IBOutlet weak var name1: QZHUILabelView!
    @IBOutlet weak var name2: QZHUILabelView!
    
    // 价格符号
    @IBOutlet weak var priceIcon1: QZHUILabelView!
    @IBOutlet weak var priceIcon2: QZHUILabelView!
    
    // 价格
    @IBOutlet weak var price1: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    
    // 规格
    @IBOutlet weak var spec1: QZHUILabelView!
    @IBOutlet weak var spec2: QZHUILabelView!
    
    // 销售量
    @IBOutlet weak var sale1: QZHUILabelView!
    @IBOutlet weak var sale2: QZHUILabelView!

    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!

    override func awakeFromNib() {
        super.awakeFromNib()
        line1.dividers(374*PX, y: 0, width: 2*PX, height: 500*PX, color: myColor().grayF0())
        line2.dividers(0*PX, y: 500*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        
        // 产品模块
        pro1.setupViews(x: 0, y: 0, width: 374*PX, height: 500*PX, bgColor: UIColor.white)
        pro2.setupViews(x: 376*PX, y: 0, width: 374*PX, height: 500*PX, bgColor: UIColor.white)

        
        // 产品图片
        img1.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        img1.image = UIImage(named:"loadPic")
        img2.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        img2.image = UIImage(named:"loadPic")
        
        // 产品名称
        name1.setLabelView(20*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        name1.numberOfLines = 2
        name1.lineBreakMode = .byTruncatingTail
        name2.setLabelView(20*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        name2.numberOfLines = 2
        name2.lineBreakMode = .byTruncatingTail
        
        // 价格
        priceIcon1.setLabelView(20*PX, 440*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        priceIcon2.setLabelView(20*PX, 440*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        
        price1.setLabelView(40*PX, 440*PX, price1.autoLabelWidth(price1.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.white, myColor().redFf4300(), 28, "")
        
        
        price2.setLabelView(40*PX, 440*PX, price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.white, myColor().redFf4300(), 28, "")
        price2.setRealWages(price2.text!, big: 28, small: 20, fg: ".")
        price2.width = price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX)
        
        
        
        // 规格
        spec1.setLabelView(price1.x+price1.autoLabelWidth(price1.text!, font: 28, height: 40*PX), 447*PX,  spec1.autoLabelWidth(spec1.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
        spec2.setLabelView(price2.x+price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX), 447*PX,  spec2.autoLabelWidth(spec2.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
        
        // 销售量
        sale1.setLabelView(204*PX, 446*PX, 150*PX, 28*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 20, "")
        sale2.setLabelView(204*PX, 446*PX, 150*PX, 28*PX, NSTextAlignment.right, UIColor.white, myColor().Gray6(), 20, "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
