//
//  QZHProductDetailViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1
class QZHProductDetailViewModel:NSObject{
    
    // 货品视图模型
    lazy var goodsStatus = [QZHProductDetail_GoodsViewModel]()
    
    // 产品图片视图模型
    lazy var picStatus = [QZHProductDetail_PROPicViewModel]()
    
    // 产品价格视图模型
    lazy var proPriceStatus = [QZHProductDetail_PROPrice2StockByIdViewModel]()
    
    // 产品规格视图模型
    lazy var proSpaceStatus = [QZHProductDetail_PROSpecOptionViewModel]()
    
    // 产品参数视图模型
    lazy var proAttOptionsStatus = [QZHProductDetail_PROAttributeOptionViewModel]()
    
    // 店铺视图模型
    lazy var shopStatus = [QZHProductDetail_PROShopStatisticsViewModel]()
    
    // 关注收藏信息视图模型
    lazy var attentionCollectStatus = [QZHProductDetail_AttentionCollectViewModel]()
    
    // 评价信息视图模型
    lazy var commentStatus = [QZHProductDetail_PROListCommentViewModel]()
    
    // 评价信息内容
    lazy var commentReplies:[[QZHProductDetail_PROListCommentRepliesViewModel]] = []
    
    // 产品详情数据
    lazy var proDeatailStatus = [QZHProductDetail_PRODeatailViewModel]()
    
    // 推荐产品视图模型
    lazy var proRecommendStatus = [QZHProductDetail_PRORecommendViewModel]()
    
    func addFooter(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/myFootprint/add", params: ["goodsId":QZHProductDetailModel.goodsId as AnyObject]) { (result, isSuccess) in
            completion(isSuccess)
        }
    }
    
    // 获取产品详情
    func getProductGoodsDetail(completion:@escaping (_ isSuccess:Bool)->(),getPro:@escaping (_ isSuccess:Bool)->()){
        //print("QZHProductDetailModel.goodsId:\(QZHProductDetailModel.goodsId)")
        //QZHProductDetailModel.goodsId = 1
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productGoods/proDetail", params: ["goodsId":QZHProductDetailModel.goodsId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
                getPro(false)
            }else{
                print(result)
                if result["status"] as!Int == 200{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    if _data["goods"] is NSNull{}else{
                        let _goods:Dictionary<String,AnyObject> = _data["goods"] as! Dictionary<String, AnyObject>
                        var listArray = [QZHProductDetail_GoodsViewModel]()
                        
                        let newDict = PublicFunction().setNULLInDIC(_goods)
                        //a）创建企业模型
                        let model = QZHProductDetailModel.yy_model(with:newDict)
                        
                        //b）将model添加到数组
                        listArray.append(QZHProductDetail_GoodsViewModel(model:model!))
                        //2. FIXME 拼接数据
                        self.goodsStatus = listArray
                    }
                    // 图片
                    if _data["picture"] is NSNull{
                    
                    }else{
                        let _pic:Dictionary<String,AnyObject> = _data["picture"] as! Dictionary<String, AnyObject>
                        var picList = [QZHProductDetail_PROPicViewModel]()
                        let newPic = PublicFunction().setNULLInDIC(_pic)
                    
                        let model1 = QZHProductDetail_PROPicModel.yy_model(with:_pic)
                    
                        picList.append(QZHProductDetail_PROPicViewModel(model: model1!))
                    
                        self.picStatus = picList
                    }
                    // 产品参数
                    if _data["attOptions"] is NSNull{
                        
                    }else{
                        let _att:[Dictionary<String,AnyObject>] = _data["attOptions"] as![ Dictionary<String, AnyObject>]
                        var attList = [QZHProductDetail_PROAttributeOptionViewModel]()
                        
                        for dict in _att {
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let models = QZHProductDetail_PROAttributeOptionModel.yy_model(with:newDict) else{
                                continue
                            }
                            //b）将model添加到数组
                            attList.append(QZHProductDetail_PROAttributeOptionViewModel(model:models))
                        }
                        self.proAttOptionsStatus = attList
                    }
                    
                    // 产品规格
                    if _data["specOptions"] is NSNull{
                        
                    }else{
                        let _spec:[Dictionary<String,AnyObject>] = _data["specOptions"] as! [Dictionary<String, AnyObject>]
                        var specList = [QZHProductDetail_PROSpecOptionViewModel]()
                        
                        for dict in _spec ?? []{
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let models = QZHProductDetail_PROSpecOptionModel.yy_model(with:newDict) else{
                                continue
                            }
                            //b）将model添加到数组
                            specList.append(QZHProductDetail_PROSpecOptionViewModel(model:models))
                        }
                        self.proSpaceStatus = specList
                    }
                    
                    // 店铺
                    if _data["shop"] is NSNull{
                        
                    }else{
                        let _shop:Dictionary<String,AnyObject> = _data["shop"] as! Dictionary<String, AnyObject>
                        var shopList = [QZHProductDetail_PROShopStatisticsViewModel]()
                        let newShop = PublicFunction().setNULLInDIC(_shop)
                        
                        let model3 = QZHProductDetail_PROShopStatisticsModel.yy_model(with:newShop)
                        
                        shopList.append(QZHProductDetail_PROShopStatisticsViewModel(model: model3!))
                        
                        self.shopStatus = shopList
                    }
                    
                    // 收藏信息
                    if _data["attentionCollect"] is NSNull{
                        
                    }else{
                        let _attentionCollect:Dictionary<String,AnyObject> = _data["attentionCollect"] as! Dictionary<String, AnyObject>
                        var attentionCollectList = [QZHProductDetail_AttentionCollectViewModel]()
                        let newattentionCollect = PublicFunction().setNULLInDIC(_attentionCollect)
                        
                        let model3 = QZHProductDetail_AttentionCollectModel.yy_model(with:newattentionCollect)
                        
                        attentionCollectList.append(QZHProductDetail_AttentionCollectViewModel(model: model3!))
                        
                        self.attentionCollectStatus = attentionCollectList
                    }
                    
                    // 评价信息
                    if _data.keys.contains("comment"){
                        let _comment:[String:AnyObject] = _data["comment"] as! [String:AnyObject]
                        QZHProductDetail_PROListCommentModel.count = _comment["totalNum"] as! Int
                        let _commentData:[[String:AnyObject]] = _comment["data"] as! [[String:AnyObject]]
                        var commentList = [QZHProductDetail_PROListCommentViewModel]()
                        var commentRepliesLists:[[QZHProductDetail_PROListCommentRepliesViewModel]] = []
                        for dict in _commentData{
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            let model = QZHProductDetail_PROListCommentModel.yy_model(with:newDict)
                            //b）将model添加到数组
                            commentList.append(QZHProductDetail_PROListCommentViewModel(model:model!))
                            var commentRepliesList = [QZHProductDetail_PROListCommentRepliesViewModel]()
                            var dic:[[String:AnyObject]] = [[:]]
                            if dict.keys.contains("replies"){
                                dic = dict["replies"] as! [[String : AnyObject]]
                                for d in dic ?? []{
                                    //对字典进行处理
                                    let newDict1 = PublicFunction().setNULLInDIC(d)
                                    //a）创建企业模型
                                    guard let model = QZHProductDetail_PROListCommentRepliesModel.yy_model(with:newDict1) else{
                                        continue
                                    }
                                    //b）将model添加到数组
                                    commentRepliesList.append(QZHProductDetail_PROListCommentRepliesViewModel(model:model))
                                }
                            }
                            commentRepliesLists.append(commentRepliesList)
                        }
                        self.commentStatus = commentList
                        self.commentReplies = commentRepliesLists
                        
                    }
                    
                    // 详情信息
                    if _data.keys.contains("detail"){
                        let _detail:[String:AnyObject] = _data["detail"] as! [String:AnyObject]
                        var detailList = [QZHProductDetail_PRODeatailViewModel]()
                        let newdetail = PublicFunction().setNULLInDIC(_detail)
                        
                        let model3 = QZHProductDetail_PRODeatailModel.yy_model(with:newdetail)
                        
                        detailList.append(QZHProductDetail_PRODeatailViewModel(model: model3!))
                        
                        self.proDeatailStatus = detailList
                    }
                    
                    
                    completion(isSuccess)
                    getPro(isSuccess)

                }else{
                    completion(false)
                    getPro(false)
                }
            }
        }
    }
    
    // 获取产品价格
    func getProductPrice(completion:@escaping (_ result:[QZHProductDetail_PROPrice2StockByIdViewModel],_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/product/price2StockById", params: ["productId":QZHProductDetailModel.productId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(self.proPriceStatus, false)
            }else{
                if result["status"]as!Int == 200{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    var listArray = [QZHProductDetail_PROPrice2StockByIdViewModel]()
                    
                    let newDict = PublicFunction().setNULLInDIC(_data)
                    //a）创建企业模型
                    let model = QZHProductDetail_PROPrice2StockByIdModel.yy_model(with:newDict)
                    
                    //b）将model添加到数组
                    listArray.append(QZHProductDetail_PROPrice2StockByIdViewModel(model:model!))
                    //2. FIXME 拼接数据
                    self.proPriceStatus = listArray
                    
                    completion(self.proPriceStatus, isSuccess)
                    
                }else{
                    completion(self.proPriceStatus, false)
                }
            }
        }
    }
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    // 获取推荐产品
    func getRecmPro(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(false,false)
            
            return
        }
        
        if pullup{
            QZHProductDetail_PRORecommendModel.pageNo += 1
        }else{
            QZHProductDetail_PRORecommendModel.pageNo = 1
        }

        
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productGoods/productsRecommend", params: ["memberId":QZHProductDetailModel.memberId as AnyObject,"pageNo":QZHProductDetail_PRORecommendModel.pageNo as AnyObject,"pageSize":QZHProductDetail_PRORecommendModel.pageSize as AnyObject]) { (result, isSuccess) in
            print("推荐产品：\(result)")
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
                    var listArray = [QZHProductDetail_PRORecommendViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in _list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHProductDetail_PRORecommendModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZHProductDetail_PRORecommendViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.proRecommendStatus += listArray
                        
                    }else{
                        
                        self.proRecommendStatus = listArray
                        
                    }
                    
                    //3.判断上拉刷新的数据量
                    if pullup && listArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(false, false)
                    }else{
                        
                        //完成回调
                        completion(isSuccess,true)
                    }
                }
            }
        }
    }
    
    /// 获取产品规格
    ///
    /// - Parameter completion: 回调
    func getProSpec(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productSpec/productGoodsSpecOption", params: ["goodsId":QZHProductDetailModel.goodsId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"] as!Int == 200{
                    // 产品规格
                    if result["data"] is NSNull{
                        
                    }else{
                        let _spec:[Dictionary<String,AnyObject>] = result["data"] as! [Dictionary<String, AnyObject>]
                        var specList = [QZHProductDetail_PROSpecOptionViewModel]()
                        
                        for dict in _spec ?? []{
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let models = QZHProductDetail_PROSpecOptionModel.yy_model(with:newDict) else{
                                continue
                            }
                            //b）将model添加到数组
                            specList.append(QZHProductDetail_PROSpecOptionViewModel(model:models))
                        }
                        self.proSpaceStatus = specList
                        
                    }
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 加入购物车
    ///
    /// - Parameter completion: 回调方法
    func addToCar(completion:@escaping (_ isSuccess:Bool,_ message:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/shopCart/insert", params: ["info":"{\"productId\":\(QZHProductDetailModel.productId),\"specOptionId\":\"\(QZHProductDetailModel.specOptionId)\",\"specOptionName\":\"\(QZHProductDetailModel.specOptionName)\",\"proCount\": \(QZHProductDetailModel.proCount),\"goodsId\":\(QZHProductDetailModel.goodsId),\"sellMemberId\":\(QZHProductDetailModel.sellMemberId)}" as AnyObject]) { (result, isSuccess) in
            print("result:\(result)")
            if result["status"] as!Int == 200{
                completion(isSuccess, "加入成功！！")
            }else{
                completion(isSuccess, "加入失败！！\(result["data"]!)")
            }
        }
    }
}
