//
//  QZGH _CYSQHomeModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/24.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 头部轮播图模型
class QZGH_CYSQHomeModel_sildeHead: NSObject {
    
    // 图片id
    var id:Int64 = 0
    
    // 图片链接
    var slidePictureUrl:String = ""
    
    // 货品Id
    var goodId:Int64 = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 今日推荐轮播图模型
class QZGH_CYSQHomeModel_sildeTodayRecommend: NSObject {
    
    // 图片id
    var id:Int64 = 0
    
    // 图片链接
    var slidePictureUrl:String = ""
    
    // 货品Id
    var goodId:Int64 = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 分类图片模型
class QZGH_CYSQHomeModel_getMarketClass:NSObject{
    
    // Id
    var categoryId:Int = 0
    
    // 图片地址
    var pictureUrl:String = ""
    
    // 分类名称
    var name:String = ""
    
    // 分类 Id
    var labelId:Int = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 促销产品模型
class QZGH_CYSQHomeModel_getPromotionMarketAd:NSObject{
    
    // 产品名称
    var productName:String = ""
    
    // 产品 Id
    var goodsId:Int = 0
    
    // 活动价格
    var productPrice:Double = 0
    
    //原价格 
    var originalPrice:Double = 0

    // 产品图片
    var productPictureUrl:String = ""
    
    // 活动名称
    var productSellActivity:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 今日推荐
class QZGH_CYSQHomeModel_getRecommendMarketAd:NSObject{
    // 产品名称
    var productName:String = ""
    
    // 产品 Id
    var goodsId:Int = 0
    
    // 活动价格
    var productPrice:Double = 0
    
    // 原价格
    var originalPrice:Double = 0
    
    // 产品图片
    var productPictureUrl:String = ""
    
    // 活动名称
    var productSellActivity:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

/// 热销产品
class QZGH_CYSQHomeModel_hotSell:NSObject{
    
    // 产品Id 
    var id:Int64 = 0
    
    // 产品名称
    var goodsName:String = ""
    
    // 产品单价
    var fixedPrice:Double = 0
    
    // 销售量
    var salesVolume:Int = 0
    
    // 产品图片信息
    var pic:[Dictionary<String,AnyObject>] = []
    
    // 是否是自营产品
    var selfSupport:Int = 0
    
    // 产品单位
    var unit:String = ""
    
    // 产品商家 ID
    var eipMemberId:Int = 0
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    struct paramers {
        static var pageNo:Int = 1
        static var pageSize:Int = 16
    }
}
extension QZGH_CYSQHomeModel_hotSell{
    class var pageNo:Int{
        get{
            return paramers.pageNo
        }
        set{
            paramers.pageNo=newValue
        }
    }
    class var pageSize:Int{
        get{
            return paramers.pageSize
        }
        set{
            paramers.pageSize=newValue
        }
    }
}
