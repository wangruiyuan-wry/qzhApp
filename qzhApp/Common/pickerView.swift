//
//  pickerView.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/3.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class pickerView:UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    //选择器
    var pickerView:UIPickerView!
    
    //所有数据集合
    var itemArray:[Dictionary<String,AnyObject>]=[]
    
    //选择的索引
    var itemIndex=0
    
    //pickerView的宽度
    var picViewWidth:CGFloat?
    
    func initLoadData(paramArray:[Dictionary<String,AnyObject>]){
        //初始化数据
        self.itemArray=paramArray
        
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
            return picViewWidth!
        default:
            break
        }
        return 0.0
        
    }
    
    //设置行高
    func pickerView(_ pickerView:UIPickerView,rowHeightForComponent compent:Int)->CGFloat{
     return 30
     }
    
    //设置选择框为3列，继承UIPickerViewDataSource协议
    func numberOfComponents(in pickerView:UIPickerView)->Int{
        return 1
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView:UIPickerView,numberOfRowsInComponent component:Int)->Int{
            return self.itemArray.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return self.itemArray[row]["state"]as? String
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView:UIPickerView,didSelectRow row:Int,inComponent component:Int){
        switch (component) {
        case 0:
            itemIndex=row;
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
            label.text=self.itemArray[row]["state"]as? String
        }
        return  label
    }
    
    
    //触摸按钮时，获得被选中的索引
    @objc func getResult()->AnyObject{
        //获取选中的省
        let p=self.itemArray[itemIndex]
        let result=p["state"]!
        let resultId=p["id"]!
      
        //拼接输出消息
        let message=["result":result,"id":resultId]
        return message as AnyObject
    }
}

