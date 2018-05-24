//
//  QZHFootPrintCell.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHFootPrintCell: UITableViewCell {
    @IBOutlet weak var pro1: QZHUIView!
    @IBOutlet weak var proImg1: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var icon1: QZHUILabelView!
    @IBOutlet weak var price1: QZHUILabelView!

    @IBOutlet weak var pro2: QZHUIView!
    @IBOutlet weak var proImg2: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var icon2: QZHUILabelView!
    @IBOutlet weak var price2: QZHUILabelView!
    
    @IBOutlet weak var pro3: QZHUIView!
    @IBOutlet weak var proImg3: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var icon3: QZHUILabelView!
    @IBOutlet weak var price3: QZHUILabelView!
    
    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!
    @IBOutlet weak var line3: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pro1.setupViews(x: 0, y: 0, width: 248*PX, height: 331*PX, bgColor: UIColor.white)
        pro2.setupViews(x: 251*PX, y: 0, width: 248*PX, height: 331*PX, bgColor: UIColor.white)
        pro3.setupViews(x: 502*PX, y: 0, width: 248*PX, height: 331*PX, bgColor: UIColor.white)
        
        proImg1.frame = CGRect(x:0,y:0,width:248*PX,height:249*PX)
        proImg1.image = UIImage(named:"loadPic")
        proImg2.frame = CGRect(x:0,y:0,width:248*PX,height:249*PX)
        proImg2.image = UIImage(named:"loadPic")
        proImg3.frame = CGRect(x:0,y:0,width:248*PX,height:249*PX)
        proImg3.image = UIImage(named:"loadPic")
        
        check1.frame = CGRect(x:201*PX,y:9*PX,width:38*PX,height:38*PX)
        check1.image = UIImage(named:"CarSel")
        check1.isHidden = true
        check2.frame = CGRect(x:201*PX,y:9*PX,width:38*PX,height:38*PX)
        check2.image = UIImage(named:"CarSel")
        check2.isHidden = true
        check3.frame = CGRect(x:201*PX,y:9*PX,width:38*PX,height:38*PX)
        check3.image = UIImage(named:"CarSel")
        check3.isHidden = true
        
        icon1.setLabelView(20*PX, 278*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        icon2.setLabelView(20*PX, 268*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        icon3.setLabelView(20*PX, 268*PX, 18*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 20, "¥")
        
        price1.setLabelView(38*PX, 268*PX, 160*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        price2.setLabelView(38*PX, 268*PX, 160*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        price3.setLabelView(38*PX, 268*PX, 160*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().redFf4300(), 28, "")
        
        line1.dividers(248*PX, y: 0, width: 3*PX, height: 333*PX, color: myColor().grayF0())
        line2.dividers(499*PX, y: 0, width: 3*PX, height: 333*PX, color: myColor().grayF0())
        line3.dividers(0*PX, y: 331*PX, width: SCREEN_WIDTH, height: 2*PX, color: myColor().grayF0())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
