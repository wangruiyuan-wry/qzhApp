//
//  QZHrResultProListCell.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/18.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHrResultProListCell: UITableViewCell {

    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!
    
    @IBOutlet weak var pro1: QZHUIView!
    @IBOutlet weak var proImg1: UIImageView!
    @IBOutlet weak var icon1: QZHUILabelView!
    @IBOutlet weak var price1: QZHUILabelView!
    @IBOutlet weak var unit1: QZHUILabelView!
    @IBOutlet weak var saleNum1: QZHUILabelView!
    @IBOutlet weak var proName1: QZHUILabelView!
    
    @IBOutlet weak var pro2: QZHUIView!
    @IBOutlet weak var proImg2: UIImageView!
    @IBOutlet weak var icon2: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    @IBOutlet weak var unit2: QZHUILabelView!
    @IBOutlet weak var saleNum2: QZHUILabelView!
    @IBOutlet weak var proName2: QZHUILabelView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        line1.dividers(0, y: 501*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        line2.dividers(374*PX, y: 0, width: 2*PX, height: 501*PX, color: myColor().grayF0())
        
        pro1.setupViews(x: 0, y: 0, width: 374*PX, height: 502*PX, bgColor: UIColor.white)
        pro2.setupViews(x: 376*PX, y: 0, width: 374*PX, height: 502*PX, bgColor: UIColor.white)
        
        proImg1.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        proImg1.image = UIImage(named:"loadPic")
        
        proImg2.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        proImg2.image = UIImage(named:"loadPic")
        
        proName1.setLabelView(20*PX, 365*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        proName1.numberOfLines = 2
        proName1.lineBreakMode = .byTruncatingTail
        proName2.setLabelView(20*PX, 365*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        proName2.numberOfLines = 2
        proName2.lineBreakMode = .byTruncatingTail 
        
        icon1.setLabelView(20*PX, 448*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        icon2.setLabelView(20*PX, 448*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        
        price1.setLabelView(38*PX, 440*PX, price1.autoLabelWidth(price1.text!, font: 30, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        price2.setLabelView(38*PX, 440*PX, price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        
        unit1.setLabelView(price1.x + price1.autoLabelWidth(price1.text!, font: 28, height: 40*PX) , 446*PX, 40*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "")
        unit2.setLabelView(price2.x + price2.autoLabelWidth(price2.text!, font: 28, height: 40*PX) , 446*PX, 40*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "")
        
        saleNum1.setLabelView(180*PX, 448*PX, 173*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        saleNum2.setLabelView(180*PX, 448*PX, 173*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
