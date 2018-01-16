//
//  QZHUIButton+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHUIButton: UIButton {

    //设置带图标的按钮样式
    func setupButton(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat,_ textColor:UIColor,_ bgColor:UIColor,_ title:String,_ size:CGFloat,_ borderWidth:CGFloat,_ borderColor:UIColor,_ img:String,_ state:UIControlState,_ spacing:CGFloat,_ position:UIViewContentMode){
        self.frame = CGRect(x:x*PX,y:y*PX,width:width*PX,height:height*PX)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: size*PX)

        self.setTitleColor(textColor, for: state)
        self.backgroundColor = bgColor
        self.adjustsImageWhenHighlighted = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.set(image: UIImage(named:img),title: title,titlePosition:position,additionalSpacing: spacing,state: state)
    }

}
