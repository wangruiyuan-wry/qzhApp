//
//  PriceRangeModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class PriceRangeModel:NSObject{
    
    var minPrice:NSString = ""
    
    var maxPrice:NSString = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
