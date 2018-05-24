//
//  QZHBrandAndSpecOptionViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/18.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHBrandViewModel:CustomStringConvertible{
    // 店铺产品模型
    var status:QZHBrandModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHBrandModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}


class QZHOptionViewModel:CustomStringConvertible{
    // 店铺产品模型
    var status:QZHOptionModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHOptionModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}
class QZHSpecOptionViewModel:CustomStringConvertible{
    // 店铺产品模型
    var status:QZHSpecOptionModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHSpecOptionModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}
