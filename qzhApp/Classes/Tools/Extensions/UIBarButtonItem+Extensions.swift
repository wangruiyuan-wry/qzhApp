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
    convenience init(title:String,img:String,fontSize:CGFloat = 16,target:AnyObject,action:Selector,color:UIColor = myColor().gray3()) {
        /// 消息按钮
        var btn:UIButton=UIButton()
        if  img == "" && title == ""{
            btn = PublicFunction().btn_right_chat()
        }else if img == "back_pageIcon" && title == ""{//back_pageIcon1
            btn.frame = CGRect(x:Int(30*PX),y:20,width:Int(PX*20),height:Int(PX*35))
            btn.setImage(UIImage(named:img), for:.normal)
            btn.contentMode = .center
        }else if img == "back_pageIcon1" && title == ""{
            btn.frame = CGRect(x:Int(30*PX),y:20,width:Int(PX*20),height:Int(PX*35))
            btn.setImage(UIImage(named:img), for:.normal)
            btn.contentMode = .center
        }else if img == "back_pageIcon2" && title == ""{
            btn.frame = CGRect(x:Int(30*PX),y:20,width:Int(PX*20),height:Int(PX*35))
            btn.setImage(UIImage(named:img), for:.normal)
            btn.contentMode = .center
        }else if img==""{
            btn.frame = CGRect(x:0,y:0,width:55*PX,height:20)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.gray, for: .normal)
            btn.titleLabel?.font=UIFont.systemFont(ofSize: 26*PX)
        }else if title == ""{
            btn.frame = CGRect(x:0,y:0,width:20,height:20)
            var img=UIImage(named:img)
            img=img?.specifiesWidth(15)
            btn.setImage(img, for:.normal)
        }else if img != "" && title != ""{
            var img = UIImage(named:img)
            img = img?.specifiesWidth(35*PX)
            btn=UIButton(frame:CGRect(x:0,y:13*PX,width:45*PX,height:60*PX))
            
            btn.setTitleColor(color, for: .normal)
            btn.titleLabel?.font=UIFont.systemFont(ofSize: 6)
            
            btn.set(image: img, title: title, titlePosition: .bottom,additionalSpacing: 0, state: .normal)
            btn.imageEdgeInsets=UIEdgeInsetsMake(-5, 2, 0, 2)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        //self.inint实例化 UIBarButtonItem
        self.init(customView:btn)
    }
}
