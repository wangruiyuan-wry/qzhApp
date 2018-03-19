//
//  QZH_CYSQCarSettlementViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
/// 产品信息
class QZH_CYSQCarSettlementProViewModel: CustomStringConvertible {
    var status:QZH_CYSQCarSettlementProModel
    
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZH_CYSQCarSettlementProModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 店铺为单位信息
class QZH_CYSQCarSettlementStoreViewModel: CustomStringConvertible {
    var status:QZH_CYSQCarSettlementStoreModel
    
    /// 构造函数
    ///
    /// - Parameter model: 店铺模型
    /// - return: 店铺的视图模型
    init(model:QZH_CYSQCarSettlementStoreModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}


/// 收货地址信息
class QZH_CYSQCarSettlementAddressViewModel: CustomStringConvertible {
    var status:QZH_CYSQCarSettlementAddressModel
    
    /// 构造函数
    ///
    /// - Parameter model: 收货地址模型
    /// - return: 收货地址的视图模型
    init(model:QZH_CYSQCarSettlementAddressModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
