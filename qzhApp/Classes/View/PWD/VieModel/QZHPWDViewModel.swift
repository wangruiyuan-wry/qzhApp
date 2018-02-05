//
//  QZHPWDViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/31.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHPWDViewModel:NSObject{

    // 获取验证码
    func getAuthCode(completion:@escaping (_ resultText:String,_ getAuthCode:Bool ,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/genForgotCode/\(QZHPWDModel.phone)", params: [:]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("发送成功", true, isSuccess)
            }else{
                completion(result["data"] as! String, false, isSuccess)
            }
        }
    }
    
    // 验证验证码
    func verifyAuthCode(completion:@escaping (_ resultText:String,_ getAuthCode:Bool ,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/verifyMobileCode", params: ["phone":QZHPWDModel.phone as AnyObject,"authCode":QZHPWDModel.authCode as AnyObject]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("验证成功", true, isSuccess)
            }else{
                completion(result["msg"] as! String, false, isSuccess)
            }
        }
    }
    
    // 修改密码
    func editPWD(completion:@escaping (_ resultText:String,_ getAuthCode:Bool ,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/editUserPass", params: ["phone" : QZHPWDModel.phone as AnyObject,"password":QZHPWDModel.password as AnyObject]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("验证成功", true, isSuccess)
            }else{
                completion(result["msg"] as! String, false, isSuccess)
            }
        }
    }
    
}
