//
//  QZHCollectListPorViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class  QZHCollectListPorViewModel: CustomStringConvertible{
    
    var status:QZHCollectListPorModel
    
    /// 构造函数
    ///
    /// - Parameter model: 收藏商品数据模型
    /// - return: 收藏商品的视图模型
    init(model:QZHCollectListPorModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
