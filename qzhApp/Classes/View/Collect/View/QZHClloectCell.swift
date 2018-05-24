//
//  QZHClloectCell.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHClloectCell: UITableViewCell {

    @IBOutlet weak var proImg1: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var icon1: QZHUILabelView!
    @IBOutlet weak var sellPrice1: QZHUILabelView!
    @IBOutlet weak var unit1: QZHUILabelView!
    @IBOutlet weak var sales1: QZHUILabelView!
    @IBOutlet weak var proName1: QZHUILabelView!
    @IBOutlet weak var pro1: QZHUIView!
    
    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!
    
    @IBOutlet weak var proImg2: UIImageView!
    @IBOutlet weak var proName2: QZHUILabelView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var icon2: QZHUILabelView!
    @IBOutlet weak var sellPrice2: QZHUILabelView!
    @IBOutlet weak var unit2: QZHUILabelView!
    @IBOutlet weak var sales2: QZHUILabelView!
    @IBOutlet weak var pro2: QZHUIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        line1.dividers(374*PX, y: 0, width: 2*PX, height: 500*PX, color: myColor().grayF0())
        line2.dividers(0*PX, y: 500*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        
        proImg1.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        proImg1.image = UIImage(named:"loadPic")
        proImg2.frame = CGRect(x:20*PX,y:20*PX,width:334*PX,height:334*PX)
        proImg2.image = UIImage(named:"loadPic")
        
        proName1.setLabelView(20*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        proName1.numberOfLines = 2
        proName1.lineBreakMode = .byTruncatingTail
        
        proName2.setLabelView(20*PX, 364*PX, 328*PX, 70*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        proName2.numberOfLines = 2
        proName2.lineBreakMode = .byTruncatingTail 
        
        icon1.setLabelView(20*PX, 447*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 20, "¥")
        icon2.setLabelView(20*PX, 447*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().redFf4300(), 20, "¥")
        
        sellPrice1.setLabelView(38*PX, 438*PX, sellPrice1.autoLabelWidth(sellPrice1.text!, font: 30, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28*PX, "")
        sellPrice2.setLabelView(38*PX, 438*PX, sellPrice2.autoLabelWidth(sellPrice2.text!, font: 30, height: 40*PX), 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28*PX, "")
        
        unit1.setLabelView(sellPrice1.x+sellPrice1.width, 447*PX, 50*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().Gray6(), 20, "")
        unit2.setLabelView(sellPrice2.x+sellPrice2.width, 447*PX, 50*PX, 28*PX, NSTextAlignment.left, UIColor.white, myColor().Gray6(), 20, "")
        
        sales1.setLabelView(180*PX, 446*PX, 173*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        sales2.setLabelView(180*PX, 446*PX, 173*PX, 28*PX, NSTextAlignment.right, UIColor.clear, myColor().Gray6(), 20, "")
        
        
        pro1.setupViews(x: 0, y: 0, width: 374*PX, height: 500*PX, bgColor: UIColor.clear)
        pro2.setupViews(x: 376*PX, y: 0, width: 374*PX, height: 500*PX, bgColor: UIColor.clear)

        check1.frame = CGRect(x:307*PX,y:29*PX,width:38*PX,height:38*PX)
        check1.tag = 2
        check1.isHidden = true
        check1.image = UIImage(named:"CarSel")
        
        check2.frame = CGRect(x:307*PX,y:29*PX,width:38*PX,height:38*PX)
        check2.tag = 2
        check2.isHidden = true
        check2.image = UIImage(named:"CarSel")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }
    
}
