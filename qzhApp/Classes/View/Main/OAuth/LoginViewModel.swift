//
//  LoginViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class LoginViewModel:CustomStringConvertible{
    
    var status:LoginModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:LoginModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }

}
