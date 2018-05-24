//
//  QZHCYSQ_SortProListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHCYSQ_SortProListViewModel:NSObject{
    // 分类产品列表数据视图模型懒加载
    lazy var proListStatus = [QZHCYSQ_SortProViewModel]()
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载数据模型列表
    ///
    /// - Parameters:
    ///   - pullUp: 上拉加载
    ///   - completion: 回调方法
    func loadList(pullUp:Bool,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
    
        //判断是否是上拉刷新，同时检查刷新错误
        if pullUp && pullupErrorTimes > maxPullupTryTimes{
            
            print("maxPullupTryTimes:\(maxPullupTryTimes)")
            completion(true,false)
            
            return
        }
        
        if pullUp{
            QZHCYSQSearchProListParamModel.pageNo = QZHCYSQSearchProListParamModel.pageNo+1
        }else{
            QZHCYSQSearchProListParamModel.pageNo = 1
        }
        
        // 网络请求
        QZHNetworkManager.shared.statusList(method: .POST, url: "query/product", params: ["pageNo":QZHCYSQSearchProListParamModel.pageNo as AnyObject,"pageSize":QZHCYSQSearchProListParamModel.pageSize as AnyObject,"categoryId":QZHCYSQSearchProListParamModel.categoryId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"]as! Int != 200{
                    completion(false,false)
                }else{
                    
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let _list:[[String:AnyObject]] = _data["list"]as! [[String : AnyObject]]
                    var listArray =  [QZHCYSQ_SortProViewModel]()
                    for dict in _list{
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHStoreProModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZHCYSQ_SortProViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if QZHCYSQSearchProListParamModel.pageNo != 1{
                        
                        self.proListStatus += listArray

                    }else{
                        
                        self.proListStatus = listArray

                        
                    }
                    //3.判断上拉刷新的数据量
                    if pullUp && listArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(false, false)
                    }else{
                        
                        //完成回调
                        completion(isSuccess,true)
                    }

                    
                    completion(true,isSuccess)
                }
            }
        }
        
    }
}
