//
//  QZHCollectListPorListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHCollectListPorListViewModel: NSObject {
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    // 收藏夹列表视图模型懒加载
    lazy var collectListStatus = [QZHCollectListPorViewModel]()
    
    /// 加载收藏夹列表数据
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
            QZHCollectListPorModel.pageNo = QZHCollectListPorModel.pageNo+1
        }else{
            QZHCollectListPorModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/collectProduct/select", params: ["pageNo":QZHCollectListPorModel.pageNo as AnyObject,"pageSize":QZHCollectListPorModel.pageSize as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let list:[[String:AnyObject]] = _data["productGoodsDetail"] as! [[String : AnyObject]]
                    var listArray = [QZHCollectListPorViewModel]()

                    for dic in list {
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHCollectListPorModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        listArray.append(QZHCollectListPorViewModel(model:model!))
                     }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.collectListStatus += listArray
                        
                    }else{
                        
                        self.collectListStatus = listArray
                        
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
    
    
    /// 加入收藏
    ///
    /// - Parameter completion: 回调方法
    func addCollect(completion:@escaping (_ isSuccess:Bool,_ mag:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/collectProduct/insert", params: ["goodsId":QZHCollectListPorModel.goodsId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, "收藏失败")
            }else{
                if result["status"] as! Int == 200{
                    completion(true, "收藏成功")
                }else{
                    completion(false, "收藏失败")
                }
            }
        }
    }
    /// 取消收藏
    ///
    /// - Parameter completion: 回调方法
    func delsCollect(completion:@escaping (_ isSuccess:Bool,_ mag:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/collectProduct/canselCollectProduct", params: ["goodsId":QZHCollectListPorModel.goodsId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, "取消失败")
            }else{
                if result["status"] as! Int == 200{
                    completion(true, "取消成功")
                }else{
                    completion(false, "取消失败")
                }
            }
        }
    }
    
    func delCollect(completion:@escaping (_ isSuccess:Bool,_ mag:String)->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "personalCenter/collectProduct/delet", params: ["ids":QZHCollectListPorModel.ids as AnyObject]) { (result, isSuccess) in
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
