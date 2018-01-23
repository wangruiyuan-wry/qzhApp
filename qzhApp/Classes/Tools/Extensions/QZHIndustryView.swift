//
//  QZHIndustryView.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/16.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit


//行业分类 UI
class QZHIndustryView: QZHUIView {
    //列表视图
    var listMode = QZHEnterprisePortalViewModel()
    
    func initFrame(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,bgColor:UIColor,action:Selector,ownself:UIViewController){
        self.setupView(x: Int(x), y: Int(y), width: Int(width), height: Int(height), bgColor: myColor().grayF0())
        self.addSubview(setupFirst(height:height,action:action, ownself: ownself))
    }
    
    //一级分类
    func setupFirst(height:CGFloat,action:Selector,ownself:UIViewController)->QZHUIScrollView{
        let scroller:QZHUIScrollView = QZHUIScrollView()
        scroller.setupScrollerView(x: 0, y: 0, width: 250*PX, height: height, background: myColor().grayF0())
        scroller.contentSize = CGSize(width:250*PX,height:height)
        scroller.tag = 1
        
        let fbtn = self.setupListView(y:0, width: 250*PX, action: action, title: "不限", res: "", bgColor: UIColor.white, ownself: ownself)
        fbtn.setTitleColor(myColor().blue007aff(), for: .normal)
        fbtn.tag = 1
        scroller.addSubview(fbtn)
        
        listMode.loadFirstIndustry { (isSuccess) in
            if isSuccess{
                for i in 0..<self.listMode.fristIndustryList.count{
                    scroller.addSubview(self.setupListView(y: 62*PX+62*PX*CGFloat(i), width: 250*PX, action: action, title: self.listMode.fristIndustryList[i].status.value, res: self.listMode.fristIndustryList[i].status.key, bgColor: UIColor.white, ownself: ownself))
                    scroller.contentSize.height = (60+62*CGFloat(i))*PX
                }
            }
        }
        return scroller
    }
    
    //二级分类列表
    func setupSecond(height:CGFloat,action:Selector,ownself:UIViewController){
        let scroller:QZHUIScrollView = QZHUIScrollView()
        scroller.setupScrollerView(x: 250*PX, y: 0, width: 499*PX, height: height, background: myColor().grayF0())
        scroller.contentSize = CGSize(width:499*PX,height:height)
        scroller.tag = 2
        let fbtn = self.setupListView(y:0, width: 499*PX, action: action, title: "全部", res: "", bgColor: myColor().grayF6(), ownself: ownself)
        fbtn.setTitleColor(myColor().blue007aff(), for: .normal)
        fbtn.tag = 1
        scroller.addSubview(fbtn)
        
        listMode.loadSecondIndustry{ (isSuccess) in
            if isSuccess{
                for i in 0..<self.listMode.secondIndustryList.count{
                    scroller.addSubview(self.setupListView(y: 62*PX+62*PX*CGFloat(i), width: 499*PX, action: action, title: self.listMode.secondIndustryList[i].status.value, res: self.listMode.secondIndustryList[i].status.key, bgColor: myColor().grayF6(), ownself: ownself))
                    scroller.contentSize.height = (60+62*CGFloat(i))*PX
                }
            }
        }
        self.addSubview(scroller)
    }

    
    //分类项
    func setupListView(y:CGFloat,width:CGFloat,action:Selector,title:String,res:String,bgColor:UIColor,ownself:UIViewController)->QZHUIButton{
        let btn:QZHUIButton = QZHUIButton()
        btn.frame = CGRect(x:0,y:y,width:width,height:60*PX)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24*PX)
        btn.setTitleColor(myColor().gray3(), for: .normal)
        btn.restorationIdentifier = res
        btn.addTarget(ownself, action: action, for: .touchUpInside)
        btn.tag = 0
        return btn
    }
    
    //设置按钮样式为默认样式
    func setupDefualtBtn(_ sender:QZHUIButton){
        let btnArray:[UIView] = ((sender.superview)?.subviews)!
        for i in 0..<btnArray.count{
            if btnArray[i].superclass == UIButton.self{
                (btnArray[i] as! UIButton).setTitleColor(myColor().gray3(), for: .normal)
                (btnArray[i] as! UIButton).tag = 0
            }
        }
    }
    
    //移除指定列
    func removeListOfTag(tag:Int){
        self.viewWithTag(tag)?.removeFromSuperview()
    }
}
