//
//  QZHHomeViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/22.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 单条的广告模型
/*
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要
 1. 遵守 CustomStringConvertible
 2. 实现 description 计算型属性
 */
class QZHHomeViewModel: CustomStringConvertible {
    
    var status:QZHHomeModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业模型
    /// - return: 企业的视图模型
    init(model:QZHHomeModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
