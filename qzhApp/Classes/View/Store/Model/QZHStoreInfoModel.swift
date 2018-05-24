//
//  QZHStoreInfoModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/5.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// 店铺信息数据模型
class QZHStoreInfoModel:NSObject{
    
    // 关注店铺的数量
    var attentionNum:Int = 0
    
    // 客服
    var customerService:String = ""
    
    // 店铺 ID
    var id:Int = 0
    
    // 经营类型
    var managementTypes:Int = 0
    
    // memberId 公司ID
    var memberId:Int = 0
    
    // 店铺等级
    var memberLevel:String = ""
    
    // 好评率
    var rateAll:Double = 0.0
    
    // 物流好评率
    var rateLogistics:Double = 0.0
    
    // 服务好评率
    var rateService:Double = 0.0
    
    // 产品
    var rateProduct:Double = 0.0
    
    // 店铺简称
    var shortName:String = ""
    
    // 店铺详细地址
    var storeAddress:String = ""
    
    // 店铺所属行业
    var storeIndustry:String = ""
    
    // 店铺Logo
    var storeLogo:String = ""
    
    // 店铺所在省市区
    var storePca:String = ""
    
    // 店铺简介
    var storeRmark:String = ""
    
    struct paramer {
        static var memberID:Int = 0
        
        static var storeId:Int = 0
    }
}
extension QZHStoreInfoModel{
    class var memberID: Int {
        get{
            return paramer.memberID
        }
        set{
            paramer.memberID = newValue
        }
    }
    class var storeId: Int {
        get{
            return paramer.storeId
        }
        set{
            paramer.storeId = newValue
        }
    }

}

// 店铺产品数据模型
class QZHStoreProModel:NSObject{
    // 产品ID
    var productGoodsId:Int = 0
    
    // 产品名称
    var productName:String = ""
    
    // 原价
    var originalPrice:Double = 0.0
    
    // 促销价
    var promotionPrice:Double = 0.0
    
    // 销量
    var salesVolume:Int = 0
    
    // 图片路径
    var picturePath:String = ""
    
    // 是否自营 1是 0否
    var selfSupport:Int = 0
    
    // 商家ID
    var eipMemberId:Int = 0
    
    // 商家名称
    var eipMemberName:String = ""
    
    // 点击量
    var clickVolume:Int = 0
    
    // 是否是新品
    var isNew:Int = 0
    
    // 产品单位
    var unit:String = ""
    
    // 货品名称
    var goodsName:String = ""
    
    // 一口价
    var fixedPrice:Double = 0.0
    
    struct paramer {
        static var q:String = ""
        static var pageNo:Int = 1
        static var pageSize:Int = 16
        static var order:Int = 1
        static var brand:String = ""
        static var specOptionName:String = ""
        static var customCategoryId:String = ""
    }
}

extension QZHStoreProModel{
    class var q:String{
        get{
            return paramer.q
        }
        set{
            paramer.q = newValue
        }
    }
    class var brand:String{
        get{
            return paramer.brand
        }
        set{
            paramer.brand = newValue
        }
    }
    class var specOptionName:String{
        get{
            return paramer.specOptionName
        }
        set{
            paramer.specOptionName = newValue
        }
    }
    class var customCategoryId:String{
        get{
            return paramer.customCategoryId
        }
        set{
            paramer.customCategoryId = newValue
        }
    }
    class var pageNo:Int{
        get{
            return paramer.pageNo
        }
        set{
            paramer.pageNo = newValue
        }
    }
    class var pageSize:Int{
        get{
            return paramer.pageSize
        }
        set{
            paramer.pageSize = newValue
        }
    }
    class var order:Int{
        get{
            return paramer.order
        }
        set{
            paramer.order = newValue
        }
    }
}

// 搜索店铺产品数据模型
class QZHStoreSearchProModel{
    struct paramer {
        static var q:String = ""
        static var pageNo:Int = 1
        static var pageSize:Int = 16
        static var order:Int = 1
        static var brand:String = ""
        static var specOptionName:String = ""
        
        // 是否由分类页面进入
        static var fromPage:Int = 1
    }
}
extension QZHStoreSearchProModel{
    class var q:String{
        get{
            return paramer.q
        }
        set{
            paramer.q = newValue
        }
    }
    class var brand:String{
        get{
            return paramer.brand
        }
        set{
            paramer.brand = newValue
        }
    }
    class var specOptionName:String{
        get{
            return paramer.specOptionName
        }
        set{
            paramer.specOptionName = newValue
        }
    }
    class var pageNo:Int{
        get{
            return paramer.pageNo
        }
        set{
            paramer.pageNo = newValue
        }
    }
    class var fromPage:Int{
        get{
            return paramer.fromPage
        }
        set{
            paramer.fromPage = newValue
        }
    }
    class var pageSize:Int{
        get{
            return paramer.pageSize
        }
        set{
            paramer.pageSize = newValue
        }
    }
    class var order:Int{
        get{
            return paramer.order
        }
        set{
            paramer.order = newValue
        }
    }
}

// 店铺商品分类数据模型
class QZHStoreSortModel:NSObject{
    
    // 父类图片
    var categoryPic:String = ""
    
    // 父分类等级
    var level:Int = 0
    
    // 父分类Id
    var id:Int = 0
    
    // 父分类排序
    var sort:Int = 0
    
    // 店铺 ID
    var storeId:Int = 0
    
    // 父分类名称
    var categoryName:String = ""
    
    // 父分类的parentID
    var parentId:Int = 0
    
    // 二级分类信息
    var level2:[[String:AnyObject]] = []
    
    struct paramer {
      static  var level2Array:[[String:AnyObject]] = []
      static  var selectedCellIndexPaths:[IndexPath] = []
      static  var cellHeightArray:[CGFloat] = []
    }
}
extension QZHStoreSortModel{
    class var level2Array:[[String:AnyObject]]{
        get{
            return paramer.level2Array
        }
        set{
            paramer.level2Array = newValue
        }
    }
    
    class var selectedCellIndexPaths:[IndexPath]{
        get{
            return paramer.selectedCellIndexPaths
        }
        set{
            paramer.selectedCellIndexPaths = newValue
        }
    }
    class var cellHeightArray:[CGFloat]{
        get{
            return paramer.cellHeightArray
        }
        set{
            paramer.cellHeightArray = newValue
        }
    }
}
