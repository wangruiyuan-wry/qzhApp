//
//  QZHRegisterViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/30.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHRegisterViewModel:NSObject{
    
    // 获取验证码
    func getAuthCode(completion:@escaping (_ resultText:String,_ getAuthCode:Bool ,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/genMobileCode/\(QZHRegisterModel.phone)", params: [:]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("发送成功", true, isSuccess)
            }else{
                completion(result["data"]as! String, false, isSuccess)
            }
        }
    }
    
    // 注册
    func register(completion:@escaping (_ resultText:String,_ getAuthCode:Bool ,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/register", params: ["phone":QZHRegisterModel.phone as AnyObject,"authCode":QZHRegisterModel.authCode as AnyObject,"password":QZHRegisterModel.password as AnyObject,"companyName":QZHRegisterModel.companyName as AnyObject,"nickName":QZHRegisterModel.nickName as AnyObject,"referrer":QZHRegisterModel.reffer as AnyObject]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("注册成功", true, isSuccess)
            }else{
                completion(result["msg"] as! String , false, isSuccess)
            }
        }
    }
    
}
