//
//  QZHArea.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/15.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHArea: QZHUIView {

    var addressJSON:[Dictionary<String,AnyObject>] = []
    
    @objc func initFrame(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,action:Selector,ownself:UIViewController){
        self.frame = CGRect(x:x,y:y,width:width,height:height)
        self.isHidden = true
        self.backgroundColor = myColor().grayF0()
        //获取本地省市区 JSON 文件内容
        let path = Bundle.main.path(forResource: "area", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let json:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            addressJSON = (json as! Dictionary<String, AnyObject>)["root"] as! [Dictionary<String, AnyObject>]
        }catch let error as Error!{
            print("读取到本地数据出错:\(error)")
        }
        setupProvice(action, ownself: ownself)
    }
    
    //设置省列表
    func setupProvice(_ action:Selector,ownself:UIViewController){
        let scrollerView :QZHUIScrollView = QZHUIScrollView()
        scrollerView.contentSize = CGSize(width:scrollerView.width,height:0)
        scrollerView.setupScrollerView(x: 0, y: 0, width: 250*PX, height: self.height, background: UIColor.clear)
        
        let firstBtn = setupButton(0, 0, "不限", 0, bgcolor:UIColor.white, action: action, ownself: ownself)
        firstBtn.setTitleColor(myColor().blue007aff(), for: .normal)
        firstBtn.restorationIdentifier = "sel"
        scrollerView.addSubview(firstBtn)
        
        for i in 0..<addressJSON.count{
            scrollerView.addSubview(setupButton(0, 61*PX+61*PX*CGFloat(i), addressJSON[i]["province"] as! String, addressJSON[i]["provinceCode"] as! Int64, bgcolor:UIColor.white, action: action, ownself: ownself))
        }
        scrollerView.contentSize = CGSize(width:scrollerView.width,height:61*PX*CGFloat(addressJSON.count+1))
        scrollerView.restorationIdentifier = "province"
        scrollerView.tag = 0
        self.addSubview(scrollerView)
    }
    
    //设置城市列表
    func setupCity(_ action:Selector,parentCode:Int,ownself:UIViewController){
        let scrollerView :QZHUIScrollView = QZHUIScrollView()
        scrollerView.contentSize = CGSize(width:scrollerView.width,height:0)
        scrollerView.setupScrollerView(x: 250*PX, y: 0, width: 250*PX, height: self.height, background: UIColor.clear)
        let firstBtn = setupButton(0, 0, "全部", 0, bgcolor:myColor().grayF6(), action: action, ownself: ownself)
        firstBtn.setTitleColor(myColor().blue007aff(), for: .normal)
        firstBtn.restorationIdentifier = "sel"
        scrollerView.addSubview(firstBtn)
        
        for i in 0..<getCityData(code: parentCode).count{
            scrollerView.addSubview(setupButton(0, 61*PX+61*PX*CGFloat(i), getCityData(code: parentCode)[i]["city"] as! String, getCityData(code: parentCode)[i]["cityCode"] as! Int64, bgcolor:myColor().grayF6(), action: action, ownself: ownself))
        }
        scrollerView.contentSize = CGSize(width:scrollerView.width,height:61*PX*CGFloat(addressJSON.count+1))
        scrollerView.restorationIdentifier = "city"
        scrollerView.tag = 1
        self.addSubview(scrollerView)
                print(scrollerView.subviews)
    }
    
    //设置区列表
    func setupCounty(_ action:Selector,provinceCode:Int,cityCode:Int,ownself:UIViewController){
        let scrollerView :QZHUIScrollView = QZHUIScrollView()
        scrollerView.contentSize = CGSize(width:scrollerView.width,height:0)
        scrollerView.setupScrollerView(x: 500*PX, y: 0, width: 250*PX, height: self.height, background: UIColor.clear)
        
        let firstBtn = setupButton(0, 0, "全部", 0, bgcolor:myColor().grayF6(), action: action, ownself: ownself)
        firstBtn.setTitleColor(myColor().blue007aff(), for: .normal)
        firstBtn.restorationIdentifier = "sel"
        scrollerView.addSubview(firstBtn)
        
        for i in 0..<getAreaData(provinceCode: provinceCode, cityCode: cityCode).count{
            scrollerView.addSubview(setupButton(0, 61*PX+61*PX*CGFloat(i), getAreaData(provinceCode: provinceCode, cityCode: cityCode)[i]["county"] as! String, getAreaData(provinceCode: provinceCode, cityCode: cityCode)[i]["countyCode"] as! Int64, bgcolor:myColor().grayE6(), action: action, ownself: ownself))
        }

        scrollerView.contentSize = CGSize(width:scrollerView.width,height:61*PX*CGFloat(addressJSON.count+1))
        scrollerView.restorationIdentifier = "area"
        scrollerView.tag = 2
        print(scrollerView.subviews)
        self.addSubview(scrollerView)
    }
    
    
    func setupButton(_ x:CGFloat,_ y:CGFloat,_ title:String,_ code:Int64,bgcolor:UIColor,action:Selector,ownself:UIViewController)->QZHUIButton{
        let btn:QZHUIButton = QZHUIButton()
        btn.frame = CGRect(x:x,y:y,width:250*PX,height:60*PX)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgcolor
        btn.tag = Int(code)
        btn.restorationIdentifier = "unSel"
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24*PX)
        
        btn.setTitleColor(myColor().gray3(), for: .normal)
        btn.addTarget(ownself, action: action, for:.touchUpInside)
        return btn
    }
    
    //根据省获取城市列表
    func getCityData(code:Int)->[Dictionary<String,AnyObject>]{
        var cities:[Dictionary<String,AnyObject>] = []
        for i in 0..<addressJSON.count{
            if addressJSON[i]["provinceCode"] as! Int == code{
                cities = addressJSON[i]["cities"] as! [Dictionary<String, AnyObject>]
            }
        }
        return cities
    }
    
    //根据省市获取
    func getAreaData(provinceCode:Int,cityCode:Int)->[Dictionary<String,AnyObject>]{
        var counties:[Dictionary<String,AnyObject>] = []
        
        let cities:[Dictionary<String,AnyObject>] = getCityData(code: provinceCode)
        
        for i in 0..<cities.count{
            if cities[i]["cityCode"]  as! Int == cityCode{
                counties = cities[i]["counties"] as! [Dictionary<String, AnyObject>]
            }
        }
        
        return counties
    }
    
    //设置按钮样式为默认样式
    func setupDefualtBtn(_ sender:QZHUIButton){
        let btnArray:[UIView] = ((sender.superview)?.subviews)!
        for i in 0..<btnArray.count{
            if btnArray[i].superclass == UIButton.self{
                (btnArray[i] as! UIButton).setTitleColor(myColor().gray3(), for: .normal)
                (btnArray[i] as! UIButton).restorationIdentifier = "unSel"
            }
        }
    }
    
    //移除指定列
    func removeListOfTag(tag:Int){
        self.viewWithTag(tag)?.removeFromSuperview()
    }
}

