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
    //为了用户安全，访问令牌有时限，默认用户三天
    ///模拟 token 过期 - > 服务器返回的状态码是 403
    var sccessToken:String? = "login"
    
    /// 用户登录标记(计算性属性)
    var userLogo:Bool!{
        return sccessToken != nil
    }
    
    func tokenRequest(method:QZHHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion: @escaping (_ json:AnyObject?,_ isSubccess:Bool)->()){
        
        //处理 token 字典
        //0>判断 token 是否为 nil 为 nil 则直接返回
        guard let token = sccessToken else {
            
            completion(nil, false)
            
            return
        }
        
        //1>判断 参数字典是否存在，如果为 nil 则新建一个字典
        var parameters=parameters
        if parameters == nil {
            //实例化字典
            parameters = [String:AnyObject]()
        }
        
        //2>设置参数字典
        //parameters!["id"] =  token
        
        //调用 request 发起真正的网络请求方法
        request(URLString: URLString, parameters: parameters, completion: completion)
    }
    
    //使用一个函数是封装 AFN 的 GET POST 请求
    ///
    /// - Parameters:
    ///   - method: GET POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 回调方法
    func request(method:QZHHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion: @escaping (_ json:AnyObject?,_ isSubccess:Bool)->()){
        if method == .GET{
           get(URLString, parameters: parameters, progress: nil, success: { (_, json) in
            completion(json as AnyObject, true)
           }, failure: { (task, error) in
            
            //处理用户 token 过期
            self.tokenOver(task: task!)
            
            completion(nil,false)
           })

        }else{
            post(URLString, parameters: parameters, progress: nil, success:{(_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                
                //处理用户 token 过期
                self.tokenOver(task: task!)
                
                completion(nil,false)
            })
        }
    }
    
    func tokenOver(task:URLSessionDataTask){
        if (task.response as? HTTPURLResponse)?.statusCode == 403 {
            print("token 过期了")
            
            //处理token过期操作
        }
    }
}

