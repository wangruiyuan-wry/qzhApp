//
//  QZHAddressManageTableViewCell.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/21.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHAddressManageTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: QZHUILabelView!
    @IBOutlet weak var addressLabel: QZHUILabelView!
    @IBOutlet weak var line1: QZHUILabelView!
    @IBOutlet weak var phoneLabel: QZHUILabelView!
    @IBOutlet weak var delBtn: QZHUIView!
    @IBOutlet weak var delImg: UIImageView!
    @IBOutlet weak var delLabel: QZHUILabelView!
    @IBOutlet weak var editBtn: QZHUIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editLabel: QZHUILabelView!
    @IBOutlet weak var defaultBtn: QZHUIView!
    @IBOutlet weak var defaultImg: UIImageView!
    @IBOutlet weak var defaultLabel: QZHUILabelView!
    @IBOutlet weak var line2: QZHUILabelView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // 收货人姓名
        nameLabel.setLabelView(20*PX, 25*PX, 210*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "")
        
        // 收货人电话
        phoneLabel.setLabelView(430*PX, 25*PX, 300*PX, 37*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 26, "")
        
        // 地址
        addressLabel.setLabelView(20*PX, 72*PX, 710*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, "")
        
        // 分割线
        line1.dividers(0, y: 131*PX, width:750*PX, height: 1*PX, color: myColor().grayF0())
        line2.dividers(0, y: 212*PX, width:750*PX, height: 20*PX, color: myColor().grayF0())
        
        // 默认地址
        defaultBtn.setupViews(x: 20*PX, y: 132*PX, width: 220*PX, height: 80*PX, bgColor: UIColor.white)
        defaultImg.frame = CGRect(x:0*PX,y:22*PX,width:37*PX,height:37*PX)
        defaultImg.image = UIImage(named:"CarSel")
        defaultLabel.setLabelView(45*PX, 24*PX, 120*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "默认地址")
        
        // 编辑
        editBtn.setupViews(x: 524*PX, y: 132*PX, width: 90*PX, height: 80*PX, bgColor: UIColor.white)
        editImg.frame = CGRect(x:3*PX,y:27*PX,width:25*PX,height:26*PX)
        editImg.image = UIImage(named:"editAddress")
        editLabel.setLabelView(35*PX, 24*PX, 55*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "编辑")
        
        // 删除
        delBtn.setupViews(x: 637*PX, y: 132*PX, width: 90*PX, height: 80*PX, bgColor: UIColor.white)
        delImg.frame = CGRect(x:5*PX,y:27*PX,width:25*PX,height:26*PX)
        delImg.image = UIImage(named:"delAddress")
        delLabel.setLabelView(40*PX, 24*PX, 50*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "删除")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
