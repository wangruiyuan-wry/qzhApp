//
//  QZHMarketCompanyCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHMarketCompanyCell: UITableViewCell {

    // 公司logo
    @IBOutlet weak var companyLogo: UIImageView!
    
    // 分割线
    @IBOutlet weak var line: QZHUILabelView!
    
    // 公司名称
    @IBOutlet weak var companyName: QZHUILabelView!
    
    // 主营产品层
    @IBOutlet weak var proView: QZHUIView!
    
    // 小图标
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var addressIcon: UIImageView!
    
    // 电话
    @IBOutlet weak var phone: QZHUILabelView!
    
    // 地址
    @IBOutlet weak var address: QZHUILabelView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 公司图片
        companyLogo.frame = CGRect(x:26*PX,y:19*PX,width:200*PX,height:200*PX)
        companyLogo.image = UIImage(named:"loadPic")
        
        // 公司名称
        companyName.setLabelView(260*PX, 21*PX, 470*PX, 42*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 30, "")
        companyName.lineBreakMode = .byTruncatingTail
        
        // 主营产品层
        proView.setupViews(x: 260*PX, y: 86*PX, width: 470*PX, height: 28*PX, bgColor: UIColor.white)
        
        // 电话
        phoneIcon.frame = CGRect(x:260*PX,y:142*PX,width:24*PX,height:24*PX)
        phoneIcon.image = UIImage(named:"Market_PhoneIcon")
        phone.setLabelView(294*PX, 137*PX, 436*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray4(), 24, "")
        
        // 地址
        addressIcon.frame = CGRect(x:266*PX,y:192*PX,width:18*PX,height:24*PX)
        addressIcon.image = UIImage(named:"Market_AddressIcon")
        address.setLabelView(294*PX, 187*PX, 436*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "")
        address.numberOfLines = 1
        address.lineBreakMode = .byTruncatingTail 
        
        // 分割线
        line.dividers(20*PX, y: 249*PX, width: 710*PX, height: 1*PX, color: myColor().grayEB())
    }
    
    func setupPro(_ pro:[String]){
        var x:CGFloat = 0.0

        for p in pro{
            let proLabel:QZHUILabelView = QZHUILabelView()
            let proWidth = proLabel.autoLabelWidth(p, font: 20, height: 28*PX)+20*PX
            proLabel.setLabelView(x + 8*PX, 0, proWidth, 28*PX, NSTextAlignment.center, myColor().GrayF1F2F6(), myColor().gray5f(), 20, p)
            proLabel.layer.cornerRadius = 4*PX
            proLabel.layer.masksToBounds = true
            x = x + proLabel.x + proWidth
            if x > 470*PX{
                break
            }else{
                proView.addSubview(proLabel)
            }
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
