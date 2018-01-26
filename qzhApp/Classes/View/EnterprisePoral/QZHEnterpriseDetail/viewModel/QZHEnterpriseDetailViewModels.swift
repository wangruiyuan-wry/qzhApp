//
//  QZHEnterpriseDetailModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 2

class QZHEnterpriseDetailViewModels:NSObject{
    
    /// 企业信息视图模型数组懒加载
    lazy var detailList = [QZHEnterpriseDetailViewModel]()
    lazy var infoList = [QZHEnterpriseInfoViewModel]()
    
    // 企业产品视图模型数组懒加载
    lazy var proList = [QZHEnterpriseProViewModel]()
    
    func loadInfo(completion:@escaping (_ r1:[QZHEnterpriseDetailViewModel],_ r2:[QZHEnterpriseInfoViewModel],_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/myStore/companyIntroduce/\(QZHEnterpriseDetailModel.memberId)", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                print("网络错误！！！")
                completion([],[],false)
            }else{
                if result["status"]as! Int != 200{
                    print("数据异常！！！")
                    completion([],[],false)
                }else{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    
                    let _detail:Dictionary<String,AnyObject> = _data["eipMember"] as! Dictionary<String, AnyObject>
                    
                    let _info:Dictionary<String,AnyObject> = _data["eipInfo"] as! Dictionary<String, AnyObject>
                    
                    let detailDic = PublicFunction().setNULLInDIC(_detail)
                    
                    let models = QZHEnterpriseDetailModel.yy_model(with: detailDic)
                    self.detailList.append(QZHEnterpriseDetailViewModel(model:models!))
                    
                    let infoDic = PublicFunction().setNULLInDIC(_info)
                    let model = QZHEnterpriseInfoModel.yy_model(with: infoDic)
                    self.infoList.append(QZHEnterpriseInfoViewModel(model:model!))
                    completion(self.detailList,self.infoList,isSuccess)

                }
            }
        }
    }
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载企业产品列表
    ///
    /// - Parameters:
    /// - Parameter pullup: 是否上拉标记
    /// - Parameter completion: 完成回调【网络请求是否成功,是否有更多的上拉】
    func loadProList(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHEnterpriseProModel.pageNo += 1
        }else{
            QZHEnterpriseProModel.pageNo = 1
        }
        
        // 网络请求
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productGoods/hotSell", params: ["memberId":QZHEnterpriseDetailModel.memberId as AnyObject,"pageNo":QZHEnterpriseProModel.pageNo as AnyObject,"pageSize":QZHEnterpriseProModel.pageSize as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, false)
            }else{
                if result["status"] as! Int == 200{
                    completion(false, false)
                }else{
                    let _data:[Dictionary<String, AnyObject>] = result["data"] as! [Dictionary<String, AnyObject>]
                    var listArray = [QZHEnterpriseProViewModel]()
                    for dict in _data ?? []{
                        
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHEnterpriseProModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHEnterpriseProViewModel(model:model))
                    }
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.proList += listArray
                        
                    }else{
                        
                        self.proList = listArray
                        
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
