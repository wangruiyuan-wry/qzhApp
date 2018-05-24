//
//  PublicFunc.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class PublicFunction:NSObject{
    //判断是否登陆并跳转登录页面
    func isLogin(_ ownSelf:UIViewController){
        if CacheFunc().determineWhetherLanding()==false{
            self.pageJump(ownSelf, toPage: "login")
        }
    }
    
    //打开聊天页面
    @objc func open_Chat(_ ownSelf:UIViewController){
        let ownStoryBoard=ownSelf.storyboard
        let anotherVew:UIViewController =  ownStoryBoard!.instantiateViewController(withIdentifier: "chat") as UIViewController
       // ownSelf.present(anotherVew,animated:true,completion:nil)
    }
    //返回上一页
    @objc open func back_page(_ ownSelf:UIViewController){
        ownSelf.presentingViewController!.dismiss(animated:true,completion:nil)
    }
    
    @objc open func pageJump(_ ownSelf:UIViewController,toPage:String){
        let ownStoryBoard=ownSelf.storyboard
        let anotherVew:UIViewController =  ownStoryBoard!.instantiateViewController(withIdentifier:toPage) as UIViewController
        ownSelf.present(anotherVew,animated:true,completion:nil)
        
    }
    
    //设置状态栏背景色
    @objc open func setStatusbackgroundColor(_ color:UIColor){
        let statusBarWindow:UIView=UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar:UIView=statusBarWindow.value(forKey: "statusBar") as! UIView
       // if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
           statusBar.backgroundColor=color
       // }
    }
    
    
    //跳转至指定主页面
    func goMenuPage(_ ownSelf:UIViewController,HomePage:String,pageName:String){
        pageJump(ownSelf, toPage: HomePage)
        Menus().restorationIdentifier=pageName
    }
    
    
    //打开搜索页面
    @objc open func toSearchPage(_ from:String,ownSelf:UIViewController){
        let ownStoryBoard=ownSelf.storyboard
        let anotherVew:UIViewController =  ownStoryBoard!.instantiateViewController(withIdentifier: "chat") as UIViewController
        ownSelf.present(anotherVew,animated:true,completion:nil)
        
    }
    
    //打开月历窗口
    func monthAction(_ ownSelf:UIViewController,success:@escaping(_ response:AnyObject)->()){
        let alert:UIAlertController=UIAlertController(title:"\n\n\n\n",message:nil,preferredStyle:.alert)
        //创建日期选择器
        let datePicker=UIDatePicker(frame:CGRect(x:0,y:0,width:270,height:130))
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.locale=Locale(identifier:"zh_CN") as Locale
        datePicker.date=Date() as Date
        
        alert.addAction(UIAlertAction(title:"确定",style:UIAlertActionStyle.default){
            (alertAction)-> Void in
            success(datePicker)
        })
        
        alert.addAction(UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel,handler:nil))
        alert.view.addSubview(datePicker)
        ownSelf.present(alert, animated: true, completion: nil)
    }
    //打开地址选择器
    func addressAction(_ ownSelf:UIViewController,success:@escaping(_ response:[Dictionary<String,AnyObject>])->()){
        let alert:UIAlertController=UIAlertController(title:"\n\n\n\n",message:nil,preferredStyle:.alert)
        //创建地址选择器
        let addressPiker:provincesThreeLevelCascade=provincesThreeLevelCascade()
        addressPiker.frame=CGRect(x:10,y:0,width:250,height:100)
        addressPiker.initLoadAddressOnly()
        alert.addAction(UIAlertAction(title:"确定",style:UIAlertActionStyle.default){
            (alertAction)-> Void in
            let address:[Dictionary<String,AnyObject>]=addressPiker.getSelAddress()
            success(addressPiker.getSelAddress() as [Dictionary<String,AnyObject>])
        })
        
        alert.addAction(UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel,handler:nil))
        alert.view.addSubview(addressPiker)
        ownSelf.present(alert, animated: true, completion: nil)
    }
    
    //企业类型选择
    func selEnterpriseType(_ ownSelf:UIViewController,success:@escaping(_ response:AnyObject)->()){
        let alert:UIAlertController=UIAlertController(title:"\n\n\n\n",message:nil,preferredStyle:.alert)
        let _EnterpriseTypeData=[["id":222,"state":"企业类型1"],["id":222,"state":"企业类型2"]]
        //创建地址选择器
        let EnterpriseTypePicker:pickerView=pickerView()
        EnterpriseTypePicker.frame=CGRect(x:10,y:0,width:250,height:100)
        EnterpriseTypePicker.initLoadData(paramArray: _EnterpriseTypeData as [Dictionary<String, AnyObject>])
        alert.addAction(UIAlertAction(title:"确定",style:UIAlertActionStyle.default){
            (alertAction)-> Void in
            success(EnterpriseTypePicker.getResult() as AnyObject)
        })
        
        alert.addAction(UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel,handler:nil))
        alert.view.addSubview(EnterpriseTypePicker)
        ownSelf.present(alert, animated: true, completion: nil)
    }
    //一级行业
    func selYJHYType(_ ownSelf:UIViewController,success:@escaping(_ response:AnyObject)->()){
        let alert:UIAlertController=UIAlertController(title:"\n\n\n\n",message:nil,preferredStyle:.alert)
        //创建选择器
        let _YJHYTypeData=[["id":222,"state":"一级行业1"],["id":222,"state":"一级行业2"]]
        let YJHYTypePiker:pickerView=pickerView()
        YJHYTypePiker.frame=CGRect(x:10,y:0,width:250,height:100)
        YJHYTypePiker.initLoadData(paramArray: _YJHYTypeData as [Dictionary<String, AnyObject>])
        alert.addAction(UIAlertAction(title:"确定",style:UIAlertActionStyle.default){
            (alertAction)-> Void in
            let result:AnyObject=YJHYTypePiker.getResult()
            success(result as AnyObject)
        })
        
        alert.addAction(UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel,handler:nil))
        alert.view.addSubview(YJHYTypePiker)
        ownSelf.present(alert, animated: true, completion: nil)
    }
    
    //二级行业
    func selEJHYType(_ ownSelf:UIViewController,success:@escaping(_ response:AnyObject)->()){
        let alert:UIAlertController=UIAlertController(title:"\n\n\n\n",message:nil,preferredStyle:.alert)
        //创建选择器
        let _EJHYTypeData=[["id":222,"state":"二级行业1"],["id":222,"state":"二级行业2"]]
        let EJHYTypePiker:pickerView=pickerView()
        EJHYTypePiker.frame=CGRect(x:10,y:0,width:250,height:130)
        EJHYTypePiker.initLoadData(paramArray: _EJHYTypeData as [Dictionary<String, AnyObject>])
        alert.addAction(UIAlertAction(title:"确定",style:UIAlertActionStyle.default){
            (alertAction)-> Void in
            let result:AnyObject=EJHYTypePiker.getResult()
            success(result as AnyObject)
        })
        
        alert.addAction(UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel,handler:nil))
        alert.view.addSubview(EJHYTypePiker)
        ownSelf.present(alert, animated: true, completion: nil)
    }

    
    //网络图片的url
    func imgFromURL(_ path:String)->Data{
         let data = try! Data(contentsOf:URL(string:path)!)

        return data
    }
    
    //将URL转换为Data
    func setDataFromURL(_ url:String)->Data{
        return try! Data(contentsOf:URL(string:url)!)
    }
    
    //自动消失的弹出框
    func alertPrompt(_ title:String,ownSelf:UIViewController){
        let alert=UIAlertController(title:title,message:nil,preferredStyle:.alert)
        ownSelf.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
            ownSelf.presentedViewController?.dismiss(animated: false, completion: nil)
        })
        
    }
    //网络连接失败
    func alertPromptNET(_ ownSelf:UIViewController){
        let alert=UIAlertController(title:"网络连接失败",message:nil,preferredStyle:.alert)
        ownSelf.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
            ownSelf.presentedViewController?.dismiss(animated: false, completion: nil)
            self.back_page(ownSelf)
        })
        
    }
    
    //电话拨打
    func telCall(_ tel:String,ownself:UIViewController){
        if tel==""{
            self.alertPrompt("电话号码为空", ownSelf: ownself)
        }else{
            let urlString="tel://\(tel)"
            if let url=URL(string:urlString){
                if #available(iOS 10,*){
                    UIApplication.shared.open(url, options: [:], completionHandler: {(success)in })
                }else{
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    //发短信
    func sendTexting(_ tel:String,ownself:UIViewController){
        if tel==""{
            self.alertPrompt("电话号码为空", ownSelf: ownself)
        }else{
            let url=URL(string:"sms://\(tel)")
            UIApplication.shared.openURL(url!)
        }
        
    }
    
    //发送email
    func emailSend(_ email:String,ownself:UIViewController){
        if email==""{
            self.alertPrompt("E-mail地址为空", ownSelf: ownself)
        }else{
            let url=URL(string:"mailto://\(email)")
            UIApplication.shared.openURL(url!)
        }
    }
    
    
    //设置字典中的空字符
    func setNULLInDIC(_ dic:Dictionary<String,AnyObject>)->Dictionary<String,AnyObject>{
        var this:Dictionary<String,AnyObject>=dic
        for (key,value) in this{
            if "\(value)"=="<null>"{
                this.updateValue("" as AnyObject, forKey: key)
            }else if value is NSNull{
                this.updateValue("" as AnyObject, forKey: key)
            }else if value == nil{
                this.updateValue("" as AnyObject, forKey: key)
            }
        }
        return this
    }
    //判断输入字符串是否是数字，不含其它字符
    func isPurnInt(_ string:String)->Bool{
        let scan:Scanner=Scanner(string:string)
        var val:Int=0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    func isPurnInt(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
    //判断是否是手机号码
    func isTelNumber(_ num:NSString)->Bool
    {
        let mobile = "((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //字符串特殊字符的处理
    func flattenHTML(_ html : String) -> String{
        var strHtmls = html
        strHtmls = strHtmls.replacingOccurrences(of: "\"" , with : "")
        strHtmls = strHtmls.replacingOccurrences(of: "[" , with : "")
        strHtmls = strHtmls.replacingOccurrences(of: "]" , with : "")
        strHtmls = strHtmls.replacingOccurrences(of: "{" , with : "")
        strHtmls = strHtmls.replacingOccurrences(of: "}" , with : "")
        // 过滤&nbsp标签
        strHtmls = strHtmls.replacingOccurrences(of: "&nbsp;" , with : "")
        // 过滤&ldquo等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&ldquo;" , with : "")
        // 过滤&rdquo等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&rdquo;" , with : "")
        // 过滤&hellip等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&hellip;" , with : "...")
        // 过滤&rarr等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&rarr;" , with : "->")
        // 过滤&mdash等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&mdash;" , with : "--")
        // 过滤&lsquo等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&lsquo;" , with : "'")
        // 过滤&rsquo等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&rsquo;" , with : "'")
        // 过滤&amp等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&amp;" , with : "&")
        // 过滤&lt等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&lt;" , with : "<")
        // 过滤&gt等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&gt;" , with : ">")
        // 过滤&nbsp;等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&nbsp;" , with : " ")
        // 过滤&quot;等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&quot;" , with : "\"")
        // 过滤&#39;等标签
        strHtmls = strHtmls.replacingOccurrences(of: "&#39;" , with : "\'")
        // 过滤\n;等标签
        //strHtml = strHtml!.stringByReplacingOccurrencesOfString("\n" , withString : "<br/> ")
        
        //过滤换行标签
        //            strHtml = strHtml!.stringByReplacingOccurrencesOfString("\t" , withString : " ")
        //            strHtml = strHtml!.stringByReplacingOccurrencesOfString("\n" , withString : "#des")
        //            strHtml = strHtml!.stringByReplacingOccurrencesOfString("\r" , withString : " ")
        return strHtmls
    }
   
    //头部消息图标按钮
    @objc func btn_right_chat( )->UIButton{
        var img = UIImage(named:"chatIcon")
        img = img?.specifiesWidth(35*PX)
        let btn=UIButton(frame:CGRect(x:0,y:13*PX,width:45*PX,height:60*PX))
        
        btn.setTitleColor(myColor().Gray6(), for: .normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 6)
        
        btn.set(image: img, title: "消息", titlePosition: .bottom,additionalSpacing: 0, state: .normal)
        btn.imageEdgeInsets=UIEdgeInsetsMake(-5, 2, 0, 2)
        return btn
        
    }

}

extension String{
    var parseJSONString:Any?{
        var any:Any?
        let data=self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do{
            any=try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
        }catch let error as NSError{
            print("error:\(error)")
        }
        return any
    }

    //获取指定字符的位置下标
    func strIndexOf(char:Character)->Int{
        let indexStr:Int
        if let idx=self.characters.index(of: char){
            indexStr=self.characters.distance(from: self.startIndex, to: idx)
        }else{
            indexStr=0-1
        }
        return indexStr
    }
    
    //获取字符串长度
    func getLength()->Int{
        return self.characters.count
    }
}
class StringAndDic{
    func getDicFromString(str:String)->NSDictionary{
        let strData:Data=str.data(using: .utf8)!
        let dict=try? JSONSerialization.jsonObject(with: strData,options: .mutableContainers)
        if dict != nil{
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    func getJSONFromString(str:String)->[[String:Any]]{
        let strData:Data=str.data(using: .utf8)!
        let dict=try? JSONSerialization.jsonObject(with: strData,options: .mutableContainers) as! [[String:Any]]
        if dict != nil{
            return dict!
        }
        return dict!
    }
    
    func getStringFromDic(dic:NSDictionary)->String{
        if(!JSONSerialization.isValidJSONObject(dic)){
            print("无法解析出字符串")
            return ""
        }
        let data:NSData!=try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData!
        let str=NSString(data:data as Data,encoding:String.Encoding.utf8.rawValue)
        return str! as String
    }
}

//扩展NSRange，添加转换成Range的方法
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
      let startIndex = string.index(string.startIndex, offsetBy: self.location)
      let endIndex = string.index(startIndex, offsetBy: self.length)
      return startIndex..<endIndex
  }
}
    
