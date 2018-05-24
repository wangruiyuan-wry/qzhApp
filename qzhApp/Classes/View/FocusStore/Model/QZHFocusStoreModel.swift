//
//  QZHFocusStoreModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHFocusStoreModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 被关注数量
    var attentionNum:Int = 0
    
    // 店铺等级
    var memberLevel:String = ""
    
    // 店铺所在省市区(code)
    var storePca:String = ""
    
    // 客服（客服ID，客服名称）
    var customerService:String = ""
    
    // 店铺详细地址
    var storeAddress:String = ""
    
    // 店铺对应的商品总个数
    var totalNum:Int = 0
    
    // 经营类型
    var managementTypes:Int = 0
    
    // 所属行业（code）
    var storeIndustry:String = ""
    
    // 店铺logo
    var storeLogo:String = ""
    
    // 店铺id
    var id:Int = 0
    
    // 店铺简介
    var storeRemark:String = ""
    
    // 店铺简介
    var shortName:String = ""
    
    // 关注店铺id
    var attStoreId:Int = 0
    
    // 店铺商家ID
    var memberId:Int = 0
    
    // 好评率
    var rateAll:Double = 0.0
    
    // 产品好评率
    var rateProduct:Double = 0.0
    
    // 物流好评率
    var rateLogistics:Double = 0.0
    
    // 服务好评率
    var rateService:Double = 0.0
    
    // 等级图片
    var storeLevelLogo:String = ""
    
    // 页面参数
    struct param {
        static var pageNo:Int = 0
        static var pageSize:Int = 20
        static var ids:String = ""
    }
}

extension QZHFocusStoreModel{
    class var ids:String{
        set{
            param.ids = newValue
        }
        get{
            return param.ids
        }
    }

    
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
