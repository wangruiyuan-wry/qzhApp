//
//  QZHEnterpriseDetailModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import YYModel

class QZHEnterpriseDetailModel: NSObject {
    
    struct paramers {
        static var memberId:String? = ""
        static var name:String? = ""
    }
    
    // 联系人
    var nickName:String? = ""
    
    // 手机
    var mobile:String? = ""
    
    // 地区
    var pca:String? = ""
    
    // 详细地址
    var address:String? = ""
    
    // 公司Logo
    var logo:String? = ""
    
    //主营产品
    var mainProduct:String? = ""
    
    // 主购产品
    var purchasingPro:String? = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

class QZHEnterpriseInfoModel:NSObject{
    // 公司简介
    var remark:String? = ""
    
    // 公司电话
    var tel:String? = ""
    
    // 公司邮箱
    var email:String = ""
    
    // 传真
    var fax:String = ""
    
    // 邮编
    var zipCode:String = ""
    
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

extension QZHEnterpriseDetailModel{
    class var memberId: String {
        get{
            return paramers.memberId!
        }
        set{
            paramers.memberId! = newValue
        }
    }
    
    class var name: String {
        get{
            return paramers.name!
        }
        set{
            paramers.name! = newValue
        }
    }
}

class QZHEnterpriseProModel: NSObject {
    // 产品ID
    var id:Int64 = 0
    
    // 产品图片
    var pic:String = ""
    
    // 产品规格信息
    var attribute:[String:AnyObject] = [:]
    
    // 价格
    var fixedPrice:Double = 0.0
    
    // 产品名称
    var goodsName:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    struct paramers {
        static var pageNo:Int? = 0
        static var pageSize:Int? = 10
    }
}
extension QZHEnterpriseProModel{
    class var pageNo:Int {
        get{
            return paramers.pageNo!
        }
        set{
            paramers.pageNo! = newValue
        }
    }
    
    class var pageSize:Int {
        get{
            return paramers.pageSize!
        }
        set{
            paramers.pageSize! = newValue
        }
    }
}
