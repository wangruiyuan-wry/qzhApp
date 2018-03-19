//
//  TextField.swift
//  qzhApp
//
//  Created by sbxmac on 2017/9/18.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class TextFieldValidator:UIView{
    var txtFlag:UILabel!
    var txtFieldFlag:UITextField!
    var spacing:CGFloat?
    var delegate:UITextFieldDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        txtFlag=UILabel()
        txtFieldFlag=UITextField()
    }
    
    func initWithFrame(labelText:NSString,text:NSString,placegolder:NSString,spacing:CGFloat,width:Int){
       self.width=CGFloat(width)
        var width_txt:CGFloat = frame.size.width
        var height_txt:CGFloat = frame.size.height
        
        
        
        txtFlag=UILabel(frame:CGRect(x:10,y:0,width:width_txt/3,height:height_txt))
        txtFlag.backgroundColor=UIColor.clear
        txtFlag.textAlignment=NSTextAlignment.left
        
        self.spacing=spacing
        self.addSubview(txtFlag)
        
        txtFieldFlag=UITextField(frame:CGRect(x:width_txt/3+spacing-10,y:0,width:width_txt-width_txt/3+spacing,height:height_txt))
        txtFieldFlag.borderStyle = UITextBorderStyle.roundedRect
        txtFieldFlag.clearButtonMode = UITextFieldViewMode.always
        self.addSubview(txtFieldFlag)
        
        setText(text: text)
        setLabelText(text: labelText)
        txtFieldFlag.placeholder=placegolder as String
    }
    
    func initWithFrame_Btn(labelText:NSString,text:NSString,placegolder:NSString,spacing:CGFloat,width:Int){
        self.width=CGFloat(width)
        var width_txt:CGFloat = frame.size.width
        var height_txt:CGFloat = frame.size.height
        
        
        
        txtFlag=UILabel(frame:CGRect(x:10,y:0,width:width_txt/3,height:height_txt))
        txtFlag.backgroundColor=UIColor.clear
        txtFlag.textAlignment=NSTextAlignment.left
        
        self.spacing=spacing
        self.addSubview(txtFlag)
        
        txtFieldFlag=UITextField(frame:CGRect(x:width_txt/3+spacing-10,y:0,width:width_txt-width_txt/3+spacing-100,height:height_txt))
        txtFieldFlag.borderStyle = UITextBorderStyle.roundedRect
        txtFieldFlag.clearButtonMode = UITextFieldViewMode.always
        self.addSubview(txtFieldFlag)
        
        setText(text: text)
        setLabelText(text: labelText)
        txtFieldFlag.placeholder=placegolder as String
    }
    
    func initWithFrame_Btn(labelText:NSString,placeholder:NSString,spacing:CGFloat,width:Int){
        return initWithFrame_Btn(labelText: labelText,text:"",placegolder:placeholder,spacing:spacing,width:width)
    }
    
    func initWithFrame_Btn(labelText:NSString,placeholder:NSString,width:Int){
        return initWithFrame_Btn(labelText: labelText,text:"",placegolder:placeholder,spacing:0,width:width)
    }
    
    func initWithLogin(image_name:NSString,placegolder:NSString,width:Int){
        self.width=CGFloat(width)
        var width_txt:CGFloat = frame.size.width
        var height_txt:CGFloat = frame.size.height
        var img_y=height_txt-25
        //var img_view:UIImageView=UIImageView(frame:CGRect(x:15,y:img_y/2,width:25,height:25))
        var img_view=UIImageView(image:UIImage(named:image_name as String))
        img_view.frame=CGRect(x:15,y:img_y/2,width:25,height:25)
        self.addSubview(img_view)
        
        txtFieldFlag=UITextField(frame:CGRect(x:75,y:0,width:width_txt-75,height:height_txt))
        txtFieldFlag.borderStyle = UITextBorderStyle.roundedRect
        txtFieldFlag.clearButtonMode = UITextFieldViewMode.always
        self.addSubview(txtFieldFlag)
        
        setText(text: "")
        setLabelText(text: "")
        txtFieldFlag.placeholder=placegolder as String
    }
    
    
    func initWithFrame(labelText:NSString,placeholder:NSString,spacing:CGFloat,width:Int){
        return initWithFrame(labelText: labelText,text:"",placegolder:placeholder,spacing:spacing,width:width)
    }
    
    func initWithFrame(labelText:NSString,placeholder:NSString,width:Int){
        return initWithFrame(labelText: labelText,text:"",placegolder:placeholder,spacing:0,width:width)
    }
    
    func setBorder(){
        txtFieldFlag.borderStyle=UITextBorderStyle(rawValue: 0)!
        var border=UIView(frame:CGRect(x:0,y:self.bounds.height,width:self.bounds.width,height:1))
        border.backgroundColor=UIColor(red:221/255,green:221/255,blue:221/255,alpha:1)
        
        self.addSubview(border)
    }
    
    func setdelegate(delegate:UITextFieldDelegate){
        self.delegate=delegate
        txtFieldFlag.delegate=delegate
    }
    
    func setlefttextFLAG(text:NSString){
        txtFlag.text=text as String
    }
    
    func setLabelText(text:NSString){
        txtFlag.text=text as String
    }
    
    func setText(text:NSString){
        txtFieldFlag.text=text as String
    }
    
    func getText()->NSString{
        return txtFieldFlag.text! as NSString
    }
    
    func setTxtFlagAlignment(option:NSTextAlignment){
        txtFieldFlag.textAlignment=option
    }
    
    func setSpacing(spacing:CGFloat){
        self.spacing=spacing
        txtFieldFlag.frame=CGRect(x:txtFlag.frame.size.width+spacing,y:0,width:self.frame.size.width-txtFlag.frame.size.width-spacing,height:self.frame.size.height)
    }
    
    func setSecureTextEntry(option:Bool){
        txtFieldFlag.isSecureTextEntry=option
    }
    
    func setClearButtonModel(mode:UITextFieldViewMode){
        txtFieldFlag.clearButtonMode=mode
    }
    
    func setReturnKey(type:UIReturnKeyType){
        txtFieldFlag.returnKeyType=type
    }
}

class textArea: UITextView,UITextViewDelegate{
    var placeHolder:String?=""{
        didSet{
            if self.text==""{
                self.text=placeHolder
                self.textColor=UIColor.lightGray
            }
        }
    }
    
    //设置圆角输入文本域
    func setRoundCornersTextArea(x:Int,y:Int,width:Int,height:Int,txt:String,bgColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.isEditable=true
        self.isSelectable=true
        self.font=UIFont.systemFont(ofSize: 12)
        self.textAlignment = .left
        self.backgroundColor=bgColor
        self.layer.cornerRadius=5
        self.layer.masksToBounds=true
        self.text=txt
        self.textColor=UIColor.black
        self.isEditable=true
        self.delegate=self
    }
    func setText(text:String){
        self.text=text
        
    }
    
    //文本框即将编辑
    func becomeFirstResponder(_ textView:UITextView)->Bool{
        print("\(textView.textColor)")
        if textView.textColor==UIColor.lightGray{
            self.textColor=UIColor.black
            self.text=""
        }
        return true
    }

}

class textInput:UITextField{
    func setInput(x:Int,y:Int,width:Int,height:Int,bg:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.font=UIFont.systemFont(ofSize: 12)
        self.backgroundColor=bg
        self.borderStyle = UITextBorderStyle.roundedRect
        self.clearButtonMode = UITextFieldViewMode.always
    }
    func setText(text:NSString){
        self.text=text as String
    }
    
    func getText()->NSString{
        return self.text! as NSString
    }
}

extension UITextField{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()//1这里是一种收键盘的方法,逼格稍微高点
        
        //view.endEditing(true)//2这是另外一种收键盘的方法,比较通用
        return true
    }
    
}
