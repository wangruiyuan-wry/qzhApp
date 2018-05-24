//
//  QZHPersonalCenterMineViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHPersonalCenterMyInfoViewModel:CustomStringConvertible{
    var status:QZHPersonalCenterMyInfoModel
    /// 构造函数
    ///
    /// - Parameter model: 基本信息模型
    /// - return: 基本信息的视图模型
    init(model:QZHPersonalCenterMyInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHPersonalCenterPersonInfoViewModel:CustomStringConvertible{
    var status:QZHPersonalCenterPersonInfoModel
    /// 构造函数
    ///
    /// - Parameter model: 个人信息模型
    /// - return: 个人信息的视图模型
    init(model:QZHPersonalCenterPersonInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHPersonalCenterOrderCountViewModel:CustomStringConvertible{
    var status:QZHPersonalCenterOrderCountModel
    /// 构造函数
    ///
    /// - Parameter model: 订单信息模型
    /// - return: 订单信息的视图模型
    init(model:QZHPersonalCenterOrderCountModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
