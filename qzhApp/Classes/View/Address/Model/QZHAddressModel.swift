//
//  QZHAddressModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
class QZHAddressModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 用户 Id
    var accountId:Int = 0
    
    // 省市区的编码
    var area:String = ""
    
    // 省市区的详细地址
    var areaInfo:String = ""
    
    // 具体的详细地址
    var detailedAddress:String = ""
    
    // 地址Id
    var id:Int = 0
    
    // 是否设为默认地址
    var isDefault:Int = 0
    
    // 联系人姓名
    var personName:String = ""
    
    // 联系人手机
    var phone:String = ""
}
