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
    
    /// 用户登录标记(计算性属性)
    var userLogo:Bool!{
        return accessToken != nil
    }
    
    func tokenRequest(method:QZHHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion: @escaping (_ json:AnyObject?,_ isSubccess:Bool)->()){
        
        //处理 token 字典
        //0>判断 token 是否为 nil 为 nil 则直接返回
        guard let token = accessToken else {
            
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
        var _cache:[String:AnyObject] = CacheFunc().getCahceData(fileName: "login.plist", folderName: "Login") as! [String : AnyObject]
        if _cache["token"] == nil{
            QZHNetworkManager.shared.requestSerializer.setValue(accessToken, forHTTPHeaderField: "QZH_TOKEN")
        }else{
            QZHNetworkManager.shared.requestSerializer.setValue(_cache["token"]! as! String, forHTTPHeaderField: "QZH_TOKEN")
        }//73758079b2a042fd8988f4e995189080
        //QZHNetworkManager.shared.requestSerializer.setValue("73758079b2a042fd8988f4e995189080", forHTTPHeaderField: "QZH_TOKEN")
        print(_cache["token"])
        QZHNetworkManager.shared.responseSerializer = AFJSONResponseSerializer()
        if method == .GET{
           get(URLString, parameters: parameters, progress: nil, success: { (_, json) in
            completion(json as AnyObject, true)
           }, failure: { (task, error) in
            //处理用户 token 过期
            self.tokenOver(task: task!)
            
            completion(nil,false)
           })

        }else{
            post(URLString, parameters: parameters, progress: nil, success:{(hesder, json) in
                print("parameters222:\(parameters)")
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print(error)
                //处理用户 token 过期
                self.tokenOver(task: task!) 
                completion(nil,false)
            })
        }
    }
    
    //使用一个函数是封装 AFN 的 GET POST 请求
    ///
    /// - Parameters:
    ///   - method: GET POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 回调方法
    func requestArray(method:QZHHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion: @escaping (_ json:AnyObject?,_ isSubccess:Bool)->()){
        
        var _cache:[String:AnyObject] = CacheFunc().getCahceData(fileName: "login.plist", folderName: "Login") as! [String : AnyObject]
        print("_cache=========\(_cache)")
        QZHNetworkManager.shared.requestSerializer.setValue(accessToken, forHTTPHeaderField: "QZH_TOKEN")
        QZHNetworkManager.shared.responseSerializer = AFHTTPResponseSerializer()
        if method == .GET{
            get(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print(error)
                //处理用户 token 过期
                self.tokenOver(task: task!)
                
                completion(nil,false)
            })
            
        }else{
            post(URLString, parameters: parameters, progress: nil, success:{(_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print(error)
                //处理用户 token 过期
                self.tokenOver(task: task!)
                completion(nil,false)
            })
        }
    }
    
    // MARK: - 封装 AFN 方法
    
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// 封装 AFN 的上传文件方法
    ///
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    ///uploadProgress 进度对象
    /// - parameter img:      UIImage对象
    /// - parameter completion: 完成回调
    
    func unload(urlString: String, parameters:[String:AnyObject], img : UIImage , uploadProgress: ((_ progress:Progress) -> Void)?, success: ((_ responseObject:AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        print("parameters:\(parameters)")
        let URLString = "\(httpURL)\(urlString)"
        //http://192.168.120.234:8100/
        print("URLString:\(URLString)")
        //let URLString = "http://192.168.120.234:8100/api/portal/homeAd/uploadpersonalInfoPic"
       // let URLString = "http://192.168.60.253:881/homeAd/uploadpersonalInfoPic"
        var _cache:[String:AnyObject] = CacheFunc().getCahceData(fileName: "login.plist", folderName: "Login") as! [String : AnyObject]
        QZHNetworkManager.shared.responseSerializer = AFJSONResponseSerializer()

        //print("_cache[ token]\(_cache["token"])")
        
        //print("http:\(QZHNetworkManager.shared.requestSerializer.httpRequestHeaders)")
        
        let array = ["text/html","text/plain","text/json","application/json","text/javascript"]
        
        let sets=NSSet(array: array) as! Set<AnyHashable>
        if _cache["token"] == nil{
            QZHNetworkManager.shared.requestSerializer.setValue(accessToken, forHTTPHeaderField: "QZH_TOKEN")
        }else{
            QZHNetworkManager.shared.requestSerializer.setValue(_cache["token"]! as! String, forHTTPHeaderField: "QZH_TOKEN")
        }
        
        
        QZHNetworkManager.shared.responseSerializer.acceptableContentTypes = sets as! Set<String>
        
        
        //QZHNetworkManager.shared.requestSerializer = AFHTTPRequestSerializer()
        QZHNetworkManager.shared.requestSerializer = AFJSONRequestSerializer()
        
        var tokenData = (_cache["token"]! as! String).data(using: .utf8)
        
        post(URLString, parameters: parameters, constructingBodyWith: { (formData:AFMultipartFormData?) in
            let imageData = UIImageJPEGRepresentation(img, 0.05)
            formData?.appendPart(withFileData: imageData!, name: "file", fileName: "file.jpg", mimeType: "image/jpeg")
            formData?.appendPart(withForm: tokenData!, name:"QZH_TOKEN")
        }, progress: { (progress) in
            uploadProgress!(progress)
        }, success: { (task, objc) in
            //print("http2:\(QZHNetworkManager.shared.requestSerializer.httpRequestHeaders)")

                success!(objc as AnyObject?)
            
        }, failure: { (task, error) in
            print("task:\(task)")
            print("task11:\(task.debugDescription)")
            print("error:\(error)")
            print("error111:\(error.localizedDescription)")
            failure!(error as NSError)
            
        })
        
    }
    
    func tokenOver(task:URLSessionDataTask){
        if (task.response as? HTTPURLResponse)?.statusCode == 403 {
            print("token 过期了")
            
            //处理token过期操作
        }
    }
    
}

