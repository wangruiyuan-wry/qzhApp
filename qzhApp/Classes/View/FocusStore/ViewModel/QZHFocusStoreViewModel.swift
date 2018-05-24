//
//  QZHFocusStoreViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
//
class QZHFocusStoreViewModel: CustomStringConvertible{
    
    var status:QZHFocusStoreModel
    
    /// 构造函数
    ///
    /// - Parameter model: 收藏商品数据模型
    /// - return: 收藏商品的视图模型
    init(model:QZHFocusStoreModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
