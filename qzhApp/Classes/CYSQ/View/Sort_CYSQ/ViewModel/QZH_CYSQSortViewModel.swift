//
//  QZH_CYSQSortViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZH_CYSQSortViewModel: CustomStringConvertible {
    var status:QZH_CYSQSortModel
    
    /// 构造函数
    ///
    /// - Parameter model: 一级分类模型
    /// - return: 一级分类的视图模型
    init(model:QZH_CYSQSortModel) {
        self.status = model
    }
    
    var description: String{
        return status.description
    }

}

class QZH_CYSQSort_SecondViewModel: CustomStringConvertible {
    var status:QZH_CYSQSort_SecondModel
    
    /// 构造函数
    ///
    /// - Parameter model:二级分类模型
    /// - return: 二级分类的视图模型
    init(model:QZH_CYSQSort_SecondModel) {
        self.status = model
    }
    
    var description: String{
        return status.description
    }
    
}
