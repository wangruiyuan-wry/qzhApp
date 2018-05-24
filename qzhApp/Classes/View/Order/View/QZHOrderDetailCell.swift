//
//  QZHOrderDetailCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHOrderDetailCell: UITableViewCell {

    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proNAme: QZHUILabelView!
    @IBOutlet weak var proSpec: QZHUILabelView!
    @IBOutlet weak var priceIcon: QZHUILabelView!
    @IBOutlet weak var proprice: QZHUILabelView!
    @IBOutlet weak var oldPrice: QZHUILabelView!
    @IBOutlet weak var count: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        
        line.dividers(0, y: 180*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        
        proImg.frame = CGRect(x:20*PX,y:10*PX,width:160*PX,height:160*PX)
        proImg.image = UIImage(named:"loadpic")
        
        proNAme.setLabelView(200*PX, 20*PX, 496*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, "")
        proNAme.numberOfLines = 2
        proNAme.lineBreakMode = .byTruncatingTail 
        
        proSpec.setLabelView(200*PX, 91*PX, 496*PX, 33*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 24, "")
        
        priceIcon.setLabelView(200*PX, 139*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        
        proprice.setLabelView(218*PX, 129*PX, proprice.autoLabelWidth(proprice.text!, font: 38, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        
        oldPrice.setLabelView(proprice.width+proprice.x, 139*PX, oldPrice.autoLabelWidth(oldPrice.text!, font: 30*PX, height: 28*PX), 28*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 20, "")
        
        count.setLabelView(550*PX, 134*PX, 180*PX, 33*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 24, "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
