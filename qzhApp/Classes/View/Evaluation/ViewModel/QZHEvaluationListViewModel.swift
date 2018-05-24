//
//  EvaluationListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/26.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 0

class QZHEvaluationListViewModel:NSObject{
    
    // 评价列表视图模型列表懒加载
    lazy var listStatus = [QZHEvaluationViewModel]()
    
    // 评价信息视图列表模型懒加载
    lazy var repliesStatus:[[QZHEvaluationRepliesViewModel]] = []
    
    // 评价详情
    lazy var infoStatus = [QZHEvaluationViewModel]()
    
    // 评价详情想信息
    lazy var infoRepliesStatus:[[QZHEvaluationRepliesViewModel]] = []
    
    // 产品评价列表视图
    lazy var ProListStatus = [QZHEvaluationViewModel]()
    
    // 产品评价信息视图列表模型懒加载
    lazy var ProRepliesStatus:[[QZHEvaluationRepliesViewModel]] = []
    
    /// 上拉刷新错误次数
    var pullupErrorTimes_pro = 0
    
    func loadProComment(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        
        if pullup && pullupErrorTimes_pro > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHEvaluationModel.pageNo = QZHEvaluationModel.pageNo+1
        }else{
            QZHEvaluationModel.pageNo = 1
        }
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productComment/listComment", params: ["goodsId":QZHCommentModel.goodsId as AnyObject,"status":QZHCommentModel.status as AnyObject,"pageNo":QZHEvaluationModel.pageNo as AnyObject,"pageSize":QZHEvaluationModel.pageSize as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    var listArray = [QZHEvaluationViewModel]()
                    var repliesList:[[QZHEvaluationRepliesViewModel]] = []
                    if _data.keys.contains("totalComment"){
                        QZHCommentModel.totalComment = _data["totalComment"] as! Int
                    }
                    if _data.keys.contains("badComment"){
                        QZHCommentModel.badComment = _data["badComment"] as! Int
                    }
                    if _data.keys.contains("goodComment"){
                        QZHCommentModel.goodComment = _data["goodComment"] as! Int
                    }
                    if _data.keys.contains("middleComment"){
                        QZHCommentModel.middleComment = _data["middleComment"] as! Int
                    }
                    if _data.keys.contains("data"){
                        let _dataArray:[[String:AnyObject]] = _data["data"] as! [[String : AnyObject]]
                        for dic in _dataArray{
                            let newDic = PublicFunction().setNULLInDIC(dic)
                            let model = QZHEvaluationModel.yy_model(with:newDic)
                            
                            //b）将model添加到数组
                            listArray.append(QZHEvaluationViewModel(model:model!))
                            
                            var _repliesList = [QZHEvaluationRepliesViewModel]()
                            if dic.keys.contains("replies"){
                                let _replies:[[String:AnyObject]] = dic["replies"] as! [[String : AnyObject]]
                                for repliesDic in _replies{
                                    let newReplies = PublicFunction().setNULLInDIC(repliesDic)
                                    let models = QZHEvaluationRepliesModel.yy_model(with: newReplies)
                                    
                                    _repliesList.append(QZHEvaluationRepliesViewModel(model: models!))
                                }
                            }
                            repliesList.append(_repliesList)
                        }
                        if pullup{
                            self.ProListStatus += listArray
                            self.ProRepliesStatus += repliesList
                        }else{
                            self.ProListStatus = listArray
                            self.ProRepliesStatus = repliesList
                        }
                    }
                    //3.判断上拉刷新的数据量
                    if pullup && listArray.count == 0 {
                        
                        self.pullupErrorTimes_pro += 1
                        
                        completion(true, false)
                    }else{
                        
                        //完成回调
                        completion(true,true)
                    }
                    
                    
                }
            }
        }
    }
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载列表数据
    ///
    /// - Parameters:
    ///   - pullup: 上拉加载
    ///   - completion: 回调方法
    func loadList(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHEvaluationModel.pageNo = QZHEvaluationModel.pageNo+1
        }else{
            QZHEvaluationModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productComment/accountCommentList", params: ["pageNo":QZHEvaluationModel.pageNo as AnyObject,"pageSize":QZHEvaluationModel.pageSize as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    var listArray = [QZHEvaluationViewModel]()
                    var repliesList:[[QZHEvaluationRepliesViewModel]] = []
                    if _data.keys.contains("data"){
                        let _dataArray:[[String:AnyObject]] = _data["data"] as! [[String : AnyObject]]
                        for dic in _dataArray{
                            let newDic = PublicFunction().setNULLInDIC(dic)
                            let model = QZHEvaluationModel.yy_model(with:newDic)
                            
                            //b）将model添加到数组
                            listArray.append(QZHEvaluationViewModel(model:model!))
                            
                            var _repliesList = [QZHEvaluationRepliesViewModel]()
                            if dic.keys.contains("replies"){
                                let _replies:[[String:AnyObject]] = dic["replies"] as! [[String : AnyObject]]
                                for repliesDic in _replies{
                                    let newReplies = PublicFunction().setNULLInDIC(repliesDic)
                                    let models = QZHEvaluationRepliesModel.yy_model(with: newReplies)
                                    
                                    _repliesList.append(QZHEvaluationRepliesViewModel(model: models!))
                                }
                            }
                            repliesList.append(_repliesList)
                        }
                        if pullup{
                            self.listStatus += listArray
                            self.repliesStatus += repliesList
                        }else{
                            self.listStatus = listArray
                            self.repliesStatus = repliesList
                        }
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
    
    /// 加载评论详情数据信息
    ///
    /// - Parameter completion: 回调方法
    func loadInfo(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productComment/getProductComment", params: ["_id":QZHEvaluationInfoModel._id as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"] as!Int != 200{
                    completion(false)
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    
                    var listArray = [QZHEvaluationViewModel]()
                    var repliesList:[[QZHEvaluationRepliesViewModel]] = []

                    for dic in _data{
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        let model = QZHEvaluationModel.yy_model(with:newDic)
                            
                        //b）将model添加到数组
                        listArray.append(QZHEvaluationViewModel(model:model!))
                            
                        var _repliesList = [QZHEvaluationRepliesViewModel]()
                        if dic.keys.contains("replies"){
                            let _replies:[[String:AnyObject]] = dic["replies"] as! [[String : AnyObject]]
                            for repliesDic in _replies{
                                let newReplies = PublicFunction().setNULLInDIC(repliesDic)
                                let models = QZHEvaluationRepliesModel.yy_model(with: newReplies)
                                    
                                _repliesList.append(QZHEvaluationRepliesViewModel(model: models!))
                            }
                        }
                        repliesList.append(_repliesList)
                    }

                    self.infoStatus = listArray
                    self.infoRepliesStatus = repliesList
                   completion(isSuccess) 
                }
            }
        }
    }
    
    /// 追加评价
    ///
    /// - Parameter completion: 回调方法
    func AddComment(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productComment/updateComment", params: ["_id":QZHCommentModel._id as AnyObject,"goodsDescripe":QZHCommentModel.goodsDescripe as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"]as!Int == 200{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
    }
    
    /// 发表评价
    ///
    /// - Parameter completion: 回调方法
    func comment(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productComment/saveComment2", params: ["orderNum":QZHCommentModel.orderNum as AnyObject,"data":QZHCommentModel.data as AnyObject,"serviceComment":QZHCommentModel.seviceComment as AnyObject,"productComment":QZHCommentModel.productComment as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"]as!Int == 200{
                    completion(true)
                }else{
                    completion(false)
                }
            }
        }
    }
}
