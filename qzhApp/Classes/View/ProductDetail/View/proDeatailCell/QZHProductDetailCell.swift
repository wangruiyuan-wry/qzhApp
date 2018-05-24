//
//  QZHProductDetailCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/6.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHProductDetailCell: UITableViewCell {
    
    // 产品图片
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    // 产品名称
    @IBOutlet weak var proName1: QZHUILabelView!
    @IBOutlet weak var proName2: QZHUILabelView!
    
    // 分割线
    @IBOutlet weak var line: QZHUILabelView!
    @IBOutlet weak var line1: QZHUILabelView!
    
    // price ¥
    @IBOutlet weak var priceIcon1: QZHUILabelView!
    @IBOutlet weak var priceIcon2: QZHUILabelView!
    
    // 价格
    @IBOutlet weak var price1: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    
    // 单位
    @IBOutlet weak var unit1: QZHUILabelView!
    @IBOutlet weak var unit2: QZHUILabelView!
    
    // 已销售量
    @IBOutlet weak var sale1: QZHUILabelView!
    @IBOutlet weak var sale2: QZHUILabelView!
    
    // 设置产品遮罩层
    @IBOutlet weak var pro1: QZHUIView!
    @IBOutlet weak var pro2: QZHUIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置产品遮罩层
        pro1.setupViews(x: 0, y: 0, width: 374*PX, height: 470*PX, bgColor: UIColor.clear)
        pro2.setupViews(x: 376*PX, y: 0, width: 374*PX, height: 470*PX, bgColor: UIColor.clear)
        
        // 设置边框线
        line.text = ""
        line.dividers(0, y: 500*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        line1.text = ""
        line1.dividers(374*PX, y: 0, width: 2*PX, height: 500*PX, color:  myColor().grayF0())
        
        // 设置产品图片
        img1.frame = CGRect(x:20*PX,y:20*PX,width:335*PX,height:335*PX)
        img2.frame = CGRect(x:398*PX,y:20*PX,width:335*PX,height:335*PX)
        
        // 设置产品名称
        proName1.setLabelView(20*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        proName1.numberOfLines = 2
        proName1.text = ""
        proName1.lineBreakMode = .byTruncatingTail
        proName2.setLabelView(398*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        proName2.numberOfLines = 2
        proName2.text = ""
        proName2.lineBreakMode = .byTruncatingTail 
        
        // 设置销售量
        sale1.setLabelView(231*PX, 446*PX, 120*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        sale2.setLabelView(610*PX, 446*PX, 120*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        
        // 设置价格符号
        priceIcon1.setLabelView(20*PX, 440*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        priceIcon2.setLabelView(398*PX, 440*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        
        price1.setLabelView(40*PX, 440*PX, price1.autoLabelWidth(price1.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 28, "")
        price1.setRealWages(price1.text!, big: 28, small: 20, fg: ".")
        price1.numberOfLines = 2
        price1.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        price2.setLabelView(418*PX, 440*PX, price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 28, "")
        price2.setRealWages(price2.text!, big: 28, small: 20, fg: ".")
        price2.numberOfLines = 2
        price2.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        if price1.text == ""{
            //priceIcon1.isHidden = true
        }
        
        if price2.text == ""{
           // priceIcon2.isHidden = true
        }
        
        unit1.setLabelView(price1.x+price1.width, 447*PX,  unit1.autoLabelWidth(unit1.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
        unit2.setLabelView(price2.x+price2.width, 447*PX,  unit2.autoLabelWidth(unit2.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
