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

// 店铺小计
class QZH_CYSQCarTableViewFooter:UIView{

    var lyText:UITextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTotal(count:String,total:String){
        let footView:QZHUIView = QZHUIView()
        footView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 162*PX, bgColor: UIColor.white)
        self.addSubview(footView)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, 24*PX, 130*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "买家留言：")
        footView.addSubview(title)
        
        lyText.frame = CGRect(x:160*PX,y:23*PX,width:570*PX,height:35*PX)
        lyText.placeholder = "选填"
        footView.addSubview(lyText)
        //lyText.borderStyle=UITextBorderStyle.none
        lyText.textAlignment = .left
        lyText.contentVerticalAlignment = .center
        lyText.becomeFirstResponder()
        lyText.resignFirstResponder()
        lyText.setValue(UIFont.systemFont(ofSize: 24*PX), forKeyPath: "_placeholderLabel.font")
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(20*PX, y: 80*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        footView.addSubview(line1)
        
        let totalLabel:QZHUILabelView = QZHUILabelView()
        totalLabel.setLabelView(730*PX - totalLabel.autoLabelWidth(total, font: 45, height: 50*PX), 99*PX, totalLabel.autoLabelWidth(total, font: 45, height: 50*PX), 50*PX, NSTextAlignment.center, UIColor.white, myColor().redFf4300(), 34, total)
        let totalWidth = totalLabel.autoLabelWidth(total, font: 45, height: 50*PX)
        totalLabel.setRealWages(total, big: 34, small: 28, fg: ".")
        footView.addSubview(totalLabel)
        
        let priceIcon:QZHUILabelView = QZHUILabelView()
        priceIcon.setLabelView(710*PX - totalWidth, 109*PX, 20*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().redFf4300(), 28, "¥")
        footView.addSubview(priceIcon)
        
        let totalTitle:QZHUILabelView = QZHUILabelView()
        totalTitle.setLabelView(630*PX - totalWidth, 105*PX, 80*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "小计:")
        footView.addSubview(totalTitle)
        
        let numLabel:QZHUILabelView = QZHUILabelView()
        
        numLabel.setLabelView(0 , 105*PX, 120*PX, 33*PX, NSTextAlignment.right, UIColor.white, myColor().gray3(), 24, "共\(count)件商品")
        let numWidth = numLabel.autoLabelWidth(numLabel.text!, font: 34, height: 33*PX)
        numLabel.width = 625*PX - totalWidth
        footView.addSubview(numLabel)
    }
}
