//
//  QZHOrderMainViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/29.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHOrderMainViewModel:CustomStringConvertible{
    
    var status:QZHOrderMainModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderMainModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHOrderSubViewModel:CustomStringConvertible{
    
    var status:QZHOrderSubModel
    
    /// 构造函数
    ///
    /// - Parameter model: 子订单模型
    /// - return: 子订单的视图模型
    init(model:QZHOrderSubModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
