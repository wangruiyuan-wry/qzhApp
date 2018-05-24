//
//  QZHMyFootPrintProListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHMyFootPrintProListViewModel:NSObject{

    // 我的足迹列表视图懒加载
    lazy var footStatus = [QZHMyFootPrintProViewModel]()
    
    
    /// 加载足迹数据
    ///
    /// - Parameter completion: 回调方法
    func loadFootPrint(completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "personalCenter/myFootprint/list", params: [:]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, false)
            }else{
                if result["status"] as! Int != 200{
                    completion(false, false)
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    var listArray = [QZHMyFootPrintProViewModel]()
                    
                    for dic in _data{
                        let newDic = PublicFunction().setNULLInDIC(dic)
                        //a）创建企业模型
                        let model = QZHMyFootPrintProModel.yy_model(with:newDic)
                        
                        //b）将model添加到数组
                        listArray.append(QZHMyFootPrintProViewModel(model:model!))
                    }
                    
                    self.footStatus = listArray
                    completion(isSuccess,true)
                }
            }
        }
    }
    
    /// 删除足迹
    ///
    /// - Parameter completion: 回调方法
    func delFootPrint(completion:@escaping (_ isSuccess:Bool,_ msg:String)->()){
        QZHNetworkManager.shared.statusList(method: .GET, url: "personalCenter/myFootprint/delete", params: ["ids":QZHMyFootPrintProModel.ids as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false, "删除失败，\(result["data"]!)")
            }else{
                if result["status"] as! Int == 200{
                    completion(true, "删除成功")
                }else{
                    completion(false, "删除失败，\(result["data"]!)")
                }
            }
        }

    }
}
