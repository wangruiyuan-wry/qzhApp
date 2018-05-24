//
//  EvaluationViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/26.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHEvaluationViewModel: CustomStringConvertible{
    
    var status:QZHEvaluationModel
    
    /// 构造函数
    ///
    /// - Parameter model: 收藏商品数据模型
    /// - return: 收藏商品的视图模型
    init(model:QZHEvaluationModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHEvaluationRepliesViewModel: CustomStringConvertible{
    
    var status:QZHEvaluationRepliesModel
    
    /// 构造函数
    ///
    /// - Parameter model: 收藏商品数据模型
    /// - return: 收藏商品的视图模型
    init(model:QZHEvaluationRepliesModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
