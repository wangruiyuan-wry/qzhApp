//
//  QZHOrderListFooter.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHOrderListFooter: UIView {
    
    // 商品价格 数量
    var one:QZHUIView = QZHUIView()
    
    // 订单操作
    var two:QZHUIView = QZHUIView()
    
    // 删除订单
    var delBtn:QZHUILabelView = QZHUILabelView()
    
    // 追加评论
    var addCommentBtn:QZHUILabelView = QZHUILabelView()
    
    // 确认收货
    var confirmGoodsBtn:QZHUILabelView = QZHUILabelView()
    
    // 申请售后
    var applyAfterSaleBtn:QZHUILabelView = QZHUILabelView()
    
    // 取消订单
    var canelOrderBtn:QZHUILabelView = QZHUILabelView()
    
    // 去付款
    var payOrderBtn:QZHUILabelView = QZHUILabelView()
    
    // 提醒发货
    var remindDeliveryBtn:QZHUILabelView = QZHUILabelView()
    
    // 申请退款
    var applyRefundBtn:QZHUILabelView = QZHUILabelView()
    
    // 评价
    var commentBtn:QZHUILabelView = QZHUILabelView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        one.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        self.addSubview(one)
        
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(20*PX, y: 80*PX, width: 730*PX, height: 1*PX, color: myColor().grayF0())
        self.addSubview(line)
        
        two.setupViews(x: 0, y: 81*PX, width: SCREEN_WIDTH, height: 80*PX, bgColor: UIColor.white)
        self.addSubview(two)
        
        // 删除订单
        delBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "删除订单")
        delBtn.layer.borderColor = myColor().grayD().cgColor
        delBtn.layer.borderWidth = 1*PX
        delBtn.isHidden = true
        two.addSubview(delBtn)
        
        // 追加评论
        addCommentBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "追加评价")
        addCommentBtn.layer.borderColor = myColor().grayD().cgColor
        addCommentBtn.layer.borderWidth = 1*PX
        addCommentBtn.isHidden = true
        two.addSubview(addCommentBtn)
        
        // 确认收货
        confirmGoodsBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "确认收货")
        confirmGoodsBtn.layer.borderColor = myColor().grayD().cgColor
        confirmGoodsBtn.layer.borderWidth = 1*PX
        confirmGoodsBtn.isHidden = true
        two.addSubview(confirmGoodsBtn)
        
        // 申请售后
        applyAfterSaleBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "申请售后")
        applyAfterSaleBtn.layer.borderColor = myColor().grayD().cgColor
        applyAfterSaleBtn.layer.borderWidth = 1*PX
        applyAfterSaleBtn.isHidden = true
        two.addSubview(applyAfterSaleBtn)
        
        // 取消订单
        canelOrderBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "取消订单")
        canelOrderBtn.layer.borderColor = myColor().grayD().cgColor
        canelOrderBtn.layer.borderWidth = 1*PX
        canelOrderBtn.isHidden = true
        two.addSubview(canelOrderBtn)
        
        // 去付款
        payOrderBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "去付款")
        payOrderBtn.layer.borderColor = myColor().grayD().cgColor
        payOrderBtn.layer.borderWidth = 1*PX
        payOrderBtn.isHidden = true
        two.addSubview(payOrderBtn)
        
        // 提醒发货
        remindDeliveryBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "提醒发货")
        remindDeliveryBtn.layer.borderColor = myColor().grayD().cgColor
        remindDeliveryBtn.layer.borderWidth = 1*PX
        remindDeliveryBtn.isHidden = true
        two.addSubview(remindDeliveryBtn)
        
        // 申请退款
        applyRefundBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "申请退款")
        applyRefundBtn.layer.borderColor = myColor().grayD().cgColor
        applyRefundBtn.layer.borderWidth = 1*PX
        applyRefundBtn.isHidden = true
        two.addSubview(applyRefundBtn)
        
        // 评价
        commentBtn.setLabelView(590*PX, 10*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 26, "评价")
        commentBtn.layer.borderColor = myColor().grayD().cgColor
        commentBtn.layer.borderWidth = 1*PX
        commentBtn.isHidden = true
        two.addSubview(commentBtn)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFooter(_ count:Double,_ price:Double){
        let priceView:QZHUILabelView = QZHUILabelView()
        one.addSubview(priceView)
        let priceWidth = priceView.autoLabelWidth("\(price.roundTo(places: 2))", font: 40, height: 50*PX)
        priceView.setLabelView(735*PX - priceWidth - 50, 18*PX, priceWidth + 50 , 50*PX, NSTextAlignment.right, UIColor.white, myColor().redFf4300(), 34, "\(price.roundTo(places: 2))")
        priceView.setRealWages(priceView.text!, big: 34, small: 28, fg: ".")
        
        let priceIcon:QZHUILabelView = QZHUILabelView()
        priceIcon.setLabelView(725*PX - priceWidth, 25*PX, 17*PX, 40*PX, NSTextAlignment.right, UIColor.white, myColor().redFf4300(), 28, "¥")
        one.addSubview(priceIcon)
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(650*PX - priceWidth, 24*PX, 77*PX, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "小计：")
        one.addSubview(title)
        
        let countView:QZHUILabelView = QZHUILabelView()
        let countViewWidth = countView.autoLabelWidth("共\(count)件商品", font: 24, height: 33*PX)
        countView.setLabelView(630*PX - priceWidth - countViewWidth, 24*PX, countViewWidth, 33*PX, NSTextAlignment.left, UIColor.white, myColor().gray3(), 24, "共\(count)件商品")
        one.addSubview(countView)
    }
}
