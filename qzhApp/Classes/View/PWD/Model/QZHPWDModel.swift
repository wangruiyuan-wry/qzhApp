//
//  QZHPWDModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/31.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHPWDModel:NSObject{
    struct paramers {
        // 手机号码
        static var phone:String = ""
        
        // 新的密码
        static var password:String = ""
        
        // 验证码
        static var authCode:String = ""
        
        // 页面跳转
        static var pageFrom:Bool = true
    }
    
}

extension QZHPWDModel{
    class var pageFrom: Bool {
        get{
            return paramers.pageFrom
        }
        set{
            paramers.pageFrom = newValue
        }
    }

    class var phone: String {
        get{
            return paramers.phone
        }
        set{
            paramers.phone = newValue
        }
    }
    class var password: String {
        get{
            return paramers.password
        }
        set{
            paramers.password = newValue
        }
    }
    class var authCode: String {
        get{
            return paramers.authCode
        }
        set{
            paramers.authCode = newValue
        }
    }
}
