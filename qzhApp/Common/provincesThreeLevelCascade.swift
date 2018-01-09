//
//  provincesThreeLevelCascade.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/10/26.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

//省市区三级级联
class provincesThreeLevelCascade:UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    //选择器
    var pickerView:UIPickerView!
    
    //所有地址数据集合
    var addressArray=[[String:AnyObject]]()
    
    //选择的省索引
    var provinceIndex=0
    
    //选择的市索引
    var cityIndedx=0
    
    //选择的区县索引
    var areaIndex=0
    
    //pickerView的宽度
    var picViewWidth:CGFloat?
    
    
    //未知地址加载
    func initLoadAddress(labelText: String,width:CGFloat){
        self.width=width
        
        let txtFlag=UILabel(frame:CGRect(x:10,y:0,width:width/3,height:self.height))
        txtFlag.backgroundColor=UIColor.clear
        txtFlag.textAlignment=NSTextAlignment.left
        txtFlag.text = labelText
        self.addSubview(txtFlag)
        
        //设置下边框
        var border=UIView(frame:CGRect(x:0,y:self.bounds.height,width:self.bounds.width,height:1))
        border.backgroundColor=UIColor(red:221/255,green:221/255,blue:221/255,alpha:1)
        self.addSubview(border)
        
        //初始化数据
        let path:String!=Bundle.main.path(forResource: "address", ofType:"plist")
        self.addressArray=NSArray(contentsOfFile:path!) as! Array
        
        //创建选择器  初始化pickerView
        pickerView=UIPickerView.init()     
        pickerView.frame=CGRect(x:width/3-10,y:0,width:width-width/3+10,height:self.height)

        pickerView.dataSource=self
        pickerView.delegate=self
        
        picViewWidth=width-width/3-10
       // pickerView.showsSelectionIndicator = true
        self.addSubview(pickerView)
    }
    func initLoadAddressOnly(){
        //初始化数据
        let path:String!=Bundle.main.path(forResource: "address", ofType:"plist")
        self.addressArray=NSArray(contentsOfFile:path!) as! Array
        
        //创建选择器  初始化pickerView
        pickerView=UIPickerView.init()
        pickerView.frame=CGRect(x:0,y:0,width:self.width,height:self.height)
        pickerView.dataSource=self
        pickerView.delegate=self
        pickerView.layer.borderColor=UIColor.white.cgColor
        
        picViewWidth=width
        pickerView.showsSelectionIndicator = true
        self.addSubview(pickerView)
    }
    
    //有默认地址的加载(存在问题)
    func initAddress(provinces:String,city:String,area:String){
        initLoadAddressOnly()
        var pIndex:Int=0 
        var cIndex:Int=1
        var aIndex:Int=1
         for i in 0..<self.addressArray.count{
            if provinces==addressArray[i]["state"]as? String{
                print("province:\(i)")
                pIndex=pIndex+i
                let province=(addressArray[i]["cities"] as! NSArray)
                for j in 0..<province.count{
                    print("\((province[j]as! [String:AnyObject])["city"])")
                    if (province[j]as! [String:AnyObject])["city"] as?String==city{
                        print("city:\(j)")
                        cIndex=cIndex+j
                        let cities=(province[j]as! [String:AnyObject])["areas"] as! NSArray
                        for index in 0..<cities.count{
                            print("\(cities[index] as!String)")
                            if area==cities[index] as! String{
                                print("area:\(index)")
                                aIndex=aIndex+index
                            }
                        }
                    }
                }
            }
            
        }
        print("\(cIndex)")
        pickerView.selectRow(1, inComponent:1, animated: true)
        pickerView.selectRow(2, inComponent:1, animated: true)
        pickerView.selectRow(3, inComponent:0, animated: true)
       
        /* if component==0{
         return self.addressArray[row]["state"]as? String
         }else if component==1{
         let province=self.addressArray[provinceIndex]
         let city=(province["cities"]as! NSArray)[row]as! [String:AnyObject]
         return city["city"]as? String
         }else{
         let province=self.addressArray[provinceIndex]
         let city=(province["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
         return (city["areas"]as! NSArray)[row]as? String
         }
         */
        //pickerView.selectRow(0, inComponent: , animated: true)
        //pickerView.selectRow(1, inComponent: , animated: true)
        //pickerView.selectRow(2, inComponent: , animated: true)
    }
    
    //设置每列的宽度
    func pickerView(_ pickerView:UIPickerView,widthForComponent component:Int)->CGFloat{
        switch component {
        case 0:
            return picViewWidth!/4
        case 1:
            return picViewWidth!/3
        case 2:
            return picViewWidth!/3
        default:
            break
        }
        return 0.0

    }
    
    //设置行高
    /*func pickerView(_ pickerView:UIPickerView,rowHeightForComponent compent:Int)->CGFloat{
        return 30
    }*/
    
    //设置选择框为3列，继承UIPickerViewDataSource协议
    func numberOfComponents(in pickerView:UIPickerView)->Int{
        return 3
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView:UIPickerView,numberOfRowsInComponent component:Int)->Int{
        if component==0{
            return self.addressArray.count
        }else if component==1{
            let province=self.addressArray[provinceIndex]
            return province["cities"]!.count
        }else{
            let province=self.addressArray[provinceIndex]
            if let city=(province["cities"]as! NSArray)[cityIndedx]as? [String:AnyObject]{
                return city["areas"]!.count
            }else{
                return 0
            }
        } 
        
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==0{
            return self.addressArray[row]["state"]as? String
        }else if component==1{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[row]as! [String:AnyObject]
            return city["city"]as? String
        }else{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
            return (city["areas"]as! NSArray)[row]as? String
        }
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView:UIPickerView,didSelectRow row:Int,inComponent component:Int){
        switch (component) {
        case 0:
            provinceIndex=row;
            cityIndedx=0;
            areaIndex=0;
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 1:
            cityIndedx=row;
            areaIndex=0
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 2:
            areaIndex=row;
        default:
            break;
        }
    }
    
    //设置pickweView字体的大小
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label=UILabel()
        label.backgroundColor=UIColor.white
        label.layer.borderColor=UIColor.white.cgColor
        label.textAlignment=NSTextAlignment.center
        if component==0{
                label.sizeToFit()
                label.font=UIFont.systemFont(ofSize: 12.5)
                label.text=self.addressArray[row]["state"]as? String
        }
        if component==1{
                let province=self.addressArray[provinceIndex]
                let city=(province["cities"]as! NSArray)[row]as! [String:AnyObject]
                label.sizeToFit()
                label.font=UIFont.systemFont(ofSize: 12.5)
                label.text=city["city"]as? String
        }
        if component==2{
                let province=self.addressArray[provinceIndex]
                let city=(province["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
                label.sizeToFit()
                label.font=UIFont.systemFont(ofSize: 12.5)
                label.text=(city["areas"]as! NSArray)[row]as? String
        }
        return  label
    }
    
    
    //触摸按钮时，获得被选中的索引
    @objc func getSelAddress()->[Dictionary<String,AnyObject>]{
        //获取选中的省
        let p=self.addressArray[provinceIndex]
        let province=p["state"]!
        
        //获取选中的城市
        let c=(p["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
        let city=c["city"]as!String
        
        //获取选中的区县
        var area=""
        if(c["areas"]as![String]).count>0{
            area=(c["areas"]as![String])[areaIndex]
        }
        
        //拼接输出消息
        let messages="索引：\(provinceIndex)-\(cityIndedx)-\(areaIndex)\n"+"值：\(province)-\(city)-\(area)"
        let message=[["province":province,"city":city,"area":area],["province":provinceIndex,"city":cityIndedx,"area":areaIndex]]
        return message as [Dictionary<String,AnyObject>]
    }
}

class addressPicker:UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    var picker:UIPickerView!
    var component:Int=1
    //所有地址数据集合
    var addressArray=[[String:AnyObject]]()
    
    //选择的省索引
    var provinceIndex=0
    
    //选择的市索引
    var cityIndedx=0
    
    //选择的区县索引
    var areaIndex=0
    
    //pickerView的宽度
    var picViewWidth:CGFloat?
    func initPicker(width:Int,height:Int,components:Int){
        picker=UIPickerView.init()
        picker.dataSource=self
        picker.delegate=self
        picker.frame=CGRect(x:width/3-10,y:0,width:width-width/3+10,height:height)
        picker.layer.borderColor=UIColor.white.cgColor
        component=components
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return component
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 9
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    //触摸按钮时，获得被选中的索引
    @objc func getSelAddress()->[Dictionary<String,AnyObject>]{
        //获取选中的省
        let p=self.addressArray[provinceIndex]
        let province=p["state"]!
        
        //获取选中的城市
        let c=(p["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
        let city=c["city"]as!String
        
        //获取选中的区县
        var area=""
        if(c["areas"]as![String]).count>0{
            area=(c["areas"]as![String])[areaIndex]
        }
        
        //拼接输出消息
        let messages="索引：\(provinceIndex)-\(cityIndedx)-\(areaIndex)\n"+"值：\(province)-\(city)-\(area)"
        let message=[["province":province,"city":city,"area":area],["province":provinceIndex,"city":cityIndedx,"area":areaIndex]]
        return message as [Dictionary<String,AnyObject>]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中的列和行的索引
        print("component:\(component)")
        print("row\(row)")
    }
}
