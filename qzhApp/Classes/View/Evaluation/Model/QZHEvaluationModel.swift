//
//  EvaluationModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/26.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHEvaluationModel:NSObject{
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // ID
    var _id:String = ""
    
    // 用户Id
    var accountId:Int = 0
    
    // 货品打折价格
    var goodsDisCountPrice:Double = 0.0
    
    // 下单时间
    var orderTime:String = ""
    
    // 订单ID
    var orderId:Int = 0
    
    // 货品评分
    var goodsComment:Int = 0
    
    // 货品Id
    var goodsId:Int = 0
    
    // 货品价格
    var goodsPrice:Double = 0.0
    
    // 店铺Id
    var storeId:Int = 0
    
    // 货品名称
    var goodsName:String = ""
    
    // 货品描述
    var goodsSpec:String = ""
    
    // 货品图片
    var goodsPic:String = ""
    
    // 店铺名称
    var storeName:String = ""
    
    // 店铺logo
    var storeLogo:String = ""
    
    // 店铺等级
    var memberLevel:Int = 0
    
    struct param {
        static var pageNo:Int = 0
        static var pageSize:Int = 20
    }
}

extension QZHEvaluationModel{
    class var pageNo:Int{
        set{
            param.pageNo = newValue
        }
        get{
            return param.pageNo
        }
    }
    class var pageSize:Int{
        set{
            param.pageSize = newValue
        }
        get{
            return param.pageSize
        }
    }
}

class QZHEvaluationRepliesModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 恢复时间
    var createTime:String = ""
    
    // 货品描述
    var goodsDescripe:String = ""
    
    // 用户昵称
    var accountName:String = ""
    
    // 店铺名称
    var storeName:String = ""
    
    // 头像链接地址
    var avatar:String = ""
}
