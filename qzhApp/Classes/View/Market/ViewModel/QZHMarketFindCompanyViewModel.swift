//
//  QZHMarketFindCompanyViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMarketFindCompanyViewModel: CustomStringConvertible {
    
    var status:QZHMarketFindCompanyModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHMarketFindCompanyModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
