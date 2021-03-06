//
//  QZHCommon.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

//MARK: - 全局通知定义

/// 用户需要登录通知
let QZHUserShouldLoginNotification = "QZHUserShouldLoginNotification"
var accessToken:String? = ""

public let SCREEN_WIDTH=UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT=UIScreen.main.bounds.size.height

public let PX = SCREEN_WIDTH/750

public let pageFlag:Bool = false

//public let httpURL = "https://www.sceo360.com/api/"
public let httpURL = "https://www.qzh360.com/api/"
//public let httpURL = "http://192.168.120.164:8100/api/"
//public let httpURL = "http://192.168.120.234:8100/api/"

//public let httpURL = "http://192.168.100.71:8100/api/"

//public let httpURL = "http://192.168.120.234:8100/"
//public let httpURL = "http://192.168.120.14:8100/"

public extension UIView {
    
    // MARK: 添加渐变色图层
    public func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any]) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

func setStatusBarBackgroundColor(color : UIColor) {
    let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
    let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        statusBar.backgroundColor = color
    }
}

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}
