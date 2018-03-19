//
//  QZHStoreIndexViewModels.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/6.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHStoreInfoViewModel:CustomStringConvertible{

    // 店铺信息模型
    var status:QZHStoreInfoModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHStoreInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHStoreProViewModel:CustomStringConvertible{
    // 店铺产品模型
    var status:QZHStoreProModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHStoreProModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }

}


class QZHStoreSortViewModel:CustomStringConvertible{
    // 店铺产品分类模型
    var status:QZHStoreSortModel
    
    /// 构造函数
    ///
    /// - Parameter model: 模型
    /// - return: 视图模型
    init(model:QZHStoreSortModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}
