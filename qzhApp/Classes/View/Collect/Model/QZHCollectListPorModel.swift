//
//  QZHCollectListPorModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation



class QZHCollectListPorModel:NSObject{
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
    
    // 是否推荐
    var isRecommend:Int = 0
    
    // 销售量
    var saleVsVolume:Double = 0.0
    
    // 被收藏量
    var collectNum:Int = 0
    
    // 是否是新品 1:是
    var isNew:Int = 0
    
    // 货品图片（以逗号拼接）
    var pic:String = ""
    
    // 是否发布
    var isPublish:Int = 0
    
    // 标价
    var fixedPrice:Double = 0.0
    
    // 商家Id
    var eipMemberId:Int = 0
    
    // 条形码
    var barCode:String = ""
    
    // 货品单位
    var unit:String = ""
    
    // 货品编码
    var productCode:String = ""
    
    // 是否自营 1:是
    var sellSupport:Int = 0
    
    // 货品自定义分类(以逗号拼接)
    var customCategoryId:String = ""
    
    // 货品Id
    var id:Int = 0
    
    // 收藏货品主键Id
    var collectProId:Int = 0
    
    // 货品总库存
    var stock:Double = 0.0
    
    // 货品名称
    var goodsName:String = ""
    
    // 货品分类（以逗号隔开）
    var categoryId:String = ""
    
    // 货品创建时间
    var createDate:String = ""
    
    struct param {
        static var pageNo:Int = 0
        static var pageSize:Int = 20
        
        static var goodsId:Int = 0
        static var ids:String = ""
    }
}

extension QZHCollectListPorModel{
    class var ids:String{
        set{
            param.ids = newValue
        }
        get{
            return param.ids
        }
    }
    
    class var goodsId:Int{
        set{
            param.goodsId = newValue
        }
        get{
            return param.goodsId
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
