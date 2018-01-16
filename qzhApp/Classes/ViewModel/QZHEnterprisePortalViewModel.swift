//
//  QZHEnterprisePortalViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/// 企业门户企业列表视图模型
/*
 父类的选择
 - 如果使用 KVC 或者字典转模型设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑（写了一些函数），可以不用继承任何父类。好处：更加轻量级
 
 使命：负责数据处理
*/


/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 2

class QZHEnterprisePortalViewModel:NSObject{
    
     /// 企业门户企业列表视图模型数组懒加载
    lazy var statusList = [QZHEnterprisePortalCompanyViewModel]()
    
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
                print("网络错误！！")
                completion(false)
            }else{
                if response["status"] as! Int != 200{
                    print("数据异常")
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
    
    /// 加载企业列表
    ///
    /// - Parameter pullup: 是否上拉标记
    /// - Parameter completion: 完成回调【网络请求是否成功,是否有更多的上拉】
    func loadStatus(pullup:Bool = false,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        
        //判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false)
            
            return
        }
        
        if pullup{
            QZHEnterprisePortalModel.pageNo += 1
        }else{
            QZHEnterprisePortalModel.pageNo = 1
        }
        //发起网络请求，返回企业列表数据[字典数组]
        QZHNetworkManager.shared.statusList(method:.POST,url: "portal/myStore/listMember", params: ["pageNo":QZHEnterprisePortalModel.pageNo as AnyObject,"pageSize":15 as AnyObject,"pca":QZHEnterprisePortalModel.pca as AnyObject,"enterpriceType":QZHEnterprisePortalModel.enterpriceType as AnyObject,"industryType":QZHEnterprisePortalModel.industryType as AnyObject,"order":QZHEnterprisePortalModel.order as AnyObject], completion: { (response, isSuccess) in
            if !isSuccess {
                print("网络错误！！")
                completion(false, false)
            } else{
                if response["status"] as! Int != 200{
                    print("数据异常")
                    completion(false, false)
                }else{
                    let _data:Dictionary<String,AnyObject> = response["data"] as! Dictionary<String, AnyObject>
                    let list:[[String:AnyObject]] = _data["list"] as! [[String:AnyObject]]
                    //1.字典转模型
                    //1>定义结果可变数组
                    var listArray = [QZHEnterprisePortalCompanyViewModel]()
                    
                    //2>遍历服务器返回的字典数组，字典转模型
                    for dict in list ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHEnterprisePortalModel.yy_model(with:newDict) else{
                            continue
                        }
                        
                        //b）将model添加到数组
                        listArray.append(QZHEnterprisePortalCompanyViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullup{
                        
                        self.statusList += listArray
                        
                    }else{
                        
                        self.statusList = listArray
                        
                    }
                    //print(listArray)
                    
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
        })
    }
}

/*
 
 NetworkRequest().getRequest("portal/myStore/enterpriseList", params: [:], urlType: 0, success: {
 (response) in
 if response["status"] as! Int != 200{
 print("数据异常")
 }else{
 let _data:Dictionary<String,AnyObject> = response["data"] as! Dictionary<String, AnyObject>
 
 let _list:[Dictionary<String,AnyObject>] = _data["list"] as! [Dictionary<String, AnyObject>]
 print(_data["list"])
 //1.字典转模型
 guard let listArray = NSArray.yy_modelArray(with: QZHEnterprisePortalModel.self, json: _list ?? [])as? [QZHEnterprisePortalModel] else{
 completion(false)
 return
 }
 
 //2.拼接数据
 self.statusList += listArray
 
 //完成回调
 completion(true)
 }
 
 }) { (Error) in
 print(Error)
 }

 */
