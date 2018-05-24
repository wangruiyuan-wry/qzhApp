//
//  QZHSearchProListViewModel.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/18.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import Foundation

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 1

class QZHSearchProListViewModel:NSObject{
    // 分类产品列表数据视图模型懒加载
    lazy var proListStatus = [QZHCYSQ_SortProViewModel]()
    
    // 品牌 规格
    lazy var specNameList = [QZHBrandViewModel]()
    
    // 品牌内容 规格选项
    lazy var specOptionList:[[QZHSpecOptionViewModel]] = []

    func loadSpec(completion:@escaping (_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productSpec/listBandAndSpecOption", params: ["categoryId":QZHBrandModel.categoryId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(false)
            }else{
                if result["status"]as! Int != 200{
                    completion(false)
                }else{
                    let _data:[[String:AnyObject]] = result["data"] as! [[String : AnyObject]]
                    var spec = [QZHBrandViewModel]()
                    var specOptionArray:[[QZHSpecOptionViewModel]] = []
                    
                    for dict in _data{
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHBrandModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        spec.append(QZHBrandViewModel(model:model))
                        
                        let options:[[String:AnyObject]] = dict["options"] as! [[String : AnyObject]]
                        var specOption = [QZHSpecOptionViewModel]()
                        
                        for dic in options{
                            let newdic = PublicFunction().setNULLInDIC(dic)
                            guard let model1 = QZHSpecOptionModel.yy_model(with:newdic) else{
                                continue
                            }
                            //b）将model添加到数组
                            specOption.append(QZHSpecOptionViewModel(model:model1))
                        }
                        
                        specOptionArray.append(specOption)
                    }
                    
                    self.specNameList = spec
                    self.specOptionList = specOptionArray
                    completion(isSuccess)
                }
            }
        }
    }
    
    /// 上拉刷新错误次数
    var pullupErrorTimes = 0
    
    /// 加载数据模型列表
    ///
    /// - Parameters:
    ///   - pullUp: 上拉加载
    ///   - completion: 回调方法
    func loadList(pullUp:Bool,completion:@escaping (_ isSuccess:Bool,_ shouldRefresh:Bool)->()){
        
        //判断是否是上拉刷新，同时检查刷新错误
        if pullUp && pullupErrorTimes > maxPullupTryTimes{
            completion(true,false)
            
            return
        }
        
        if pullUp{
            QZHCYSQSearchProListParamModel.pageNo = QZHCYSQSearchProListParamModel.pageNo+1
        }else{
            QZHCYSQSearchProListParamModel.pageNo = 1
        }
        
        // 网络请求
        QZHNetworkManager.shared.statusList(method: .POST, url: "query/product", params: ["pageNo":QZHCYSQSearchProListParamModel.pageNo as AnyObject,"pageSize":QZHCYSQSearchProListParamModel.pageSize as AnyObject,"categoryId":QZHCYSQSearchProListParamModel.categoryId as AnyObject,"q":QZHCYSQSearchProListParamModel.q as AnyObject,"order":QZHCYSQSearchProListParamModel.order as AnyObject,"specOptionName":QZHCYSQSearchProListParamModel.specOptionName as AnyObject,"customCategoryId":QZHCYSQSearchProListParamModel.customCategoryId as AnyObject,"brand":QZHCYSQSearchProListParamModel.brand as AnyObject,"price":QZHCYSQSearchProListParamModel.price as AnyObject,"category_id_lv1":QZHCYSQSearchProListParamModel.category_id_lv1 as AnyObject]) { (result, isSuccess) in
            print(result)
            if !isSuccess{
                completion(false,false)
            }else{
                if result["status"]as! Int != 200{
                    completion(false,false)
                }else{
                    
                    let _data:[String:AnyObject] = result["data"] as! [String : AnyObject]
                    let _list:[[String:AnyObject]] = _data["list"]as! [[String : AnyObject]]
                    var listArray =  [QZHCYSQ_SortProViewModel]()
                    for dict in _list{
                        let newDict = PublicFunction().setNULLInDIC(dict)
                        //a）创建企业模型
                        guard let model = QZHStoreProModel.yy_model(with:newDict) else{
                            continue
                        }
                        //b）将model添加到数组
                        listArray.append(QZHCYSQ_SortProViewModel(model:model))
                    }
                    
                    //2. FIXME 拼接数据
                    if pullUp{
                        
                        self.proListStatus += listArray
                        
                    }else{
                        
                        self.proListStatus = listArray
                        
                        
                    }
                    //3.判断上拉刷新的数据量
                    if pullUp && listArray.count == 0 {
                        
                        self.pullupErrorTimes += 1
                        
                        completion(false, false)
                    }else{
                        
                        //完成回调
                        completion(isSuccess,true)
                    }
                    
                    
                   // completion(isSuccess,true)
                }
            }
        }
        
    }
}
