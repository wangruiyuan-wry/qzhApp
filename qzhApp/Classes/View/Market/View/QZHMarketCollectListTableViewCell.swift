//
//  QZHMarketCollectListTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHMarketCollectListTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: QZHUILabelView!
    @IBOutlet weak var compantPro: QZHUILabelView!
    @IBOutlet weak var person: QZHUILabelView!
    @IBOutlet weak var line: QZHUILabelView!
    @IBOutlet weak var status: QZHUILabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        companyLogo.frame = CGRect(x:20*PX,y:20*PX,width:130*PX,height:130*PX)
        companyLogo.image = UIImage(named:"loadPic")
        
        companyName.setLabelView(170*PX, 20*PX, 560*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 30, "")
        
        compantPro.setLabelView(170*PX, 72*PX, 560*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        
        person.setLabelView(170*PX, 115*PX, 420*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        
        status.setLabelView(610*PX, 115*PX, 120*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().blue007aff(), 24, "")
        status.alpha = 0.5
        
        line.dividers(0, y: 170*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
