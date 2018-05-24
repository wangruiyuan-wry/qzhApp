//
//  QZHPayViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/8.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHPayViewController: QZHBaseViewController {
    // 结算列表视图模型懒加载
    lazy var listStatus = QZH_CYSQCarSettlementListViewModel()
    
    // 支付方式
    var  payMoneyType:QZHUIView = QZHUIView()
    var totalMoney:QZHUILabelView = QZHUILabelView()
    var payMoneyTag:Int = 1
    
    var bgView:QZHUIView = QZHUIView()
    
    override func loadData() {
        
    }
}

// MARK: - 设置页面背景
extension QZHPayViewController{
    override func setupUI() {
        super.setupUI()
        tabbelView?.isHidden = true
        navigationBar.isHidden = true

        
        
        self.view.backgroundColor = UIColor.clear
        //self.view.alpha = 0.5
        setupPayMoney()
    }
    // 设置支付方式
    func setupPayMoney(){
        bgView.blackBackground(y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(bgView)
        bgView.isHidden = false
        
        payMoneyType.setupViews(x: 0, y: 550*PX, width: SCREEN_WIDTH, height: 784*PX, bgColor: UIColor.white)
        payMoneyType.alpha = 1
        
        self.view.addSubview(payMoneyType)
        //payMoneyType.isHidden = true
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(300*PX, 20*PX, 150*PX, 42*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 30, "确认付款")
        payMoneyType.addSubview(title)
        
        let closeBtn:UIImageView = UIImageView(frame:CGRect(x:684*PX,y:24*PX,width:42*PX,height:42*PX))
        closeBtn.image = UIImage(named:"proDetailCloseIcon")
        closeBtn.addOnClickLister(target: self, action: #selector(self.orderDetail))
        payMoneyType.addSubview(closeBtn)
        
        totalMoney.setLabelView(260*PX, 92*PX, 230*PX, 84*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 60, "")
        payMoneyType.addSubview(totalMoney)
        
        let line1:QZHUILabelView = QZHUILabelView()
        line1.dividers(20*PX, y: 226*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        payMoneyType.addSubview(line1)
        
        let payBtn:UIButton = UIButton(frame: CGRect(x:20*PX,y:664*PX,width:710*PX,height:100*PX))
        payBtn.setTitle("立即付款", for: .normal)
        payBtn.layer.cornerRadius = 5*PX
        payBtn.backgroundColor = myColor().blue007aff()
        payBtn.tintColor = UIColor.white
        payBtn.titleLabel?.font = UIFont.systemFont(ofSize: 36*PX)
        payBtn.addOnClickLister(target: self, action: #selector(self.payNow(_:)))
        payMoneyType.addSubview(payBtn)
        
        self.setupPayList(227*PX,"zfbIcon","支付宝支付",id: 1)
        self.setupPayList(328*PX,"wxIcon","微信支付",id: 2)
        self.setupPayList(429*PX,"ylIcon","银联支付",id: 3)
        
    }
    
    // 设置支付方式list
    func setupPayList(_ y:CGFloat,_ img:String,_ titleStr:String,id:Int){
        let listView:QZHUIView = QZHUIView()
        payMoneyType.addSubview(listView)
        listView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: 101*PX, bgColor: UIColor.white)
        listView.restorationIdentifier = "listBtn"
        listView.addOnClickLister(target: self, action: #selector(self.checkPay(_:)))
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:24*PX,y:29*PX,width:43*PX,height:42*PX))
        icon.image = UIImage(named:img)
        listView.addSubview(icon)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(85*PX, 29*PX, 160*PX, 42*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 30, titleStr)
        listView.addSubview(title)
        
        let img:UIImageView = UIImageView(frame:CGRect(x:695*PX,y:33*PX,width:35*PX,height:35*PX))
        img.image = UIImage(named:"CarSel")
        img.restorationIdentifier = "img"
        listView.addSubview(img)
        listView.tag = id
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 100*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        listView.addSubview(line)
    }
    
    // 立即付款
    func payNow(_ sender:UITapGestureRecognizer){
        if self.payMoneyTag == 1{
            self.listStatus.paynow(completion: { (isSuccess,urlString) in
                if let url = URL(string: urlString) {
                    print(url)
                    //根据iOS系统版本，分别处理
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                if QZHOrderListModel.from == 11{
                    let nav = QZHOrderViewController()
                    self.present(nav, animated: true, completion: nil)
                }else if QZHOrderListModel.from == 0{
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }/*else if self.payMoneyTag == 2{
            self.listStatus.paynowWX(completion: { (isSuccess,result) in
                let request:PayReq = PayReq()
                request.partnerId = result["cusid"] as! String
                request.openID = result["appid"] as! String
                request.prepayId = result["trxid"] as! String // 预支付交易会话id
                request.package = "Sign= WXPay" // 扩展字段
                request.nonceStr = "wwwwwwwwwww"// 随机字符串
                request.timeStamp = 1412000000 // 时间戳
                request.sign = result["sign"] as! String // 签名
                WXApi.send(request)
            })
        }else{
            self.listStatus.paynowWY(completion: { (isSuccess,payData1) in
                var payData:String = "{\"inputCharset\":\"\(payData1["inputCharset"]!)\",\"receiveUrl\":\"\(payData1["receiveUrl"]!)\",\"version\":\"\(payData1["version"]!)\",\"signType\":\"\(payData1["signType"]!)\",\"merchantId\":\"\(payData1["merchantId"]!)\",\"orderNo\":\"\(payData1["orderNo"]!)\",\"orderAmount\":\"\(payData1["orderAmount"]!)\",\"orderCurrency\":\"\(payData1["orderCurrency"]!)\",\"orderDatetime\":\"\(payData1["orderDatetime"]!)\",\"productName\":\"\(payData1["productName"]!)\",\"ext1\":\"\(payData1["ext1"]!)\",\"payType\":\"\(payData1["payType"]!)\",\"signMsg\":\"\(payData1["signMsg"]!)\"}"
                APay.start(payData, viewController: self, delegate: self, mode: "00")
                print("payData:\(payData)")
                //APay.startAuth(payData, viewController: self, delegate: self, mode: "01")
            })
        }*/
    }
   // 网银支付返回结果
    func aPayResult(_ result: String!) {
        print("result:\(result)")
        
        //let nav = QZHOrderViewController()
        //present(nav, animated: true, completion: nil)
    }

    
    // 选择支付方式
    func checkPay(_ sender:UITapGestureRecognizer){
        print(" 支付!!!")
        let this = sender.view
        
        let children = payMoneyType.subviews
        for child in children{
            if child.restorationIdentifier == "listBtn"{
                let views = child.subviews
                for v in views{
                    if v.restorationIdentifier == "img"{
                        (v as! UIImageView).image = UIImage(named:"CarSel")
                    }
                }
            }
        }
        
        let views = this?.subviews
        for v in views!{
            if v.restorationIdentifier == "img"{
                (v as! UIImageView).image = UIImage(named:"CarSel1")
            }
        }
        
        self.payMoneyTag = (this?.tag)!
    }
    
    // 订单详情
    func orderDetail(){
        if  QZHOrderDetailModel.fromPage == "listPay"{
            dismiss(animated: true, completion: nil)
        }else{
            QZHOrderListModel.from = 11
            let nav = QZHOrderViewController()
            present(nav, animated: true, completion: nil)
        }
    }
}
