//
//  QZHPersonalCenterMyViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHPersonalCenterMyViewModel:NSObject{
    // 订单信息视图信息懒加载
    lazy var orderCount = [QZHPersonalCenterOrderCountViewModel]()
    
    // 基本信息视图懒加载
    lazy var myInfo = [QZHPersonalCenterMyInfoViewModel]()
    
    // 个人信息视图懒加载
    lazy var personInfo = [QZHPersonalCenterPersonInfoViewModel]()
    
    /// 获取个人信息
    ///
    /// - Parameter completion: 回调方法
    func getMyInfo(completion:@escaping (_ isSuccess:Bool,_ isLogin:Bool,_ shouldRefresh:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/attentionStore/getMyInfo", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                completion(false,false,false)
            }else{
                if result["status"] as! Int == 400{
                    completion(true,false,true)
                }else if result["status"] as! Int != 200{
                    completion(false,true, false)
                }else{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    var my = [QZHPersonalCenterMyInfoViewModel]()
                    let newDict = PublicFunction().setNULLInDIC(_data)
                    //a）创建企业模型
                    let model = QZHPersonalCenterMyInfoModel.yy_model(with:newDict)
                    //b）将model添加到数组d
                    my.append(QZHPersonalCenterMyInfoViewModel(model:model!))
                    self.myInfo = my
                    
                    let _orderCount:[String:AnyObject] = _data["orderCount"] as! [String : AnyObject]
                    var order = [QZHPersonalCenterOrderCountViewModel]()
                    let orderCountDic = PublicFunction().setNULLInDIC(_orderCount)
                    let model1 = QZHPersonalCenterOrderCountModel.yy_model(with: orderCountDic)
                    order.append(QZHPersonalCenterOrderCountViewModel(model: model1!))
                     self.orderCount = order
                    
                    var _personInfo:[String:AnyObject] = [:]
                    _personInfo = _data["personInfo"] as! [String:AnyObject]
                    var person = [QZHPersonalCenterPersonInfoViewModel]()
                    let _personInfoDic = PublicFunction().setNULLInDIC(_personInfo)
                    let model2 = QZHPersonalCenterPersonInfoModel.yy_model(with: _personInfoDic)
                    person.append(QZHPersonalCenterPersonInfoViewModel(model:model2!))
                    self.personInfo = person
                    completion(isSuccess,true,true)
                }
            }
        }
    }
    
    // 退出登录
    func exitLogin(completion:@escaping (_ isSuccess:Bool,_ str:String)->()){
        var _cache:[String:AnyObject] = CacheFunc().getCahceData(fileName: "login.plist", folderName: "Login") 
        QZHNetworkManager.shared.statusList(method: .POST, url: "user/logout/\(_cache["token"]as! String)", params: [:]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as!Int == 200{
                    completion(isSuccess,"")
                }else{
                    completion(false,"退出登录失败")
                }
            }else{
                completion(false,"退出登录失败")
            }
        }
    }
    
    // 修改用户信息
    func editPersonInfo(completion:@escaping (_ isSuccess:Bool,_ str:String)->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "portal/eipAccounts/insertAccountInfo", params: ["phone":QZHPersonalCenterMyInfoModel.phone as AnyObject,"nickName":QZHPersonalCenterMyInfoModel.nickName as AnyObject,"realName":QZHPersonalCenterMyInfoModel.realName as AnyObject,"tel":QZHPersonalCenterMyInfoModel.tel as AnyObject,"companyName":QZHPersonalCenterMyInfoModel.companyName as AnyObject,"headPort":QZHPersonalCenterMyInfoModel.headPort as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as!Int == 200{
                    
                    completion(isSuccess,"修改成功")
                }else{
                    completion(false,"修改失败")
                }
            }else{
                completion(false,"修改失败")
            }
        }
    }

    func uploadPhoto(completion:@escaping (_ isSuccess:Bool,_ str:String)->()){
        QZHNetworkManager.shared.unload(urlString: "portal/homeAd/uploadpersonalInfoPic", parameters: ["file":QZHPersonalCenterMyInfoModel.photoStr as AnyObject,"picType":"img" as AnyObject], img: QZHPersonalCenterMyInfoModel.img, uploadProgress: { (progrss) in
            //print("progrss:\(progrss)")
        }, success: { (result) in
            print("result:\(result)")
            if result?["status"]as! Int == 200{
                completion(true,result?["data"] as! String)
               /* print(result?["data"] as! String)
                QZHNetworkManager.shared.statusList(method: .POST, url: "portal/eipAccounts/insertAccountInfo", params: ["headPort":result?["data"] as AnyObject]) { (result1, isSuccess) in
                    if isSuccess{
                        if result1["status"] as!Int == 200{
                            
                            completion(isSuccess,"修改成功")
                        }else{
                            completion(false,"修改失败")
                        }
                    }else{
                        completion(false,"修改失败")
                    }
                }*/
            }else{
                print("result:\(result)")
                completion(false,"图片上传失败")
            }
        }) { (error) in
            print("error:\(error.domain)")
            print("error:\(error)")
            completion(false,"图片上传失败------")
        }
    }
}
