//
//  QZH_CYSQCarModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZH_CYSQCarModel: NSObject {
    
    // 店铺名称
    var storeName:String = ""
    
    // 卖家店铺的 ID
    var storeId:Int = 0
    
    // 卖家店铺的 Logo
    var storeLogo:String = ""
    
    // 卖家店铺的 MemberId
    var memberId:Int = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 参数 
    struct  paramer {
        static var pageNo:Int = 1
        static var pageSize:Int = 5
        static var proCount:Int = 0
    }
}

extension QZH_CYSQCarModel{
    class var proCount:Int{
        set{
            paramer.proCount = newValue
        }
        get{
            return paramer.proCount
        }
    }
    class var pageSize:Int{
        set{
            paramer.pageSize = newValue
        }
        get{
            return paramer.pageSize
        }
    }
    class var pageNo:Int{
        set{
            paramer.pageNo = newValue
        }
        get{
            return paramer.pageNo
        }
    }
}

class QZH_CYSQCarProModel:NSObject{
    // 卖家memberId
    var sellMemberid:Int = 0
    
    // 买家memberId
    var buyMemberid:Int = 0
    
    // 产品Id
    var productId:Int = 0
    
    // 产品所属货品Id
    var goodsId:Int = 0
    
    // 个人的accountid
    var buyAccountid:Int = 0
    
    // 产品数量
    var productCount:Double = 0
    
    // 产品信息
    var productInfo:[String:AnyObject] = [:]
    
    // 购物车状态
    var carStatus:Int = 0
    
    // 规格选项Id
    var specOptionId:String = ""
    
    // 规格选项名称
    var specOptionName:String = ""
    
    // 购物车创建时间
    var createTime:Date = Date()
    
    // 卖家店铺Id
    var sellStoreid:Int = 0
    
    // 购物车Id
    var id:Int = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 编辑购物车的参数
    struct editParamer {
        static var ids:Int = 0
        static var proCounts:Double = 0.0
        static var specOptionNames:String = ""
        static var productIds:Int = 0
        static var idStr:String = ""
    }
}
extension QZH_CYSQCarProModel{
    class var proCounts:Double{
        set{
            editParamer.proCounts = newValue
        }
        get{
            return editParamer.proCounts
        }
    }
    class var specOptionNames:String{
        set{
            editParamer.specOptionNames = newValue
        }
        get{
            return editParamer.specOptionNames
        }
    }
    class var idStr:String{
        set{
            editParamer.idStr = newValue
        }
        get{
            return editParamer.idStr
        }
    }
    class var ids:Int{
        set{
            editParamer.ids = newValue
        }
        get{
            return editParamer.ids
        }
    }
    class var productIds:Int{
        set{
            editParamer.productIds = newValue
        }
        get{
            return editParamer.productIds
        }
    }
}
