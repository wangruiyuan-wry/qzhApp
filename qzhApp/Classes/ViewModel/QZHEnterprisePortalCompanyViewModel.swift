//
//  QZHEnterprisePortalCompanyViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/10.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 单条的企业视图模型
/*
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要
 1. 遵守 CustomStringConvertible
 2. 实现 description 计算型属性
 */
class QZHEnterprisePortalCompanyViewModel:CustomStringConvertible{
    
    //企业模型
    var status:QZHEnterprisePortalModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHEnterprisePortalModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
    
}

/// 单条的企业类型视图模型
class QZHEnterpriseTypeViewModel:CustomStringConvertible{
    //企业类型模型
    var status:QZHEnterpriseTypeModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHEnterpriseTypeModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 单条的一级行业分类视图模型
class QZHEnterpriseFirstViewModel:CustomStringConvertible{
    //一级分类模型
    var status:QZHEnterpriseFirstModel
    
    /// 构造函数
    ///
    /// - Parameter model: 一级分类模型
    /// - return: 一级分类的视图模型
    init(model:QZHEnterpriseFirstModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 单条的二级行业分类视图模型
class QZHEnterpriseSecondViewdModel:CustomStringConvertible{
    //二级分类模型
    var status:QZHEnterpriseSecondModel
    
    /// 构造函数
    ///
    /// - Parameter model: 二级分类模型
    /// - return: 二级分类的视图模型
    init(model:QZHEnterpriseSecondModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
