//
//  QZH_CYSQCarSettlementModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/19.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// 结算页信息
class QZH_CYSQCarSettlementModel:NSObject{
    struct  param {
        static var ids:String = ""
    }
}
extension QZH_CYSQCarSettlementModel{
    class var ids:String{
        set{
            param.ids = newValue
        }
        get{
            return param.ids
        }
    }
}

/// 产品信息
class QZH_CYSQCarSettlementProModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 卖家的memberID
    var sellMemberid:Int = 0
    
    // 买家的memberid
    var buyMemberid:Int = 0
    
    // 商品的Id
    var productId:Int = 0
    
    // 商品所属的货品ID
    var goodsId:Int = 0
    
    // 买家的accountID
    var buyAccountid:Int = 0
    
    // 商品购买数量
    var productCount:Double = 0.0
    
    // 商品详细信息
    var productInfo:[String:AnyObject] = [:]
    
    // 购物车状态
    var carStatus:Int = 0
    
    // 规格名称
    var specOptionName:String = ""
    
    // 购物车创建时间
    var creatTime:Date = Date()
    
    // 卖家店铺的ID
    var sellStoreId:Int = 0
    
    // 购物车Id
    var id:Int = 0
    
}

/// 店铺为单位信息
class QZH_CYSQCarSettlementStoreModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 金额小计（每个店铺的）
    var subTotalMoney:Double = 0.0
    
    // 产品的数量小计
    var subTotalNum:Double = 0.0
    
    // 店铺logo
    var storeLogo:String = ""
    
    // 店铺简称
    var storeName:String = ""
    
    // 店铺所属商家的memberId
    var storeMemberId:Int = 0
    
    // 卖家店铺Id
    var storeId:Int = 0
    
}


/// 收货地址信息
class QZH_CYSQCarSettlementAddressModel: NSObject {
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 省市区信息
    var areaInfo:String = ""
    
    // 电话
    var phone:String = ""
    
    // 联系人
    var person:String = ""
    
    // 详细地址
    var detailAddress:String = ""
    
    // 地址主键ID
    var addressId:Int = 0
    
}
