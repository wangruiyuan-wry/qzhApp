//
//  QZHOrderListModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHOrderListModel:NSObject{
    
    // 参数
    struct paramer {
        static var status:Int = 0
        static var pageNo:Int = 1
        static var pageSize:Int = 10
        static var statusInfo:String = ""
        static var orderNumber:String = ""
        
        // 查找至哪种订单列表
        static var orderType:Int = 0
        
        static var from:Int = 0
        
        static var flag:String = ""
    }

    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }

}
extension QZHOrderListModel{
    class var from:Int{
        set{
            paramer.from = newValue
        }
        get{
            return paramer.from
        }
    }
    class var orderType:Int{
        set{
            paramer.orderType = newValue
        }
        get{
            return paramer.orderType
        }
    }
    class var flag:String{
        set{
            paramer.flag = newValue
        }
        get{
            return paramer.flag
        }
    }

    class var orderNumber:String{
        set{
            paramer.orderNumber = newValue
        }
        get{
            return paramer.orderNumber
        }
    }
    class var statusInfo:String{
        set{
            paramer.statusInfo = newValue
        }
        get{
            return paramer.statusInfo
        }
    }
    class var status:Int{
        set{
            paramer.status = newValue
        }
        get{
            return paramer.status
        }
    }
    class var pageNo: Int {
        set{
            paramer.pageNo = newValue
        }
        get{
            return paramer.pageNo
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
}

class QZHOrderMainModel:NSObject{
    // 地址Id
    var addressId:Int = 0
    
    // 买家Id
    var buyerAccountId:Int = 0
    
    // 买家公司Id
    var buyerMemberId:Int = 0
    
    // 运费
    var freight:Double = 0.0
    
    // 订单主表ID
    var id:Int = 0
    
    // 实际订单金额
    var orderAmountTotal:Double = 0.0
    
    // 订单是否评论
    var orderComment:Int = 0
    
    // 订单总件数
    var orderCountTotal:Double = 0.0
    
    // 订单编号
    var orderNumber:String = ""
    
    // 订单结算状态货到付款、分期付款会用到
    var orderSettlementStatus:String = ""
    
    // 下单时间
    var orderTime:Date = Date()
    
    // 支付号
    var payNumber:String = ""
    
    // 支付方式
    var payType:Int = 0
    
    // 商品总额
    var productAmountTotal:Double = 0.0
    
    // 备注
    var remark:String = ""
    
    // 订单状态
    var status:Int = 0
    
    // 供应商公司Id
    var supplyMemberId:Int = 0
    
    // 供应商名称
    var supplyMemberName:String = ""
    
    // 供应商业务员Id
    var supplySalesmanId:Int = 0
    
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 订单子表
class QZHOrderSubModel:NSObject{
    
    // 购物车ID
    var cartId:Int = 0
    
    // 折扣金额
    var discountAmount:Double = 0.0
    
    // 折扣比例
    var discountRate:Double = 0.0
    
    // 订单子表Id
    var id:Int = 0
    
    // 积分
    var jfRebate:Double = 0.0
    
    // 主订单
    var orderMainId:Int = 0
    
    // 件数
    var pCount:Double = 0.0
    
    // 商品单价
    var proPrice:Double = 0.0
    
    // 商品编号呢
    var productCode:String = ""
    
    // 产品ID
    var productId:Int = 0
    
    // 产品名称
    var productName:String = ""
    
    // 规格描述
    var specDesc:String = ""
    
    // 订单明细发货状态
    var status:Int = 0
    
    // 计量单位
    var unnit:String = ""
    
    // 图片
    var picPath:String = ""
    
    // 产品原价
    var originalPrice:Double = 0.0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
