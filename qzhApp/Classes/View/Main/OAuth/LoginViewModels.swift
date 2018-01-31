//
//  LoginViewModels.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class LoginViewModels: NSObject {
    
    lazy var UserList = [LoginViewModel]()
    
    /// 登录
    ///
    /// - Parameter completion: completion description
    func Login(completion:@escaping (_ resultText:String,_ login:Bool ,_ isSuccess:Bool)->()){

    QZHNetworkManager.shared.statusList(method: .POST, url: "user/login", params: ["username":LoginModel.userName as AnyObject,"password":LoginModel.passWord as AnyObject,"authCode":LoginModel.authCode as AnyObject]) { (result, isSuccess) in
            if result["status"] as! Int == 200{
                completion("登录成功", true, isSuccess)
                accessToken = (result["data"] as! [String:AnyObject])["token"] as! String
            }else if result["status"] as! Int == 403{
                completion(result["msg"]as! String,false, isSuccess)
            }
        }
        
    }
    
    func loadAuthCode(completion:@escaping (_ img:UIImage,_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusFile(url: "user/genAuthCode", params: [:]) { (result, isSuccess) in
            
            let image = UIImage.init(data: result as! Data)
            
            completion(image!, isSuccess)
        }
    }
    
}
