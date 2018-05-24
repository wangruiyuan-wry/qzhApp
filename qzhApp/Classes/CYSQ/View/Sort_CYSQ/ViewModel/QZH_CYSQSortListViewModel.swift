//
//  QZH_CYSQSortListViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZH_CYSQSortListViewModel: NSObject {
    
    //  一级分类列表视图模型懒加载
    lazy var fristSortList = [QZH_CYSQSortViewModel]()
    
    // 二级分类列表视图模型懒加载
    lazy var secondSortList = [QZH_CYSQSort_SecondViewModel]()
    
    /// 加载一级分类列表
    ///
    /// - Parameter completion: 完成回调
    func getFristSortList(completion:@escaping (_ isSuccess:Bool,_ result:[QZH_CYSQSortViewModel])->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "market/MarketData/getMarketLable", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, self.fristSortList)
            }else{
                if result["status"]as! Int != 200{
                    completion(false, self.fristSortList)
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    var listArray1 = [QZH_CYSQSortViewModel]()
                    for dict in _data ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZH_CYSQSortModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray1.append(QZH_CYSQSortViewModel(model:model))
                    }
                    self.fristSortList = listArray1
                    
                    //完成回调
                    completion(isSuccess, self.fristSortList)
                }
            }
        }
    }
    
    /// 加载二级分类列表
    ///
    /// - Parameter completion: 完成回调
    func getSecondSortList(completion:@escaping (_ isSuccess:Bool,_ result:[QZH_CYSQSort_SecondViewModel])->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "market/MarketData/getMarketClass", params: ["id":QZH_CYSQSort_SecondModel.parentId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, [])
            }else{
                if result["status"]as! Int != 200{
                    completion(false, [])
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    var listArray1 = [QZH_CYSQSort_SecondViewModel]()
                    for dict in _data ?? []{
                        //对字典进行处理
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZH_CYSQSort_SecondModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray1.append(QZH_CYSQSort_SecondViewModel(model:model))
                    }
                    self.secondSortList = listArray1
                    
                    //完成回调
                    completion(isSuccess, self.secondSortList)
                }
            }
        }
    }
}
