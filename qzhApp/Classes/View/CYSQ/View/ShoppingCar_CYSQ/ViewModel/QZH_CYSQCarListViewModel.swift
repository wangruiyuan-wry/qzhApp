//
//  QZH_CYSQCarListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

/*
 父类的选择
 - 如果使用 KVC 或者字典转模型设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑（写了一些函数），可以不用继承任何父类。好处：更加轻量级
 
 使命：负责数据处理
 */


/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 0

class QZH_CYSQCarListViewModel:NSObject{
    
    // 产业商圈购物车列表视图模型加载
    lazy var shoppingCarList = [QZH_CYSQCarViewModel]()
    
    // 订单信息列表
    lazy var carProList:[[QZH_CYSQCarProViewModel]]=[]
    
    // 产品信息列表
    lazy var proInfoList:[[QZH_CYSQCarProInfoViewModel]] = []
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 使用网络请求获取购物车列表
    ///
    /// - Parameters:
    ///   - pullUp: 是否上拉加载
    ///   - completion: 回调方法
    func getCarList(pullUp:Bool,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool,_ isLogin:Bool,_ count:Int)->()){
        
        LoginModel.isLogin = 1
        //判断是否是上拉刷新，同时检查刷新错误
        if pullUp && pullupErrorTimes > maxPullupTryTimes{
            
            completion(true,false,true,QZH_CYSQCarModel.proCount)
            
            return
        }
        
        if pullUp{
            QZH_CYSQCarModel.pageNo = QZH_CYSQCarModel.pageNo+1
        }else{
            QZH_CYSQCarModel.pageNo = 1
        }
        //section
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/shopCart/list", params: ["pageNo":QZH_CYSQCarModel.pageNo as AnyObject]) { (result, isSuccess) in
            print(result)
            if isSuccess{
                if result["status"] as! Int == 400{
                    completion(true,false,false,0)
                }else if result["status"] as! Int == 200{
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let store:[[String:AnyObject]] = _data["list"] as! [[String : AnyObject]]
                    QZH_CYSQCarModel.proCount = _data["totalCount"] as! Int
                    // 店铺信息
                    var listArray = [QZH_CYSQCarViewModel]()
                    var proArray:[[QZH_CYSQCarProViewModel]] = []
                    var proInfoArray:[[QZH_CYSQCarProInfoViewModel]] = []
                    for dic in store{
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZH_CYSQCarModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        listArray.append(QZH_CYSQCarViewModel(model:model!))
                        
                        let proList:[[String:AnyObject]] = dic["list"] as! [[String : AnyObject]]
                        
                        var proListView = [QZH_CYSQCarProViewModel]()
                        var proInfoListView = [QZH_CYSQCarProInfoViewModel]()
                        for proDic in proList{
                            //let newProDic = PublicFunction().setNULLInDIC(proDic)
                            let model1 = QZH_CYSQCarProModel.yy_model(with:proDic)
                            proListView.append(QZH_CYSQCarProViewModel(model:model1!))
                            
                            let proInfo:[String:AnyObject] = proDic["productInfo"] as! [String : AnyObject]
                            let model2 = QZH_CYSQCarProInfoModel.yy_model(with:proInfo)
                            proInfoListView.append(QZH_CYSQCarProInfoViewModel(model:model2!))
                        }
                        proArray.append(proListView)
                        proInfoArray.append(proInfoListView)
                    }
                    
                    
                    //2. FIXME 拼接数据
                    if pullUp{
                        
                        self.shoppingCarList += listArray
                        self.carProList += proArray
                        self.proInfoList += proInfoArray
                    }else{
                        
                        self.shoppingCarList = listArray
                        self.carProList = proArray
                        self.proInfoList = proInfoArray
                        
                    }
                    
                    //3.判断上拉刷新的数据量
                    if pullUp && listArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(false, false,true,QZH_CYSQCarModel.proCount)
                        
                    }else{
                        
                        //完成回调
                        completion(true,true,true,QZH_CYSQCarModel.proCount)
                    }

                    
                }else{
                    completion(true,false,true,QZH_CYSQCarModel.proCount)
                }
            }else{
                completion(true,false,true,QZH_CYSQCarModel.proCount)
            }
            
        }
    }
    
    
    /// 编辑购物车
    ///
    /// - Parameter completion: 回调方法
    func editCar(completion:@escaping (_ isSuccess:Bool,_ response:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/shopCart/update", params: ["id":QZH_CYSQCarProModel.ids as AnyObject,"info":"{\"proCount\":\(QZH_CYSQCarProModel.proCounts),\"specOptionId\":\"\(QZH_CYSQCarProModel.specOptionId)\",\"specOptionName\":\"\(QZH_CYSQCarProModel.specOptionNames)\",\"productId\":\(QZH_CYSQCarProModel.productIds)}" as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                print(QZH_CYSQCarProModel.ids)
                if result["status"] as! Int == 200{
                    completion(isSuccess,result["data"] as!String)
                }else{
                    completion(isSuccess,result["data"] as!String)
                }
            }else{
                completion(false,result["data"] as!String)
            }
        }
    }
    
    func delCar(completion:@escaping (_ isSuccess:Bool,_ response:String)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "order/shopCart/delete", params: ["ids":QZH_CYSQCarProModel.idStr as AnyObject]) { (result, isSuccess) in
            if isSuccess{
                if result["status"] as! Int == 200{
                    completion(isSuccess,result["data"] as!String)
                }else{
                    completion(isSuccess,result["data"] as!String)
                }
            }else{
                completion(false,result["data"] as!String)
            }

        }
    }
}
