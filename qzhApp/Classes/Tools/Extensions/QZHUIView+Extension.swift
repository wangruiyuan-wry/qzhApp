//
//  QZHUIView+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHUIView: UIView {
    
    //设置带背景色的view容器
    func setupView(x:Int,y:Int,width:Int,height:Int,bgColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=bgColor
    }
    
    func setupViews(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,bgColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=bgColor
    }
    
    //黑色透明背景层
    func blackBackground(y:CGFloat,width:CGFloat,height:CGFloat){
        self.setupView(x:0, y: Int(y), width: Int(width), height: Int(height), bgColor: UIColor.black)
        self.backgroundColor=UIColor(red:0/255,green:0/255,blue:0/255,alpha:0.5)
        self.isHidden=true
    }
    
    // 操作结果
    func opertionSuccess(_ title:String,_ isSuccess:Bool){
        self.setupViews(x: 250*PX, y: 593*PX, width: 250*PX, height: 150*PX, bgColor: UIColor.black)
        self.alpha = 0.5
        let icon:UIImageView = UIImageView(frame:CGRect(x:97*PX,y:34*PX,width:46*PX,height:33*PX))
        if isSuccess{
            icon.image = UIImage(named:"Market_Collect_Success")
        }else{
            icon.image = UIImage(named:"Market_Collect_Failed")
        }
        self.addSubview(icon)
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(0, 85*PX, 250*PX, 40*PX, NSTextAlignment.center, UIColor.clear, UIColor.white, 28, title)
        self.addSubview(label)
        //self.isHidden = true
    }
    
    // 隐藏操作结果
    func ycOpertion(){
        self.isHidden = true
    }
    
    // 设置暂无产品
    func setupNoList(y:CGFloat,str:String){
        self.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 211*PX, bgColor: UIColor.white)
        self.isHidden = true
        
        //
        let pic:UIImageView = UIImageView(frame:CGRect(x:296*PX,y:85*PX,width:158*PX,height:152*PX))
        pic.image = UIImage(named:"Market_noCompany")
        self.addSubview(pic)
        
        let nolabel:QZHUILabelView = QZHUILabelView()
        nolabel.setLabelView(229*PX, 270*PX, 292*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 36, str)
        nolabel.alpha = 0.5
        self.addSubview(nolabel)
    }

    
}

func getCurrentViewController() -> UIViewController {
    var result = UIViewController()
    
    var window = UIApplication.shared.keyWindow
    if window?.windowLevel != UIWindowLevelNormal {
        let windows = UIApplication.shared.windows
        for temp in windows {
            if temp.windowLevel == UIWindowLevelNormal {
                window = temp
                break
            }
        }
    }
    
    if let appRootVC = window?.rootViewController {
        if let frontView = window?.subviews.first {
            if var nextResponder = frontView.next  {
                if let _ = appRootVC.presentedViewController {
                    nextResponder = appRootVC.presentedViewController!
                }
                
                if nextResponder is UITabBarController {
                    let tabbar = nextResponder as! UITabBarController
                    let nav = tabbar.viewControllers![tabbar.selectedIndex] as! UINavigationController
                    result = nav.childViewControllers.last!
                } else if nextResponder is UINavigationController {
                    let nav = nextResponder as! UINavigationController
                    result = nav.childViewControllers.last!
                } else {
                    result = nextResponder as! UIViewController
                }
            }
        }
    }
    return result
}

extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}
