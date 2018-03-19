//
//  QZH_CYSQCarTableViewHeader.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/13.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZH_CYSQCarTableViewHeader: UIView {
    
    // 分割线
    var line:QZHUILabelView = QZHUILabelView()
    
    // 跳转至详情按钮
    var detailBtn: UIButton! = UIButton()
    
    // 店铺名称
    var storeName: QZHUILabelView! = QZHUILabelView()
    
    // 店铺图标
    var storeIcon: UIImageView! = UIImageView()
    
    // 选择按钮
    var chooseBtn: UIButton! = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        chooseBtn.frame = CGRect(x:0,y:0,width:75*PX,height:81*PX)
        chooseBtn.setImage(UIImage(named:"CarSel"), for: .normal)
        chooseBtn.layer.cornerRadius = 17.5*PX
        chooseBtn.layer.masksToBounds = true
        self.addSubview(chooseBtn)
        
        storeIcon.frame = CGRect(x:75*PX,y:24*PX,width:35*PX,height:33*PX)
        storeIcon.image = UIImage(named:"CarStoreIcon")
        self.addSubview(storeIcon)
        
        self.backgroundColor = UIColor.white
        
        line.dividers(0, y: 81*PX, width: SCREEN_WIDTH, height: 1*PX, color:myColor().grayF0())
        self.addSubview(line)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStoreName(_ str:String){
        storeName.setLabelView(130*PX, 22*PX, 300*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, str)
        storeName.width = storeName.autoLabelWidth(storeName.text!, font: 26, height: 37*PX)
        self.addSubview(storeName)
        
        detailBtn.frame = CGRect(x:storeName.x + storeName.width,y:0,width:40*PX,height:81*PX)
        detailBtn.setImage(UIImage(named:"rightIcon"), for: .normal)
        self.addSubview(detailBtn)
    }
    
    func setupOrderListHeaderStoreName(_ str:String){
        storeName.setLabelView(75*PX, 22*PX, 300*PX, 37*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 26, str)
        storeName.width = storeName.autoLabelWidth(storeName.text!, font: 26, height: 37*PX)
        self.addSubview(storeName)
        
        detailBtn.frame = CGRect(x:storeName.x + storeName.width,y:0,width:40*PX,height:81*PX)
        detailBtn.setImage(UIImage(named:"rightIcon"), for: .normal)
        self.addSubview(detailBtn)

        chooseBtn.isHidden = true
        storeIcon.x = 20*PX
    }

}
