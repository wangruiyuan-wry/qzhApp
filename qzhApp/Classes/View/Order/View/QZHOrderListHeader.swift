//
//  QZHOrderListHeader.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHOrderListHeader: UIView {

    // 店铺图标
    var storeIcon:UIImageView = UIImageView()
    
    // 店铺名称
    var storeName: QZHUILabelView! = QZHUILabelView()
    
    // 箭头图标
    var rightIcon:UIButton = UIButton()
    
    // 订单状态
    var orderStatus:QZHUILabelView = QZHUILabelView()
    
    // 
    var shop:QZHUIView = QZHUIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        storeIcon.frame = CGRect(x:20*PX,y:24*PX,width:35*PX,height:33*PX)
        storeIcon.image = UIImage(named:"CarStoreIcon")
        self.addSubview(storeIcon)
        
        
        rightIcon.frame = CGRect(x:100*PX,y:0,width:40*PX,height:81*PX)
        rightIcon.setImage(UIImage(named:"rightIcon"), for: .normal)
        self.addSubview(rightIcon)
        
        orderStatus.setLabelView(550*PX, 24*PX, 180*PX, 33*PX, NSTextAlignment.right, UIColor.clear, myColor().blue007aff(), 24, "")
        self.addSubview(orderStatus)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 80*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayF0())
        self.addSubview(line)        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStoreName(_ str:String,_ status:String){
        storeName.setLabelView(75*PX, 22*PX, storeName.autoLabelWidth(str, font: 28, height: 37*PX), 37*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 26, str)
        self.addSubview(storeName)
        
        rightIcon.x = 75*PX + storeName.autoLabelWidth(str, font: 26, height: 37*PX)
        shop.setupViews(x: 0, y: 0, width: rightIcon.x + rightIcon.width, height: 80*PX, bgColor: UIColor.clear)
        self.addSubview(shop)
        orderStatus.text = status
    }

}
