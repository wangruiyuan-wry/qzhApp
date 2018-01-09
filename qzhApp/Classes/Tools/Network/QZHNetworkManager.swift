//
//  QZHNetworkManager.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/9.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit
import AFNetworking

enum  QZHHTTPMethod {
    case GET
    case POST
}

//网络管理工具
class QZHNetworkManager: AFHTTPSessionManager {
    
    /// 静态区 常量 闭包 
    ///在第一次访问时执行闭包，并且将结果保存在 shared 常量中
    static let shared = QZHNetworkManager()
    
    ///  访问令牌，所有网络请求，都基于此令牌（登陆除外）
    var sccessToken:String?
    
    
    //使用一个函数是封装 AFN 的 GET POST 请求
    ///
    /// - Parameters:
    ///   - method: GET POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 回调方法
    func request(method:QZHHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion: @escaping (_ json:AnyObject?,_ isSubccess:Bool)->()){
        let success = {(task:URLSessionDataTask,json:AnyObject?)->() in
            completion(json,true)
        }
        let failure = {(task:URLSessionDataTask?,error:NSError)->() in
            print("网络请求错误\(error)")
            completion(nil,false )
        }
        
        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: success as? (URLSessionDataTask, Any?) -> Void, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success as? (URLSessionDataTask, Any?) -> Void, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        }
    }
}

