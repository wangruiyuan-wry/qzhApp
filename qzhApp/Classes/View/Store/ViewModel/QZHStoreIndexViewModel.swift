//
//  QZHStoreIndexViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/5.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 0

class QZHStoreIndexViewModel:NSObject{
    // 店铺信息视图模型
    lazy var storeInfo = [QZHStoreInfoViewModel]()
    
    // 店铺产品视图模型
    lazy var storePro = [QZHStoreProViewModel]()
    
    // 搜索店铺产品视图模型
    lazy var storeSearchPro = [QZHStoreProViewModel]()
    
    // 店铺分类视图模型
    lazy var storeSort = [QZHStoreSortViewModel]()
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 获取店铺信息
    ///
    /// - Parameter completion: 回调方法
    func getStoreInfo(pullup:Bool = false,completion:@escaping (_ otherInfo:[String:AnyObject],_ isSuccess:Bool)->()){
        
        var other:[String:AnyObject] = ["areaName":"" as AnyObject,"storeIndustryName":"" as AnyObject,"isAttent":0 as AnyObject,"name":"" as AnyObject]
        
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion([:],false)
            
            return
        }
        QZHNetworkManager.shared.statusList(method: .POST, url: "store/storeInformation/findStore", params: ["memberId":QZHStoreInfoModel.memberID as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(other,false)
            }else if result["status"] as!Int != 200{
                completion(other,false)
            }else{
                var listArray = [QZHStoreInfoViewModel]()
                let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                let _info:[String:AnyObject] = _data["info"] as! [String : AnyObject]
                let _store:[String:AnyObject] = _info["store"] as! [String : AnyObject]
                //对字典进行处理
                let newDict = PublicFunction().setNULLInDIC(_store)
                //a）创建企业模型
                 let model = QZHStoreInfoModel.yy_model(with:newDict)
                //b）将model添加到数组
                listArray.append(QZHStoreInfoViewModel(model:model!))
                self.storeInfo = listArray
                
                other.updateValue(_info["areaName"]!, forKey: "areaName")
                other.updateValue(_info["storeIndustryName"]!, forKey: "storeIndustryName")
                other.updateValue(_data["isAttent"]!, forKey: "isAttent")
                
                let company:[String:AnyObject] = _info["company"] as! [String : AnyObject]
                let companyInfo:[String:AnyObject] = company["eipMember"] as! [String : AnyObject]
                other.updateValue(companyInfo["name"]!, forKey: "name")
                
                
                //完成回调
                completion(other,isSuccess)
            }
        }
    }


    /// 添加关注
    ///
    /// - Parameter completion: 回调
    func insert(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/attentionStore/insert", params: ["storeId":QZHStoreInfoModel.storeId as AnyObject]) { (result, isSuccess) in
            print("result:\(result)")
            if isSuccess{
                if result["status"] as!Int == 200{
                    completion( isSuccess)
                }else{
                    completion(false)
                }
            }else{
                completion( isSuccess)
            }
        }
    }
    
    /// 删除关注
    ///
    /// - Parameter completion: 回调
    func delet(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "personalCenter/attentionStore/deletByStoreId", params: ["ids":QZHStoreInfoModel.storeId as AnyObject]) { (result, isSuccess) in
            print(result)
            if isSuccess{
                
                if result["status"] as!Int == 200{
                    completion( isSuccess)
                }else{
                    completion(false)
                }
            }else{
                completion( isSuccess)
            }
        }
    }
    
    /// 获取店铺首页产品列表
    ///
    /// - Parameter completion: 回调方法
    func getStorePro(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(false,false)
            
            return
        }
        
        if pullup{
            QZHStoreProModel.pageNo += 1
        }else{
            QZHStoreProModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "query/product", params: ["q":QZHStoreProModel.q as AnyObject,"pageNo":QZHStoreProModel.pageNo as AnyObject,"pageSize":QZHStoreProModel.pageSize as AnyObject,"order":QZHStoreProModel.order as AnyObject,"shopId":QZHStoreInfoModel.memberID as AnyObject,"brand":QZHStoreProModel.brand as AnyObject,"specOptionName":QZHStoreProModel.specOptionName as AnyObject]) { (result, isSuccess) in
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
                    var listArray = [QZHStoreProViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in _list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHStoreProModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZHStoreProViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.storePro += listArray
                        
                    }else{
                        
                        self.storePro = listArray
                        
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
    
    /// 获取搜索店铺产品列表
    ///
    /// - Parameters:
    ///   - pullup: 上拉加载标记
    ///   - completion: 回调方法
    func getStorePro_Search(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(false,false)
            
            return
        }
        
        if pullup{
            QZHStoreSearchProModel.pageNo += 1
        }else{
            QZHStoreSearchProModel.pageNo = 1
        }
        
        QZHNetworkManager.shared.statusList(method: .POST, url: "query/product", params: ["q":QZHStoreSearchProModel.q as AnyObject,"pageNo":QZHStoreSearchProModel.pageNo as AnyObject,"pageSize":QZHStoreSearchProModel.pageSize as AnyObject,"order":QZHStoreSearchProModel.order as AnyObject,"shopId":QZHStoreInfoModel.memberID as AnyObject,"brand":QZHStoreSearchProModel.brand as AnyObject,"specOptionName":QZHStoreSearchProModel.specOptionName as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, false)
            }else{
                 print("result:\(result)")
                if result["status"] as! Int != 200{
                    completion(false,false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    
                    let _list:[[String:AnyObject]] = _data["list"] as! [[String : AnyObject]]
                    //1.字典转模型
                    //1>定义结果可变数组
                    var listArray = [QZHStoreProViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in _list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHStoreProModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZHStoreProViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.storeSearchPro += listArray
                        
                    }else{
                        
                        self.storeSearchPro = listArray
                        
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
    
    /// 获取店铺产品分类
    ///
    /// - Parameter completion: 回调
    func getStoreSort(completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "store/storeCategory/listBymemberid", params: ["memberId":QZHStoreInfoModel.memberID as AnyObject]) { (result, isSuccess) in
            print(result)
            if !isSuccess{
                completion(false, false)
            }else if result["status"] as!Int != 200{
                completion(false, false)
            }else{
                
                var listArray = [QZHStoreSortViewModel]()
                let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                for dict in _data ?? []{
                    //对字典进行处理
                    let newDict = PublicFunction().setNULLInDIC(dict)
                    //a）创建企业模型
                    guard let model = QZHStoreSortModel.yy_model(with:newDict) else{
                        continue
                    }
                    //b）将model添加到数组
                    listArray.append(QZHStoreSortViewModel(model:model))
                }
                self.storeSort = listArray
                //完成回调
                completion(isSuccess, true)
            }
        }
    }
}
