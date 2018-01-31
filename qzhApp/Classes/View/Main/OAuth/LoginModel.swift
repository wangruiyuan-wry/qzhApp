//
//  LoginModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class LoginModel: NSObject {
    
    // 登录之后 token
    var token:String = ""
    
    struct paramers {
        // 用户名／账号
        static var userName:String = ""
        
        // 密码
        static var passWord:String = ""
        
        // 验证码
        static var authCode:String = ""
    }
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

extension LoginModel{
    class var userName: String {
        get{
            return paramers.userName
        }
        set{
            paramers.userName = newValue
        }
    }
    
    class var passWord: String {
        get{
            return paramers.passWord
        }
        set{
            paramers.passWord = newValue
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
