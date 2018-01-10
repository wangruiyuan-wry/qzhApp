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
class QZHEnterprisePortalViewModel:NSObject{
    lazy var statusList = [QZHEnterprisePortalModel]()
    
    /// 加载企业列表
    ///
    /// - Parameter completion: 完成回调【网络请求是否成功】
    func loadStatus(completion:@escaping (_ isSuccess:Bool)->()){
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
    }
}
