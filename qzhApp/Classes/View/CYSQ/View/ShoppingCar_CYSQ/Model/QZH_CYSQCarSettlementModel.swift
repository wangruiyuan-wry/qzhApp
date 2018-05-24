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
        
        // 备注
        static var remark:String = ""
        
        // 收货人姓名
        static var person:String = ""
        // 收货人电话
        static var phone:String = ""
        // 收货地址
        static var address:String = ""
        // 收收货地址id
        static var addressId:Int = 0
        
        // 订单 id
        static var orderID:Int = 0
        
        // 订单支付号
        static var payNumber:String = ""
        
        // 是否是立即购买
        static var ShoppingFlag:Int = 0
        
        // 立即购买参数
        // - 所选规格的产品ID
        static var productId:Int = 0
        
        // - 数量
        static var proCount:Double = 0.0
        
        // - 所选规格
        static var specOptionName:String = ""
        
        // - 是否是立即购买
        static var type:Int = 0
        
        // 账期
        static var accountSettlementDays:Int = 0
    }
}
extension QZH_CYSQCarSettlementModel{
    class var accountSettlementDays:Int{
        set{
            param.accountSettlementDays = newValue
        }
        get{
            return param.accountSettlementDays
        }
    }
    class var type:Int{
        set{
            param.type = newValue
        }
        get{
            return param.type
        }
    }
    class var ShoppingFlag:Int{
        set{
            param.ShoppingFlag = newValue
        }
        get{
            return param.ShoppingFlag
        }
    }
    class var productId:Int{
        set{
            param.productId = newValue
        }
        get{
            return param.productId
        }
    }
    
    class var proCount:Double{
        set{
            param.proCount = newValue
        }
        get{
            return param.proCount
        }
    }
    
    class var specOptionName:String{
        set{
            param.specOptionName = newValue
        }
        get{
            return param.specOptionName
        }
    }
    
    class var orderID:Int{
        set{
            param.orderID = newValue
        }
        get{
            return param.orderID
        }
    }
    
    class var payNumber:String{
        set{
            param.payNumber = newValue
        }
        get{
            return param.payNumber
        }
    }

    class var remark:String{
        set{
            param.remark = newValue
        }
        get{
            return param.remark
        }
    }
    class var phone:String{
        set{
            param.phone = newValue
        }
        get{
            return param.phone
        }
    }
    class var address:String{
        set{
            param.address = newValue
        }
        get{
            return param.address
        }
    }
    class var addressId:Int{
        set{
            param.addressId = newValue
        }
        get{
            return param.addressId
        }
    }
    class var person:String{
        set{
            param.person = newValue
        }
        get{
            return param.person
        }
    }
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
