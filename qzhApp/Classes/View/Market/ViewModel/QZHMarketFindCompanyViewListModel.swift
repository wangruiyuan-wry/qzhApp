//
//  QZHMarketFindCompanyViewListModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHMarketFindCompanyViewListModel: NSObject {
    
    // 找企业数据列表懒加载
    lazy var findCompanyListStatus = [QZHMarketFindCompanyViewModel]()
    
    /// 企业类型列表视图数组懒加载
    lazy var enterpriseTypeList = [QZHEnterpriseTypeViewModel]()
    
    /// 一级行业列表视图数组懒加载
    lazy var fristIndustryList = [QZHEnterpriseFirstViewModel]()
    
    /// 二级行业列表视图数组懒加载
    lazy var secondIndustryList = [QZHEnterpriseSecondViewdModel]()
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载一级行业
    ///
    /// - Parameter completion: 完成回调
    func loadFirstIndustry(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/industry/listFirstLv", params: [:]) { (response,isSuccess) in
            if !isSuccess{
                print("网络错误！！")
                completion(false)
            }else{
                if response["status"] as! Int != 200{
                    print("数据异常")
                    completion(false)
                }else{
                    let _data:[Dictionary<String,AnyObject>] = response["data"] as! [Dictionary<String, AnyObject>]
                    var listArray = [QZHEnterpriseFirstViewModel]()
                    for dict in _data ?? []{
                        
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHEnterpriseFirstModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHEnterpriseFirstViewModel(model:model))
                    }
                    //2. FIXME 拼接数据
                    self.fristIndustryList += listArray
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 根据一级行业加载二级行业
    ///
    /// - Parameter completion: 完成回调
    func loadSecondIndustry(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/industry/listSecondLv/\(QZHEnterprisePortalModel.superKey)", params: [:]) { (response,isSuccess) in
            if !isSuccess{
                print("网络错误！！")
                completion(false)
            }else{
                if response["status"] as! Int != 200{
                    print("数据异常")
                    completion(false)
                }else{
                    self.secondIndustryList = []
                    let _data:[Dictionary<String,AnyObject>] = response["data"] as! [Dictionary<String, AnyObject>]
                    var listArray = [QZHEnterpriseSecondViewdModel]()
                    for dict in _data ?? []{
                        
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHEnterpriseSecondModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHEnterpriseSecondViewdModel(model:model))
                    }
                    //2. FIXME 拼接数据
                    self.secondIndustryList += listArray
                    completion(isSuccess)
                }
            }
        }
    }
    
    
    /// 加载企业类型
    ///
    /// - Parameter completion: 完成回调
    func loadEnterpriseType(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/enterprise/listNames", params: [:]) { (response,isSuccess) in
            
            if !isSuccess{
                completion(false)
            }else{
                if response["status"] as! Int != 200{
                    completion(false)
                }else{
                    let _data:[Dictionary<String,AnyObject>] = response["data"] as! [Dictionary<String, AnyObject>]
                    var listArray = [QZHEnterpriseTypeViewModel]()
                    for dict in _data ?? []{
                        
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHEnterpriseTypeModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHEnterpriseTypeViewModel(model:model))
                    }
                    //2. FIXME 拼接数据
                    self.enterpriseTypeList += listArray
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 加载公司列表
    ///
    /// - Parameters:
    ///   - pullup: 是否上拉加载
    ///   - completion: 回调方法
    func getCompanyList(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHMarketFindCompanyModel.pageNo += 1
        }else{
            QZHMarketFindCompanyModel.pageNo = 1
        }
        
        // 获取网络数据并返回
        QZHNetworkManager.shared.statusList(method: .POST, url: "crm/company/list", params: ["searchParam":"\(QZHMarketFindCompanyModel.searchParam )" as AnyObject,"pageNo":QZHMarketFindCompanyModel.pageNo as AnyObject,"pageSize":QZHMarketFindCompanyModel.pageSize as AnyObject,"comprehensive":QZHMarketFindCompanyModel.coprehensive as AnyObject,"area":QZHMarketFindCompanyModel.area as AnyObject,"industry_type":QZHMarketFindCompanyModel.industry_type as AnyObject,"enterprise_type":QZHMarketFindCompanyModel.enterprise_type as AnyObject]) { (result, isSuccess) in            
            if !isSuccess {
                completion(false, false)
            } else{
                if result["status"] as! Int != 200{
                    completion(false, false)
                }else{
                    print("result:\(result)")
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    let list:[[String:AnyObject]] = _data["list"] as! [[String:AnyObject]]
                    //1.字典转模型
                    //1>定义结果可变数组
                    var listArray = [QZHMarketFindCompanyViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHMarketFindCompanyModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHMarketFindCompanyViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.findCompanyListStatus += listArray
                        
                    }else{
                        
                        self.findCompanyListStatus = listArray
                        
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
