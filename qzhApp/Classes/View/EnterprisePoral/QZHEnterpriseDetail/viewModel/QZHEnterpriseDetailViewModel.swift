//
//  QZHEnterpriseDetailViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/17.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHEnterpriseDetailViewModel: CustomStringConvertible {
    //企业详情模型
    var status:QZHEnterpriseDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHEnterpriseDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }

}

class QZHEnterpriseInfoViewModel: CustomStringConvertible {
    //企业详情模型
    var status:QZHEnterpriseInfoModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHEnterpriseInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}

class QZHEnterpriseProViewModel: CustomStringConvertible {
    // 企业产品模型
    var status:QZHEnterpriseProModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHEnterpriseProModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}

