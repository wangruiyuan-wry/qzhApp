//
//  QZGH_CYSQHomeViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/25.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 单条的产业商圈首页视图模型
/*
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要
 1. 遵守 CustomStringConvertible
 2. 实现 description 计算型属性
 */

class QZGH_CYSQHomeHotSellViewModel:CustomStringConvertible{

    var status:QZGH_CYSQHomeModel_hotSell
    
    /// 构造函数
    ///
    /// - Parameter model: 热销产品模型
    /// - return: 热销产品的视图模型
    init(model:QZGH_CYSQHomeModel_hotSell) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 头部轮播图模型  QZGH_CYSQHomeHotSellViewModel
class QZGH_CYSQHomeSildeHeadViewModel: CustomStringConvertible {
    
    var status:QZGH_CYSQHomeModel_sildeHead
    
    /// 构造函数
    ///
    /// - Parameter model: 头部轮播图模型
    /// - return: 头部轮播图的视图模型
    init(model:QZGH_CYSQHomeModel_sildeHead) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 今日推荐轮播图模型
class QZGH_CYSQHomeSildeTodayRecommendViewModel: CustomStringConvertible {
    
    var status:QZGH_CYSQHomeModel_sildeTodayRecommend
    
    /// 构造函数
    ///
    /// - Parameter model: 今日推荐轮播图模型
    /// - return: 今日推荐轮播图的视图模型
    init(model:QZGH_CYSQHomeModel_sildeTodayRecommend) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 分类图片模型
class QZGH_CYSQHomeGetMarketClassViewModel:CustomStringConvertible{
    var status:QZGH_CYSQHomeModel_getMarketClass
    
    /// 构造函数
    ///
    /// - Parameter model: 分类图片模型
    /// - return: 分类图片的视图模型
    init(model:QZGH_CYSQHomeModel_getMarketClass) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 促销产品模型
class QZGH_CYSQHomeGetPromotionMarketAdViewModel:CustomStringConvertible{
    var status:QZGH_CYSQHomeModel_getPromotionMarketAd
    
    /// 构造函数
    ///
    /// - Parameter model: 促销产品模型
    /// - return: 促销产品的视图模型
    init(model:QZGH_CYSQHomeModel_getPromotionMarketAd) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}

/// 今日推荐
class QZGH_CYSQHomeGetRecommendMarketAdViewModel:CustomStringConvertible{
    
    var status:QZGH_CYSQHomeModel_getRecommendMarketAd
    
    /// 构造函数
    ///
    /// - Parameter model: 今日推荐模型
    /// - return: 今日推荐的视图模型
    init(model:QZGH_CYSQHomeModel_getRecommendMarketAd) {
        self.status=model
    }
    
    var description: String{
        return status.description
    }
}
