//
//  CommonItemModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class CommonItemModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    var itemId:NSString = ""
    
    var itemName:NSString = ""
    
    var selected:Bool = true
}
