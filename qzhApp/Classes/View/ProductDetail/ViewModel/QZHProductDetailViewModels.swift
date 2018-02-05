//
//  QZHProductDetailViewModels.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

// 产品详情数据模型
class QZHProductDetail_GoodsViewModel:CustomStringConvertible{
    // 产品属性模型
    var status:QZHProductDetailModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetailModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHProductDetail_PROPicViewModel: CustomStringConvertible {
    // 产品图片模型
    var status:QZHProductDetail_PROPicModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROPicModel) {
        self.status = model
    }
    
    var description: String{
        return status.description
    }

}

class QZHProductDetail_PRORecommendViewModel:CustomStringConvertible{
    // 商家推荐产品数据模型
    var status:QZHProductDetail_PRORecommendModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PRORecommendModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHProductDetail_PROAttributeOptionViewModel：CustomStringConvertible{
    // 产品属性模型
    var status:QZHProductDetail_PROAttributeOptionModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROAttributeOptionModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}


class QZHProductDetail_PROSpecOptionViewModel:CustomStringConvertible{
    // 产品规格模型
    var status:QZHProductDetail_PROSpecOptionModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROSpecOptionModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHProductDetail_PROShopStatisticsViewModel:CustomStringConvertible{
    // 店铺模型
    var status:QZHProductDetail_PROShopStatisticsModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROShopStatisticsModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHProductDetail_PROListCommentViewModel:CustomStringConvertible{
    // 评论模型
    var status:QZHProductDetail_PROListCommentModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROListCommentModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

class QZHProductDetail_PROPrice2StockByIdViewModel:CustomStringConvertible{
    // 产品模型
    var status:QZHProductDetail_PROPrice2StockByIdModel
    
    /// 构造函数
    ///
    /// - Parameter model: 企业类型模型
    /// - return: 企业类型的视图模型
    init(model:QZHProductDetail_PROPrice2StockByIdModel) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
 

