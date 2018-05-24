//
//  QZHFocusStoreListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHFocusStoreListViewModel:NSObject{
    // 关注店铺列表的视图模型懒加载
    lazy var storeStatus = [QZHFocusStoreViewModel]()
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载关注店铺列表数据
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
            QZHFocusStoreModel.pageNo = QZHFocusStoreModel.pageNo+1
        }else{
            QZHFocusStoreModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/attentionStore/select", params: ["pageNo":QZHFocusStoreModel.pageNo as AnyObject,"pagwSize":QZHFocusStoreModel.pageSize as AnyObject]) { (result, isSuccess) in

            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let list:[[String:AnyObject]] = _data["storeInformation"] as! [[String : AnyObject]]
                    var listArray = [QZHFocusStoreViewModel]()
                    
                    for dic in list {
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHFocusStoreModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        listArray.append(QZHFocusStoreViewModel(model:model!))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.storeStatus += listArray
                        
                    }else{
                        
                        self.storeStatus = listArray
                        
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
    
    /// 取消关注
    ///
    /// - Parameter completion: 回调方法
    func delAttStore(completion:@escaping (_ isSuccess:Bool,_ mas:String)->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "personalCenter/attentionStore/delet", params: ["ids":QZHFocusStoreModel.ids as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, "删除失败，\(result["data"]!)")
            }else{
                if result["status"] as! Int == 200{
                    completion(true, "删除成功")
                }else{
                    completion(false, "删除失败，\(result["data"]!)")
                }
            }
        }
    }
}
