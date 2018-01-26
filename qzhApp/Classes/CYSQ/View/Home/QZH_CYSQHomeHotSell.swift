//
//  QZH_CYSQHomeHotSell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/25.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZH_CYSQHomeHotSell: UITableViewCell {
    @IBOutlet weak var icon1: QZHUILabelView!
    @IBOutlet weak var icon2: QZHUILabelView!
    @IBOutlet weak var zy1: QZHUILabelView!
    @IBOutlet weak var zy2: QZHUILabelView!

    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var name1: QZHUILabelView!
    @IBOutlet weak var price1: QZHUILabelView!
    @IBOutlet weak var unit1: QZHUILabelView!
    @IBOutlet weak var name2: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    @IBOutlet weak var unit2: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        line1.text=""
        line1.dividers(0, y: 470*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        
        line2.text = ""
        line2.dividers(374*PX, y: 0, width: 2*PX, height: 471*PX, color: myColor().grayF0())
        
        img1.frame = CGRect(x:16*PX,y:10*PX,width:310*PX,height:310*PX)
        img1.image = UIImage(named:"loadPic")
        
        img2.frame = CGRect(x:404*PX,y:10*PX,width:310*PX,height:310*PX)
        img2.image = UIImage(named:"loadPic")
        
        zy1.setLabelView(43*PX, 354*PX, zy1.autoLabelWidth(zy1.text!, font: 18, height: 23*PX), 23*PX, NSTextAlignment.center, UIColor(red:255/255,green:231/255,blue:243/255,alpha:1), UIColor(red:255/255,green:0/255,blue:0/255,alpha:1), 18, "")
        zy1.layer.borderColor = UIColor(red:255/255,green:0/255,blue:0/255,alpha:1).cgColor
        zy1.layer.borderWidth = 1*PX
        zy1.layer.cornerRadius = 4*PX
        zy1.clipsToBounds = true
    
            
        zy2.setLabelView(411*PX, 354*PX, zy2.autoLabelWidth(zy2.text!, font: 18, height: 23*PX), 23*PX, NSTextAlignment.center, UIColor(red:255/255,green:231/255,blue:243/255,alpha:1), UIColor(red:255/255,green:0/255,blue:0/255,alpha:1), 18, "自营")
        zy2.layer.borderColor = UIColor(red:255/255,green:0/255,blue:0/255,alpha:1).cgColor
        zy2.layer.borderWidth = 1*PX
        zy2.layer.cornerRadius = 4*PX
        zy2.clipsToBounds = true
        
        name1.setLabelView(zy1.x+zy1.width, 330*PX, 296*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        if zy1.text == ""{
            zy1.isHidden = true
            name1.x = 43*PX
        }
        name2.setLabelView(zy2.x+zy2.width, 330*PX, 296*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        if zy2.text == ""{
            zy2.isHidden = true
            name2.x = 411*PX
        }
        
        icon1.setLabelView(43*PX, 413*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")
        icon2.setLabelView(411*PX, 413*PX, 20*PX, 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 20, "¥")        
        
        price1.setLabelView(63*PX, 411*PX, price1.autoLabelWidth(price1.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 28, "")
        price1.setRealWages(price1.text!, big: 28, small: 20, fg: ".")
        price1.numberOfLines = 2
        price1.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        price2.setLabelView(431*PX, 411*PX, price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.center, UIColor.clear, myColor().redFf4300(), 28, "")
        price2.setRealWages(price2.text!, big: 28, small: 20, fg: ".")
        price2.numberOfLines = 2
        price2.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        unit1.setLabelView(price1.x+price1.width, 418*PX,  unit1.autoLabelWidth(unit1.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
        unit2.setLabelView(price2.x+price2.width, 418*PX,  unit2.autoLabelWidth(unit2.text!, font: 20, height: 28*PX), 28*PX, NSTextAlignment.center, UIColor.clear, myColor().Gray6(), 20, "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
