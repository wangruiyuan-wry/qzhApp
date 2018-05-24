//
//  QZHHomeViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/22.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHHomeViewModels: NSObject {
    
    /// 首页企业门户广告视图模型数组懒加载
    lazy var QYMHList = [QZHHomeViewModel]()
    
    /// 首页产业商圈广告视图模型数组懒加载
    lazy var CYSQList = [QZHHomeViewModel]()
    
    /// 首页积分优购广告视图模型数组懒加载
    lazy var JFYGList = [QZHHomeViewModel]()
    
    /// 首页社区商城广告视图模型数组懒加载
    lazy var SQSCList = [QZHHomeViewModel]()
    
    /// 首页轮播广告视图模型数组懒加载
    lazy var LBTList = [QZHHomeViewModel]()
    
    /// 加载首页广告数据
    ///
    /// - Parameter completion: 完成回调
    func loadHomeAd(completion:@escaping (_ model1:[QZHHomeViewModel],_ model2:[QZHHomeViewModel],_ model3:[QZHHomeViewModel],_ model4:[QZHHomeViewModel],_ model5:[QZHHomeViewModel],_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        QZHNetworkManager.shared.statusList(url: "portal/homeAd", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                print("网络错误！！！")
                completion([],[],[],[],[],false,false)
            }else{
                if result["status"] as! Int != 200{
                    print("数据异常！！！")
                    completion([],[],[],[],[],false,false)
                }else{
                    print(result["data"])
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    //企业门户广告
                    if _data.keys.contains("qymh"){
                        let qymhData:[[String:AnyObject]] = _data["qymh"] as! [[String:AnyObject]]
                        var qymhList = [QZHHomeViewModel]()
                        
                        for dict in qymhData ?? []{
                            
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHHomeModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            qymhList.append(QZHHomeViewModel(model:model))
                        }
                        //2. FIXME 拼接数据
                        self.QYMHList = qymhList
                    }else{
                        self.QYMHList = []
                    }
                    
                    
                    //产业商圈广告
                    if _data.keys.contains("cysq"){
                        let cysqData:[[String:AnyObject]] = _data["cysq"] as! [[String:AnyObject]]
                        var cysqList = [QZHHomeViewModel]()
                        
                        for dict in cysqData ?? []{
                            
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHHomeModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            cysqList.append(QZHHomeViewModel(model:model))
                        }
                        //2. FIXME 拼接数据
                        self.CYSQList = cysqList
                    }else{
                        self.CYSQList = []
                    }
                    
                    //积分优购
                    if _data.keys.contains("jfyg"){
                        let jfygData:[[String:AnyObject]] = _data["jfyg"] as! [[String:AnyObject]]
                        var jfygList = [QZHHomeViewModel]()
                        
                        for dict in jfygData ?? []{
                            
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHHomeModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            jfygList.append(QZHHomeViewModel(model:model))
                        }
                        //2. FIXME 拼接数据
                        self.JFYGList += jfygList
                        
                    }else{
                        self.JFYGList = []
                    }
                    
                    // 社区商城
                    if _data.keys.contains("sqsc"){
                    
                        let sqscData:[[String:AnyObject]] = _data["sqsc"] as! [[String:AnyObject]]
                        var sqscList = [QZHHomeViewModel]()
                        
                        for dict in sqscData ?? []{
                            
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHHomeModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            sqscList.append(QZHHomeViewModel(model:model))
                        }
                        //2. FIXME 拼接数据
                        self.SQSCList = sqscList
                    }else{
                        self.SQSCList = []
                    }
                    
                    // 轮播图
                    print("lbt:\(_data["lbt"])")
                    if _data.keys.contains("lbt"){
                        let lbtData:[[String:AnyObject]] = _data["lbt"] as! [[String:AnyObject]]
                        var lbtList = [QZHHomeViewModel]()
                        
                        for dict in lbtData ?? []{
                            
                            //对字典进行处理
                            let newDict = PublicFunction().setNULLInDIC(dict)
                            //a）创建企业模型
                            guard let model = QZHHomeModel.yy_model(with:newDict) else{
                                continue
                            }
                            
                            //b）将model添加到数组
                            lbtList.append(QZHHomeViewModel(model:model))
                        }
                        
                        //2. FIXME 拼接数据
                        self.LBTList = lbtList
                    }else{
                        self.LBTList = []
                    }
                   
                    
                    completion(self.LBTList, self.SQSCList, self.CYSQList, self.QYMHList, self.JFYGList, isSuccess,true)
                    
                }
            }
        }
    }
}
