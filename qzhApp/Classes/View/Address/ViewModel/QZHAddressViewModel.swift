//
//  QZHAddressViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHAddressViewModel:CustomStringConvertible{
    var status:QZHAddressModel
    /// 构造函数
    ///
    /// - Parameter model: 产品信息模型
    /// - return: 产品信息的视图模型
    init(model:QZHAddressModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
