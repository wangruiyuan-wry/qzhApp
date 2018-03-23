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
    
    // 参数列表
    struct param {
        // 联系人姓名
        static var person:String = ""
        
        // 手机号码
        static var phone:String = ""
        
        // 省市区编码
        static var code:String = ""
        
        // 详细地址
        static var address:String = ""
        
        // 是否为默认地址
        static var isDefault:Int = 0
        
        // 地址ID
        static var addressId:Int = 0
    }
}

extension QZHAddressModel{
    class var person:String{
        set{param.person = newValue}
        get{return param.person}
    }
    
    class var phone:String {
        set{param.phone = newValue}
        get{return param.phone}
    }
    
    class var code:String{
        set{param.code = newValue}
        get{return param.code}
    }
    
    class var address:String{
        set{param.address = newValue}
        get{return param.address}
    }
    
    class var isDefault:Int{
        set{param.isDefault = newValue}
        get{return param.isDefault}
    }
    
    class var addressId:Int{
        set{param.addressId = newValue}
        get{return param.addressId}
    }
}
