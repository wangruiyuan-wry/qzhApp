//
//  QZHRegisterModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/30.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHRegisterModel:NSObject{
    
    struct paramers {
        // 手机号
        static var phone:String = ""
        
        // 验证码
        static var authCode:String = ""
        
        // 密码
        static var password:String = ""
        
        // 公司名称
        static var companyName:String = ""
        
        // 个人昵称
        static var nickName:String = ""
        
        static var reffer:Int = 0
    }
}

extension QZHRegisterModel{
    class var reffer: Int {
        get{
            return paramers.reffer
        }
        set{
            paramers.reffer = newValue
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
    class var authCode:String{
        get{
            return paramers.authCode
        }
        set{
            paramers.authCode = newValue
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
    class var companyName:String{
        get{
            return paramers.companyName
        }
        set{
            paramers.companyName = newValue
        }
        
    }
    class var nickName:String{
        get{
            return paramers.nickName
        }
        set{
            paramers.nickName = newValue
        }
    }
}
