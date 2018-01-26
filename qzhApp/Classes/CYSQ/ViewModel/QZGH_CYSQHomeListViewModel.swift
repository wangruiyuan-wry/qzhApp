//
//  QZGH_CYSQHomeListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/25.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 产业商圈首页列表视图模型
/*
 父类的选择
 - 如果使用 KVC 或者字典转模型设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑（写了一些函数），可以不用继承任何父类。好处：更加轻量级
 
 使命：负责数据处理
 */


/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 2

class QZGH_CYSQHomeListViewModel:NSObject{
    
    // 产业商圈首页热销产品视图模型加载
    lazy var hotSellList = [QZGH_CYSQHomeHotSellViewModel]()
    
    // 头部轮播图片视图模型懒加载
    lazy var sildeHeadList = [QZGH_CYSQHomeSildeHeadViewModel]()
    
    // 今日推荐轮播图视图模型懒加载
    lazy var sildeTodayRecommendList = [QZGH_CYSQHomeSildeTodayRecommendViewModel]()
    
    // 分类图片视图模型懒加载
    lazy var getMarketClassList = [QZGH_CYSQHomeGetMarketClassViewModel]()
    
    // 促销产品视图模型懒加载
    lazy var getPromotionMarketAdList = [QZGH_CYSQHomeGetPromotionMarketAdViewModel]()
    
    // 今日推荐视图模型懒加载
    lazy var getRecommendMarketAdList = [QZGH_CYSQHomeGetRecommendMarketAdViewModel]()
    
    /// 加载产业商圈首页广告位
    ///
    /// - Parameter completion: 完成回调
    func loadHomeData(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "market/MarketData/getMarketData", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"]as! Int != 200{
                    completion(false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    let _marketClass:[[String:AnyObject]] = _data["MarketClass"] as! [[String : AnyObject]]
                    var listArray1 = [QZGH_CYSQHomeGetMarketClassViewModel]()
                    for dict in _marketClass ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_getMarketClass.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray1.append(QZGH_CYSQHomeGetMarketClassViewModel(model:model))
                    }
                    self.getMarketClassList = listArray1
                    
                    let _RecommendMarketAd:[[String:AnyObject]] = _data["RecommendMarketAd"] as! [[String : AnyObject]]
                    var listArray2 = [QZGH_CYSQHomeGetRecommendMarketAdViewModel]()
                    for dict in _RecommendMarketAd ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_getRecommendMarketAd.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray2.append(QZGH_CYSQHomeGetRecommendMarketAdViewModel(model:model))
                    }
                    self.getRecommendMarketAdList = listArray2
                    
                    
                    let _PromotionMarketAd:[[String:AnyObject]] = _data["PromotionMarketAd"] as! [[String : AnyObject]]
                    var listArray3 = [QZGH_CYSQHomeGetPromotionMarketAdViewModel]()
                    for dict in _PromotionMarketAd ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_getPromotionMarketAd.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray3.append(QZGH_CYSQHomeGetPromotionMarketAdViewModel(model:model))
                    }
                    self.getPromotionMarketAdList = listArray3
                    
                    
                    let _headSlideService:[[String:AnyObject]] = _data["headSlideService"] as! [[String : AnyObject]]
                    var listArray4 = [QZGH_CYSQHomeSildeHeadViewModel]()
                    for dict in _headSlideService ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_sildeHead.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray4.append(QZGH_CYSQHomeSildeHeadViewModel(model:model))
                    }
                    self.sildeHeadList = listArray4
                    
                    let _todayRecommendSlideService:[[String:AnyObject]] = _data["todayRecommendSlideService"] as! [[String : AnyObject]]
                    var listArray5 = [QZGH_CYSQHomeSildeTodayRecommendViewModel]()
                    for dict in _todayRecommendSlideService ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_sildeTodayRecommend.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray5.append(QZGH_CYSQHomeSildeTodayRecommendViewModel(model:model))
                    }
                    self.sildeTodayRecommendList = listArray5

                    
                    //完成回调
                    completion(isSuccess)
                }
            }
        }
    }
    
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载热销产品
    ///
    /// - Parameters:
    ///   - pullup: 是否上拉加载
    ///   - completion: 完成回调
    func loadHotSell(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            //QZHEnterprisePortalModel.pageNo += 1
        }else{
            //QZHEnterprisePortalModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method:  .POST, url: "standard/productGoods/hotSell", params: ["pageNo":1 as AnyObject,"pageSize":16 as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    let _list:[[String:AnyObject]] = _data["list"] as! [[String : AnyObject]]
                    //1.字典转模型
                    //1>定义结果可变数组
                    var listArray = [QZGH_CYSQHomeHotSellViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in _list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZGH_CYSQHomeModel_hotSell.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZGH_CYSQHomeHotSellViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.hotSellList += listArray
                        
                    }else{
                        
                        self.hotSellList = listArray
                        
                    }
                    
                    //3.判断上拉刷新的数据量
                    if pullup && listArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(isSuccess, false)
                    }else{
                        
                        //完成回调
                        completion(isSuccess,true)
                    }
                }
            }
        }
    }
}
