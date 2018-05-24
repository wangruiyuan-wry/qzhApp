//
//  QZHMarketCompanyViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation


class QZHMarketCompanyViewModel: CustomStringConvertible {
    
    var status:QZHMarketCompanyModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHMarketCompanyModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHMarketCompanyInfoViewModel: CustomStringConvertible {
    
    var status:QZHMarketCompanyInfoModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHMarketCompanyInfoModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
