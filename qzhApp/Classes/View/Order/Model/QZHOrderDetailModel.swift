//
//  QZHOrderDetailModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHOrderDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    struct param {
        // 从那个页面跳转过来
        static var fromPage:String = "list"
        
        // 订单编号
        static var orderNumber:String = ""
        
        // add
        static var addressFlag:Bool = false
    }
    
}

extension QZHOrderDetailModel{
    class var orderNumber:String {
        set{
            param.orderNumber = newValue
        }
        get{
            return param.orderNumber
        }
    }
    class var addressFlag:Bool  {
        set{
            param.addressFlag = newValue
        }
        get{
            return param.addressFlag
        }
    }
    class var fromPage:String {
        set{
            param.fromPage = newValue
        }
        get{
            return param.fromPage
        }
    }
}

class  QZHOrderMainDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
   // 地址ID
    var addressId:Int = 0
    
    // 买家用户Id
    var buyerAccountId:Int = 0
    
    // 买家公司ID
    var buyerMemberId:Int = 0
    
    // 运费
    var freight:Double = 0.0
    
    // 订单主表ID
    var id:Int = 0
    
    // 实际付款金额
    var orderAmountTotal:Double = 0.0
    
    // 订单评价状态
    var orderComment:Int = 0
    
    // 订单件数
    var orderCountTotal:Double = 0.0
    
    // 订单编号
    var orderNumber:String = ""
    
    // 订单结算状态
    var orderSettlementStatus:String = ""
    
    // 下单时间
    var orderTime:String = ""
    
    // 支付号
    var payNumber:String = ""
    
    // 支付方式
    var payType:Int = 0
    
    // 付款方式
    var payWay:String = ""
    
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
    
    // 供应商业务员ID
    var supplySalesmanId:Int = 0
}

class  QZHOrderSubDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 购物车Id
    var carId:Int = 0
    
    // 折扣金额
    var discountAmount:Double = 0.0
    
    // 折扣比例
    var discountRate:Double = 0.0
    
    // 订单子表id
    var id:Int = 0
    
    // 积分
    var jfRebate:Double = 0.0
    
    // 订单主表Id
    var orderMainId:Int = 0
    
    // 产品原价
    var originalPrice:Double = 0.0
    
    // 件数
    var pCount:Double = 0.0
    
    // 产品图片地址
    var picPath:String = ""
    
    // 商品单价
    var proPrice:Double = 0.0
    
    // 商品编号
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
    var unit:String = ""
    
    // 货品Id
    var goodsId:Int = 0
    
}

class  QZHOrderAddressDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 用户id
    var accountId:Int = 0
    
    // 所在地区
    var area:String = ""
    
    // 地区信息
    var areaInfo:String = ""
    
    // 详细地址
    var detailedAddress:String = ""
    
    // 是否设为默认地址
    var isDefault:Int = 0
    
    // 收货地址ID
    var id:Int = 0
    
    // 联系人
    var personName:String = ""
    
    // 手机号码
    var phone:String = ""
}

class  QZHOrderLogDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 日志id
    var id:Int = 0
    
    // 操作金额
    var operateAmount:Double = 0.0
    
    // 操作描述
    var operateDesc:String = ""
    
    // 操作时间
    var operateTime:String = ""
    
    // 操作人员Id
    var operateUserId:Int = 0
    
    // 主订单ID
    var orderMainId:Int = 0
}

class  QZHOrderPersonInfoDetailModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 卖家个人Id
    var accountId:Int = 0
    
    // 手机
    var phone:String = ""
    
    // 公司名称
    var companyName:String = ""
    
    // 昵称
    var nikeName:String = ""
    
    // 店铺名称
    var shortName:String = ""
}


