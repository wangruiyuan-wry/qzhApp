//
//  AreaPicker.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/22.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
class AreaPicker:UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    //选择器
    var pickerView:UIPickerView!
    
    //所有地址数据集合
    var addressArray:[[String:AnyObject]] = []
    
    //选择的省索引
    var provinceIndex=0
    
    //选择的市索引
    var cityIndedx=0
    
    //选择的区县索引
    var areaIndex=0
    
    //pickerView的宽度
    var picViewWidth:CGFloat?
    
    func initLoadAddressOnly(){
        //初始化数据
        //初始化数据
        let path = Bundle.main.path(forResource: "area", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let json:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            addressArray = (json as! [String:AnyObject])["root"] as! [[String:AnyObject]]
        }catch let error as Error!{
            print("读取到本地数据出错:\(error)")
        }
        
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
    
    //设置每列的宽度
    func pickerView(_ pickerView:UIPickerView,widthForComponent component:Int)->CGFloat{
        switch component {
        case 0:
            return picViewWidth!/3
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
        if component == 0{
            return self.addressArray.count
        }else if component==1{
            let province=self.addressArray[provinceIndex]
            return province["cities"]!.count
        }else{
            let province=self.addressArray[provinceIndex]
            if let city=(province["cities"]as! NSArray)[cityIndedx]as? [String:AnyObject]{
                return city["counties"]!.count
            }else{
                return 0
            }
        }
        
    }
    
    
    //设置选择框各选项的内容，继承于UIPickerViewDataSource协议
    /*func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
             return self.addressArray[row]["province"]as? String
        }else if component==1{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[row]as! [String:AnyObject]
            return city["city"]as? String
        }else{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
            let county=(city["counties"]as! NSArray)[row]as! [String:AnyObject]
            return  county["county"]as? String
        }
    }*/
    
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
    
    //设置pickweView内容及文字大小字体的大小
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label=UILabel()
        label.backgroundColor=UIColor.white
        label.layer.borderColor=UIColor.white.cgColor
        label.textAlignment=NSTextAlignment.center
        if component==0{
            label.sizeToFit()
            label.font=UIFont.systemFont(ofSize: 32*PX)
            label.textColor = myColor().gray3()
            label.text=self.addressArray[row]["province"]as? String
        }
        if component==1{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[row]as! [String:AnyObject]
            label.sizeToFit()
            label.textColor = myColor().gray3()
            label.font=UIFont.systemFont(ofSize: 32*PX)
            label.text=city["city"]as? String
        }
        if component==2{
            let province=self.addressArray[provinceIndex]
            let city=(province["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
            let county=(city["counties"]as! NSArray)[row]as! [String:AnyObject]
            label.sizeToFit()
            label.textColor = myColor().gray3()
            label.font=UIFont.systemFont(ofSize: 32*PX)
            label.text=county["county"]as? String
        }
        return  label
    }
    
    
    //触摸按钮时，获得被选中的索引
    @objc func getSelAddress()->[String:AnyObject]{
        //获取选中的省
        let p=self.addressArray[provinceIndex]
        let province=p["province"]as!String
        let provinceCode = p["provinceCode"]!
        
        //获取选中的城市
        let c=(p["cities"]as! NSArray)[cityIndedx]as! [String:AnyObject]
        let city=c["city"]as!String
        let cityCode = c["cityCode"]!
        
        //获取选中的区县
        let area = (c["counties"]as!NSArray)[areaIndex]as! [String:AnyObject]
        let county = area["county"]as!String
        let countyCode = area["countyCode"]!

        
        //拼接输出消息
        let messages="索引：\(provinceIndex)-\(cityIndedx)-\(areaIndex)\n"+"值：\(province)-\(city)-\(area)"
        let message=["province":province,"city":city,"county":county,"code":countyCode,"area":"\(province)\(city)\(county)"] as [String : AnyObject]
        return message as [String:AnyObject]
    }
}
