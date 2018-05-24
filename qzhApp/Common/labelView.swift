//
//  labelView.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/10/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class labelView: UILabel {
    
    private var padding = UIEdgeInsets.zero
    
    @IBInspectable
    var paddingLeft:CGFloat{
        set {padding.left=newValue}
        get {return padding.left}
    }
    
    @IBInspectable
    var paddingRight:CGFloat{
        set {padding.right=newValue}
        get {return padding.right}
    }
    
    @IBInspectable
    var paddingTop:CGFloat{
        set {padding.top=newValue}
        get {return padding.top}
    }
    
    @IBInspectable
    var paddingBottom:CGFloat{
        set {padding.bottom=newValue}
        get {return padding.bottom}
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets=self.padding
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left+insets.right)
        rect.size.height += (insets.bottom+insets.top)
        return rect
    }
    
    //行间距
    var parpah=NSMutableParagraphStyle()
    
    //根据需求设置大小
    func setLabelView(_ x:Int,y:Int,width:Int,height:Int,align:NSTextAlignment,bgColor:UIColor,txtColor:UIColor,text:String){
        let texts=PublicFunction().flattenHTML(text)
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.textAlignment=align
        self.backgroundColor=bgColor
        self.textColor=txtColor
        self.text=texts
    }
    
    //设置实发工资字体大小显示
    func setRealWages(_ txt:String){
        if let idx=txt.characters.index(of: "."){
            self.font=UIFont.boldSystemFont(ofSize: 16)
            let indexTxt:Int=txt.characters.distance(from: txt.startIndex, to: idx)
            let txtAttr=NSMutableAttributedString(string:txt)
            txtAttr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 26), range:NSMakeRange(0, indexTxt))
            let txtLength:Int=txt.characters.count
            //txtAttr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSMakeRange(indexTxt-1,txtLength))
            self.attributedText=txtAttr
        }else{
            self.font=UIFont.boldSystemFont(ofSize: 26)
        }
    }
    
    //高度自动由内容文字撑开
    func getLabelHeight(_ labelStr:String,font:UIFont,width:CGFloat)->CGFloat{
        let labelStrs=PublicFunction().flattenHTML(labelStr)
        let statusLabelText:NSString=labelStrs as NSString
        let size=CGSize(width:width,height:900)
        let dic=NSDictionary(object:font,forKey:NSFontAttributeName as NSCopying)
        let strSize=statusLabelText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as?[String:AnyObject], context: nil).size
        return strSize.height
    }
    //宽度自动由文字内容撑开
    func getLabelWidth(_ labelStr:String,font:UIFont,height:CGFloat)->CGFloat{
        let labelStrs=PublicFunction().flattenHTML(labelStr)
        let statusLabelText:NSString=labelStrs as NSString
        let dic=NSDictionary(object:font,forKey:NSFontAttributeName as NSCopying)
        let size=CGSize(width:900,height:height)
        let strSize=statusLabelText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [String:AnyObject], context: nil).size
        return strSize.width
    }
    
    //设置允许操作
    func allowsOperation(){
        self.isUserInteractionEnabled=true
        
    }
    
    //设置灰色字体字体颜色
    func setGrayFontColor(){
        self.textColor=UIColor(red:136/255,green:136/255,blue:136/255,alpha:1)
    }
    
    //设置蓝色字体颜色
    func setBlueFontColor(){
        self.textColor=UIColor(red:0/255,green:167/255,blue:250/255,alpha:1)
    }
    
    //设置红色字体颜色
    func setRedFontColor(){
        self.textColor=UIColor(red:255/255,green:0/255,blue:0/255,alpha:1)
    }
    
    //标题字体大小
    func setTtiltleSize(){
        self.font=UIFont.systemFont(ofSize: 14)
    }

    //字体大小
    func setFontSize(size:CGFloat){
        self.font=UIFont.systemFont(ofSize: size*PX)
    }

    
    //大号标字体大小
    func setBigSize(){
        self.font=UIFont.systemFont(ofSize: 13)
    }

    
    //文本字体大小
    func setBodyTxtSize(){
        self.font=UIFont.systemFont(ofSize: 12)
    }
    
    ///附文字体大小
    func setSmallTxtSize(){
        //self.font=UIFont(name:"Zapfino",size:10)
        //self.font=UIFont.italicSystemFont(ofSize: 10)
        self.font=UIFont.systemFont(ofSize: 10)
    }
    
    //文字溢出显示省略号
    func setTxtOver(_ line:Int){
        self.lineBreakMode = NSLineBreakMode.byTruncatingTail
        self.numberOfLines=line
    }
    
    //设置背景透明
    func setBackgroungColorToClearColor(){
        self.backgroundColor=UIColor.clear
    }
    
    //会员中心分组标题的label
    func setUserGroupTiltle(_ text:String){
        self.text=text
        self.setBackgroungColorToClearColor()
        self.setSmallTxtSize()
        self.setGrayFontColor()
    }
    
    //设置会员中心每项的标题
    func setUserListTitle(_ width:Int,title:String){
        let titles=PublicFunction().flattenHTML(title)
        self.frame=CGRect(x:50,y:0,width:width-130,height:40)
        self.text=titles
        self.font=UIFont(name:"Zapfino",size:13)
        
        //self.textAlignment=NSTextAlignment.center  文字水平居中
        self.alignMiddle()
        //self.layer.borderWidth=1
        
    }
    
    //分割线
    func divider(_ x:Int,y:Int,width:Int,height:Int,color:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor = color
    }
    
    //设置字体颜色以及大小
    func setupText(size:CGFloat,color:UIColor){
        self.setFontSize(size:size)
        self.textColor=color
    }
    
    //我的薪酬页面label设置
    func setLeftLabel(_ txt:String,width:Int){
        let txts=PublicFunction().flattenHTML(txt)
        self.setLabelView(10, y: 5, width: Int(width/3)-10, height: 15, align: NSTextAlignment.left, bgColor: UIColor.clear, txtColor: UIColor.black, text: txts)
        self.setBodyTxtSize()
    }
    func setRightLabel(_ txt:String,width:Int){
        let txts=PublicFunction().flattenHTML(txt)
        self.setLabelView(Int(width/3), y: 5, width: Int(width)-Int(width/3)-10, height: 15, align: NSTextAlignment.right, bgColor: UIColor.clear, txtColor:myColor().Gray8(), text: txts)
        self.font=UIFont.systemFont(ofSize: 11)
    }
    
    //企业介绍标题字
    func setCoustomCompanyInfoTitle(_ y:Int,width:Int,title:String){
        let txts=PublicFunction().flattenHTML(title)
        self.frame=CGRect(x:Int(PX*30),y:y,width:width,height:Int(PX*44))
        self.text=txts
        self.setFontSize(size: 32)
        self.textAlignment=NSTextAlignment.center
    }
    //企业介绍正文字
    func setCoustomCompanyInfoTxt(_ y:Int,width:Int,height:Int,title:String){
        let txts=PublicFunction().flattenHTML(title)
        self.frame=CGRect(x:Int(PX*30),y:y,width:width,height:height)
        self.text=txts
        self.setFontSize(size:28)
        self.textAlignment=NSTextAlignment.center
        self.lineBreakMode=NSLineBreakMode.byCharWrapping
        self.numberOfLines=0
    }
    
    //设置评价中心字体颜色
    func setTextColor(_ txt:String,textColor:UIColor){
        let txts=PublicFunction().flattenHTML(txt)
        if let idx=txts.characters.index(of: "("){
            self.textColor=textColor
            let indexTxt:Int=txts.characters.distance(from: txts.startIndex, to: idx)
            let txtAttr=NSMutableAttributedString(string:txts)
             txtAttr.addAttribute(NSForegroundColorAttributeName,value: UIColor.black,range:NSMakeRange(0, indexTxt))
            let txtLength:Int=txt.characters.count
            self.attributedText=txtAttr
        }else{
            self.textColor=UIColor.black
        }

    }
    
    //设置部分文字高亮显示
    func setSomeTxtColor(_ txt:String,textColor:UIColor,separator:Character,lightColor:UIColor){
        let txts=PublicFunction().flattenHTML(txt)
        if let idx=txts.characters.index(of: separator){
            self.textColor=lightColor
            let indexTxt:Int=txts.characters.distance(from: txts.startIndex, to: idx)
            let txtAttr=NSMutableAttributedString(string:txts)
            txtAttr.addAttribute(NSForegroundColorAttributeName,value: UIColor.black,range:NSMakeRange(0, indexTxt))
            let txtLength:Int=txt.characters.count
            self.attributedText=txtAttr
        }else{
            self.textColor=textColor
        }
        
    }
}

extension UILabel{
    //UILabel文字上对齐
    func alignTop()->Void{
        guard self.text?.isEmpty==false else {
            return
        }
        self.lineBreakMode = .byCharWrapping //以字符为显示单位显示，后面部分省略不显示
        let size=CGSize(width:self.frame.width,height:CGFloat(MAXFLOAT))
        let dic = NSDictionary(object: self.font, forKey: NSFontAttributeName as NSCopying)
        let fontSize = self.text?.boundingRect(with: size, options: .truncatesLastVisibleLine, attributes: dic as? [String : AnyObject], context:nil).size
        let newLinesToPad = (self.frame.height - (fontSize?.height)!)/(fontSize?.height)!
        for _ in 0..<Int(newLinesToPad) {
            self.text = self.text?.appending("\n")
        }
    }
    
    //UILable 文字下对齐
    func alignBottom() -> Void {
        guard self.text?.isEmpty == false else {
            return
        }
        self.lineBreakMode = .byCharWrapping //以字符为显示单位显示，后面部分省略不显示
        let size = CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT))
        let dic = NSDictionary(object: self.font, forKey: NSFontAttributeName as NSCopying)
        let fontSize = self.text?.boundingRect(with: size, options: .truncatesLastVisibleLine, attributes: dic as? [String : AnyObject], context:nil).size
        let newLinesToPad = (self.frame.height - (fontSize?.height)!)/(fontSize?.height)!
        for _ in 0..<Int(newLinesToPad) {
            self.text = String(format: " \n%@", self.text!)
        }
    }
    
    //UILable 文字垂直居中对齐
    func alignMiddle() -> Void {
        guard self.text?.isEmpty == false else {
            return
        }
        self.lineBreakMode = .byCharWrapping //以字符为显示单位显示，后面部分省略不显示
        let size = CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT))
        let dic = NSDictionary(object: self.font, forKey: NSFontAttributeName as NSCopying)
        let fontSize = self.text?.boundingRect(with: size, options: .truncatesLastVisibleLine, attributes: dic as? [String : AnyObject], context:nil).size
        let newLinesToPad = (self.frame.height - (fontSize?.height)!)/(fontSize?.height)!/2
        for _ in 0..<Int(newLinesToPad) {
            self.text = self.text?.appending("\n ")
        }
    }
}



