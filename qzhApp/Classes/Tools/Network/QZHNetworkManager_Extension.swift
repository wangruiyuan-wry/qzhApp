//
//  QZHNetworkManager_Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import AFNetworking
// MARK: - 封装千纸鹤的网络请求
extension QZHNetworkManager{
    
    /// 加载千纸鹤数据字典数组
    ///
    /// - Parameters:
    ///   - url: 接口连接
    ///   - params: 参数字典
    ///   - pageSize: 每次加载的数据量
    ///   - pageNo: 加载数据的页码
    ///   - completion: 完成回调[list:千纸鹤数据字典／是否成功]
    func statusList(method:QZHHTTPMethod = .GET,url:String,params:[String:AnyObject],completion:@escaping (_ list:[String:AnyObject],_ isSuccess:Bool)->()){
        let urlString = "\(httpURL)\(url)"
        request(method:method,URLString:urlString, parameters: params){
            (json,isSuccess) in
            if json == nil{
                UIViewController.currentViewController()?.present(QZHVisitorView(), animated: true, completion: nil)
            }else if  json?["status"]as!Int == 400 && url != "personalCenter/myFootprint/add" && url != "personalCenter/attentionStore/getMyInfo" && url != "order/shopCart/list" && url != "user/tokenLogin"{
                UIViewController.currentViewController()?.present(QZHOAuthViewController(), animated: true, completion: nil)
            }else{
                //print(json)
                completion(json as! [String : AnyObject],isSuccess)
            }
        }
    }
    
    func statusFile(method:QZHHTTPMethod = .GET,url:String,params:[String:AnyObject],completion:@escaping (_ list:AnyObject,_ isSuccess:Bool)->()){
        let urlString = "\(httpURL)\(url)"
        requestArray(method:method,URLString:urlString, parameters: params){
            (json,isSuccess) in
             completion(json!,isSuccess)
        }
    }

}
