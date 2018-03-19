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
