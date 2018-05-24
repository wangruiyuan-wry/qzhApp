//
//  QZHOrderDetailViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class  QZHOrderMainDetailViewModel:CustomStringConvertible{
    
    var status:QZHOrderMainDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderMainDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class  QZHOrderSubDetailViewModel:CustomStringConvertible{
    
    var status:QZHOrderSubDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderSubDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class  QZHOrderAddressDetailViewModel:CustomStringConvertible{
    
    var status:QZHOrderAddressDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderAddressDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class  QZHOrderLogDetailViewModel:CustomStringConvertible{
    
    var status:QZHOrderLogDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderLogDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class  QZHOrderPersonInfoDetailViewModel:CustomStringConvertible{
    
    var status:QZHOrderPersonInfoDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 主订单模型
    /// - return: 主订单的视图模型
    init(model:QZHOrderPersonInfoDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
