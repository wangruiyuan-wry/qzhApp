//
//  QZHCYSQ_SortListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHCYSQ_SortProViewModel:CustomStringConvertible{
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
