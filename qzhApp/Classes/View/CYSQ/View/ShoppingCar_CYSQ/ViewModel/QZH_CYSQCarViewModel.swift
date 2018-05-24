//
//  QZH_CYSQCarViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/23.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZH_CYSQCarViewModel:CustomStringConvertible{
    var status:QZH_CYSQCarModel
    
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZH_CYSQCarModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }

}//QZH_CYSQCarProViewModel

class QZH_CYSQCarProViewModel:CustomStringConvertible{
    var status:QZH_CYSQCarProModel
    
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZH_CYSQCarProModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }

}
//QZH_CYSQCarAccountPeriodInfoModel
class  QZH_CYSQCarAccountPeriodInfoViewModel: CustomStringConvertible {
    var status:QZH_CYSQCarAccountPeriodInfoModel
    
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZH_CYSQCarAccountPeriodInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class  QZH_CYSQCarProInfoViewModel: CustomStringConvertible {
    var status:QZH_CYSQCarProInfoModel
    
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZH_CYSQCarProInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
