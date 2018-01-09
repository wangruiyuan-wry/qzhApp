//
//  UIBarButtonItem+Extensions.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /// 创建 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - img: img
    ///   - fontSize: fontSize ,默认16
    ///   - target: target
    ///   - action: action
    convenience init(title:String,img:String,fontSize:CGFloat = 16,target:AnyObject,action:Selector) {
        /// 消息按钮
        var btn:UIButton=UIButton()
        if  img == "" && title == ""{
            btn = PublicFunction().btn_right_chat()
        }else if img == "back_pageIcon" && title == ""{
            btn.frame = CGRect(x:0,y:0,width:Int(PX*24),height:Int(PX*42))
            var img=UIImage(named:img)
            img=img?.specifiesWidth(15)
            btn.setImage(img, for:.normal)
        }else if img==""{
            btn.frame = CGRect(x:0,y:0,width:20,height:20)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.gray, for: .normal)
            btn.titleLabel?.font=UIFont.init(name: "Zapfino", size: 10)
        }else if title == ""{
            btn.frame = CGRect(x:0,y:0,width:20,height:20)
            var img=UIImage(named:img)
            img=img?.specifiesWidth(15)
            btn.setImage(img, for:.normal)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        //self.inint实例化 UIBarButtonItem
        self.init(customView:btn)
    }
}
