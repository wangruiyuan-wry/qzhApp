//
//  NetWork.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import Alamofire

private let NetworkRequestShareInstance=NetworkRequest()

class NetworkRequest
{
    var result:String=""
    class var sharedInstance:NetworkRequest{
        return NetworkRequestShareInstance
    }
}

extension NetworkRequest{
    
    func getRequest(_ urlString:String,params:[String:Any],urlType:Int,success:@escaping(_ response:Dictionary<String,AnyObject>)->(),failture:@escaping(_ error:Error)->()){
        var url:String=""
        url="http://192.168.100.73:81/\(urlString)"
        Alamofire.request(url,method:HTTPMethod.get,parameters:params,encoding:URLEncoding.default,headers:nil).responseJSON{
            (response) in
            switch response.result{
            case .success(let value) :
                success(value as! Dictionary<String,AnyObject>)
            case .failure(let error):
                failture(error)
            }
        }
    }
    
    func postRequest(_ urlString:String,params:[String:Any],urlType:Int,success:@escaping(_ respnse:String)->(),failture:@escaping(_ error:Error)->()){
        var url:String=""
         url="http://192.168.100.73:81/\(urlString)"
        
        print(url)
        Alamofire.request(url,method:HTTPMethod.post,parameters:params,encoding:URLEncoding.default,headers:nil).responseJSON{
            (response) in
            switch response.result{
            case .success :
                if let value=response.result.value as? String{
                    success(value)
                }
            case .failure(let error):
                failture(error)
            }
        }
    }
    
    //post同步请求
    func sysnRequest(_ url:String,urlType:Int,param:[String:AnyObject],callback:((_ isOk:Bool)->Void)?){
        self.postRequest(url, params: param, urlType: urlType, success: {
            （response）->Void in
            callback?(true)
        }, failture: {
            （error）->Void in
            callback?(false)
        })
    }
    
    func upLoadImageRequust(_ params:[String:String] ,data:[Data],name:[String],success:@escaping(_ response:[String:AnyObject])->(),failutrue:@escaping(_ error:Error)->()){
        let headers=["content-type":"multipart/form-data"]
        
        let url="http://www.qzh360.com/businessAreaPic/"
        //var url="http://httpbin.org/"
        print("name:\(name)")
        Alamofire.upload(
            multipartFormData:{multipartFormData in
                let flag=params["flag"]
                let userId=params["userId"]
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!,withName:"flag")
                multipartFormData.append((userId?.data(using: String.Encoding.utf8)!)!,withName:"userId")
                
                for i in 0..<data.count{
                    multipartFormData.append(data[i],withName:"appPhoto",fileName:name[i],mimeType:"image/png")
                }
        },
            to:url,method:HTTPMethod.post,
            headers:headers,
            encodingCompletion:{
                encodingResult in
                print("上传图片：\(encodingResult)")
                switch encodingResult{
                    
                case .success(let request,_,_):
                    
                    print("upload:\(request.response)")
                case .failure(let encodingError):
                    failutrue(encodingError)
                    print(encodingError)
                }
        }
        )
    }
}

