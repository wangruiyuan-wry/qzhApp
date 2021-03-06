//
//  QZHProductDetailModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/1.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// 产品详情数据模型
class QZHProductDetailModel: NSObject {
    // 产品参数
    struct paramers {
        static var goodsId:Int = 0
        static var productId:Int64 = 0
        static var memberId:Int64 = 0
        static var commentNum:Int = 0
        static var specOptionId:String = ""
        static var specOptionName:String = ""
        static var proCount:Double = 0.0
        static var sellMemberId:Int = 0
    }
    
    // 产品Id
    var id :Int64 = 0
    
    // 产品名称
    var goodsName:String = ""
    
    // 产品价格
    var fixedPrice:Double = 0.0
    
    // 销售量
    var salesVolume:Int = 0
    
    // 总库存
    var stock:Double = 0
    
    // 产品商家Id
    var eipMemberId:Int64 = 0
    
    // 产品单位
    var unit:String = ""
    
    // 货品条形码
    var barCode:String = ""
    
    // 货品分类ID
    var categoryId:String = ""
    
    // 货品收藏数目
    var collectNum:Int = 0
    
    // 货品创建时间
    var createDate:String = ""
    
    // 货品自定义分类
    var  customCategory:String = ""
    
    // 商品编码
    var productCode:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
extension QZHProductDetailModel{
    class var goodsId:Int{
        get{
            return paramers.goodsId
        }
        set{
            paramers.goodsId = newValue
        }
    }
    class var productId:Int64{
        get{
            return paramers.productId
        }
        set{
            paramers.productId = newValue
        }
    }
    class var memberId:Int64{
        get{
            return paramers.memberId
        }
        set{
            paramers.memberId = newValue
        }
    }
    class var commentNum:Int{
        get{
            return paramers.commentNum
        }
        set{
            paramers.commentNum = newValue
        }
    }
    
    class var specOptionName:String{
        get{
            return paramers.specOptionName
        }
        set{
            paramers.specOptionName = newValue
        }
    }
    class var specOptionId:String{
        get{
            return paramers.specOptionId
        }
        set{
            paramers.specOptionId = newValue
        }
    }
    class var proCount:Double{
        get{
            return paramers.proCount
        }
        set{
            paramers.proCount = newValue
        }
    }
    class var sellMemberId:Int{
        get{
            return paramers.sellMemberId
        }
        set{
            paramers.sellMemberId = newValue
        }
    }
}

// 产品详情数据模型
class QZHProductDetail_PRODeatailModel:NSObject{
    
    // 货品Id
    var goodsId:Int = 0
    
    // 产品详情
    var productDetailsApp:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 产品图片数据模型
class QZHProductDetail_PROPicModel:NSObject{
    
    // 产品图片地址
    var picturePath:String = ""
    
    // 3d图片路径
    var picture3dPath:String = ""
    
    // 视频路径
    var videoPath:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}


// 商家推荐产品数据模型
class QZHProductDetail_PRORecommendModel: NSObject{
    struct paramers {
        static var pageNo:Int = 0
        static var pageSize:Int = 16
    }
    
    // 产品Id
    var id:Int64 = 0
    
    // 产品名称
    var goodsName:String = ""
    
    
    // 销售量
    var salesVolume:Int = 0
    
    // 单位
    var unit:String = ""
    
    // 产品价格
    var fixedPrice:Double = 0
    
    // 产品图片
    var pic:[String:AnyObject] = [:]
    
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
extension QZHProductDetail_PRORecommendModel{
    class var pageNo:Int{
        get{
            return paramers.pageNo
        }
        set{
            paramers.pageNo = newValue
        }
    }
    class var pageSize:Int{
        get{
            return paramers.pageSize
        }
        set{
            paramers.pageSize = newValue
        }
    }
}

// 产品属性数据模型
class QZHProductDetail_PROAttributeOptionModel:NSObject{
    // 产品属性选项关系表ID
    var id:Int = 0
    
    // 属性选项ID
    var attributeOptionId:Int64 = 0
    
    // 属性名称
    var attrbuteName:String = ""
    
    // 选项名称
    var attributeOptionName:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 产品规格数据模型
class QZHProductDetail_PROSpecOptionModel:NSObject{
    
    //  规格名称 父规格
    var specName:String = ""
    
    // 规格选项信息
    var option:[AnyObject] = []
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 店铺统计数据模型
class QZHProductDetail_PROShopStatisticsModel:NSObject{
    
    // 店铺简称
    var shortName:String = ""
    
    // 店铺图片
    var storeLogo:String = ""
    
    // 全部商品数量
    var goodsNum:Int = 0
    
    // 月销量
    var monthSales:Int = 0
    
    // 商品评价
    var goodsEvalution:Double = 0
    
    // 服务评价
    var serviceEvalution:Double = 0
    
    // 收藏人数
    var collectionNum:Int = 0
    
    // 店铺Id
    var memberId:Int = 0
    
    // 会员等级
    var memberLevel:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

class QZHProductDetail_PROListCommentRepliesModel:NSObject{
    // 评论内容时间
    var createTime:String = ""
    
    // 评论产品具体内容
    var goodsDescripe:String = ""
    
    // 用户昵称
    var accountName:String = ""
    
    // 店铺名称
    var storeName:String = ""
    
    // 头像
    var avatar:String = ""
    
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 评论列表数据模型
class QZHProductDetail_PROListCommentModel:NSObject{
    struct counts {
        static var count:Int = 0
    }
    
    // 评论ID
    var _id:String = ""
    
    // 货品Id
    var goodsId:Int = 0
    
    // 创建时间
    var orderTime:String = ""
    
    // 评论者Id
    var accountId:Int64 = 0
    
    // 货品评论分
    var goodsComment:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

extension QZHProductDetail_PROListCommentModel{
    class var count:Int{
        get{
            return counts.count
        }
        set{
            counts.count = newValue
        }
    }
}

// 产品价格数据模型
class QZHProductDetail_PROPrice2StockByIdModel:NSObject{
    
    // 图片路径 只有一个
    var picturePath:String = ""
    
    // 原价
    var originalPrice:Double = 0
    
    // 销售量
    var salesVolume:Int = 0
    
    // 促销价
    var promotionPrice:Double = 0.0
    
    // 是否是新品 是：1
    var isNew:Int = 0
    
    // 产品名称
    var productName:String = ""
    
    // 条形码
    var barCode:String = ""
    
    // 品牌ID
    var brandId:Int64 = 0
    
    // 产品简介
    var intro:String = ""
    
    // 产品库存
    var stock:Double = 0
    
    // 产品分类ID
    var categoryId: Int64 = 0
    
    // 是否热卖 是：1
    var isHot:Int = 0
    
    // 点击量 浏览量
    var clickVolume:Int = 0
    
    // 产品创建时间
    var createDate:String = ""
    
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}

// 关注收藏信息
class QZHProductDetail_AttentionCollectModel:NSObject{
    
    // 该商品是否收藏
    var collentProduct:Int = 0
    
    // 该店铺是否收藏
    var attentionStore:Int = 0
    /// 重写 description 的计算属性
    override var description: String{
        return yy_modelDescription()
    }
}
