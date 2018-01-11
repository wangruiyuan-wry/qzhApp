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
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    //页码
    var _pageNo :Int = 1
    
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
            _pageNo += 1
        }else{
            _pageNo = 1
        }
        
        //发起网络请求，返回企业列表数据[字典数组]
        QZHNetworkManager.shared.statusList(url: "portal/myStore/enterpriseList", params: ["pageNo":_pageNo as AnyObject,"pageSize":15 as AnyObject], completion: { (response, isSuccess) in
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
                        //a）创建企业模型
                        guard let model = QZHEnterprisePortalModel.yy_model(with:dict) else{
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
