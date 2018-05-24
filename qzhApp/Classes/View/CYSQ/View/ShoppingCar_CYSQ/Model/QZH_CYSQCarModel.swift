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
        static var specOptionId:String = ""
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
    class var specOptionId:String{
        set{
            editParamer.specOptionId = newValue
        }
        get{
            return editParamer.specOptionId
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

class QZH_CYSQCarProInfoModel:NSObject{
    
    // 条形码
    var barCode:String = ""
    
    // 点击量
    var clickVolume:Int = 0
    
    // 产品的创建时间
    var createDate:String = ""
    
    // 产品所属货品ID
    var goodsId:Int = 0
    
    // 产品Id
    var id:Int = 0
    
    // 原价
    var orginalPrice:Double = 0.0
    
    // 产品图片
    var picturePath:String = ""
    
    // 产品编码
    var productCode:String = ""
    
    // 产品名称
    var productName:String = ""
    
    // 促销价
    var  promotionPrice	:Double = 0.0
    
    // 销售量
    var salesVolume:Double = 0.0
    
    // 库存
    var stock:Double = 0.0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

class QZH_CYSQCarAccountPeriodInfoModel:NSObject{
    
    // 买家ID
    var buyerMemberId:Int = 0
    
    // 公司名
    var companyName:String = ""
    
    // 删除标记
    var delFlag:Int = 0
    
    //id
    var id:Int = 0
    
    // 联系人
    var linkName:String = ""
    
    // 昵称
    var linkNickName:String = ""
    
    // 帐期时间
    var periodDay:Int = 0
    
    // 帐期剩余
    var periodLeft:Double = 0.0
    
    // 帐期总额
    var periodTotal:Double = 0.0
    
    // 已使用帐期
    var periodUsed:Double = 0.0
    
    // 手机
    var phone:String = ""
    
    // 卖家公司
    var salerMemberId:Int = 0
    
    // 电话
    var tel:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

