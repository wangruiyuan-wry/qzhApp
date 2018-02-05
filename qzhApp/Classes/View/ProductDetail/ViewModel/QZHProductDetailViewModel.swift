//
//  QZHProductDetailViewModel.swift
//  qzhApp
//
//  Created by sbxmac on 2018/2/2.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation

class QZHProductDetailViewModel:NSObject{
    
    // 货品视图模型
    lazy var goodsStatus = [QZHProductDetail_GoodsViewModel]()
    
    // 产品图片视图模型
    lazy var picStatus = [QZHProductDetail_PROPicViewModel]()
    
    // 产品价格视图模型
    lazy var proPrice = [QZHProductDetail_PROPrice2StockByIdViewModel]()
    
    // 获取产品详情
    func getProductGoodsDetail(completion:@escaping (_ result:[QZHProductDetail_GoodsViewModel],_ pic:[QZHProductDetail_PROPicViewModel],_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/productGoods/productGoodsDetail", params: ["goodsId":QZHProductDetailModel.goodsId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(self.goodsStatus,self.picStatus, false)
            }else{
                if result["status"] as!Int == 200{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    var listArray = [QZHProductDetail_GoodsViewModel]()
                    
                    let newDict = PublicFunction().setNULLInDIC(_data)
                    //a）创建企业模型
                    let model = QZHProductDetailModel.yy_model(with:newDict)
                    
                    //b）将model添加到数组
                    listArray.append(QZHProductDetail_GoodsViewModel(model:model!))
                    //2. FIXME 拼接数据
                    self.goodsStatus = listArray
                    
                    // 图片
                    if _data["pic"] is NSNull{
                    
                    }else{
                        let _pic:Dictionary<String,AnyObject> = _data["pic"] as! Dictionary<String, AnyObject>
                        var picList = [QZHProductDetail_PROPicViewModel]()
                        let newPic = PublicFunction().setNULLInDIC(_pic)
                    
                        let model1 = QZHProductDetail_PROPicModel.yy_model(with:_pic)
                    
                        picList.append(QZHProductDetail_PROPicViewModel(model: model1!))
                    
                        self.picStatus = picList
                    }
                    
                    completion(self.goodsStatus,self.picStatus,isSuccess)

                }else{
                    completion(self.goodsStatus,self.picStatus,false)
                }
            }
        }
    }
    
    // 获取产品价格
    func getProductPrice(completion:@escaping (_ result:[QZHProductDetail_PROPrice2StockByIdViewModel],_ isSuccess:Bool)->()){
        QZHNetworkManager.shared.statusList(method: .POST, url: "standard/product/price2StockById", params: ["productId":QZHProductDetailModel.productId as AnyObject]) { (result, isSuccess) in
            if !isSuccess{
                completion(self.proPrice, false)
            }else{
                if result["status"]as!Int == 200{
                    let _data:Dictionary<String,AnyObject> = result["data"] as! Dictionary<String, AnyObject>
                    var listArray = [QZHProductDetail_PROPrice2StockByIdViewModel]()
                    
                    let newDict = PublicFunction().setNULLInDIC(_data)
                    //a）创建企业模型
                    let model = QZHProductDetail_PROPrice2StockByIdModel.yy_model(with:newDict)
                    
                    //b）将model添加到数组
                    listArray.append(QZHProductDetail_PROPrice2StockByIdViewModel(model:model!))
                    //2. FIXME 拼接数据
                    self.proPrice = listArray
                    
                    completion(self.proPrice, isSuccess)
                    
                }else{
                    completion(self.proPrice, false)
                }
            }
        }
    }
}
