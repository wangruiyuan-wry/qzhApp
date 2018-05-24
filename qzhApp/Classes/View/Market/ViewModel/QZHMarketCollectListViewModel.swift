//
//  QZHMarketCollectListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHMarketCollectListViewModel:NSObject{
    // 收藏企业列表视图模型懒加载
    lazy var collectStatus = [QZHMarketCollectViewModel]()
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    func loadCollectList(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHMarketCollectModel.pageNo += 1
        }else{
            QZHMarketCollectModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "crm/company/listCollect", params: ["collectType":QZHMarketCollectModel.collectType as AnyObject,"pageNo":QZHMarketCollectModel.pageNo as AnyObject,"pageSize":QZHMarketCollectModel.pageSize as AnyObject,"comprehensive":QZHMarketCollectModel.comperhensive as AnyObject,"area":QZHMarketCollectModel.area as AnyObject,"customerStatus":QZHMarketCollectModel.customerStatus as AnyObject]) { (result, isSuccess) in
            print(result)
                if !isSuccess {
                    completion(false, false)
                } else{
                    if result["status"] as! Int != 200{
                        completion(false, false)
                    }else{
                        let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                        let list:[[String:AnyObject]] = _data["list"] as! [[String:AnyObject]]
                        //1.字典转模型
                        //1>定义结果可变数组
                        var listArray = [QZHMarketCollectViewModel]()
                        
                        //2>遍历服务器返回的字典数组，字典转模型
                        for dict in list ?? []{
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHMarketCollectModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            listArray.append(QZHMarketCollectViewModel(model:model))
                        }
                        
                        //2. FIXME 拼接数据
                        if pullup{
                            
                            self.collectStatus += listArray
                            
                        }else{
                            
                            self.collectStatus = listArray
                            
                        }
                        
                        //3.判断上拉刷新的数据量
                        if pullup && listArray.count == 0 {
                            
                            self.pullupErrorTimes += 1
                            
                            completion(isSuccess, false)
                        }else{
                            
                            completion(isSuccess,true)
                        }

                    }
            }
        }
    }
}
