//
//  QZHUILabelView+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHUILabelView: UILabel {
    
    // 设置内边距
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
    
    // 行间距
    var parpah=NSMutableParagraphStyle()
    
    // 根据需求设置大小
    func setLabelView(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat,_ align:NSTextAlignment,_ bgColor:UIColor,_ txtColor:UIColor,_ size:CGFloat,_ text:String){
        let texts=PublicFunction().flattenHTML(text)
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.textAlignment=align
        self.backgroundColor=bgColor
        self.textColor=txtColor
        self.text=texts
        self.font = UIFont.systemFont(ofSize: size*PX)

    }
    
    // 分割线
    func divider(_ x:Int,y:Int,width:Int,height:Int,color:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor = color
    }
    
    // 分割线
    func dividers(_ x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,color:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor = color
    }
    
    // 自适应高度
    func autoLabelHeight(_ labelStr:String,font:CGFloat,width:CGFloat)->CGFloat{
        let labelStrs=PublicFunction().flattenHTML(labelStr)
        let statusLabelText:NSString=labelStrs as NSString
        let size=CGSize(width:width,height:900)
        let dic=NSDictionary(object:UIFont.systemFont(ofSize: font*PX) ,forKey:NSFontAttributeName as NSCopying)
        let strSize=statusLabelText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as?[String:AnyObject], context: nil).size
        return strSize.height
    }
    
    // 自适应宽度
    func autoLabelWidth(_ labelStr:String,font:CGFloat,height:CGFloat)->CGFloat{
        let labelStrs=PublicFunction().flattenHTML(labelStr)
        let statusLabelText:NSString=labelStrs as NSString
        let dic=NSDictionary(object:UIFont.systemFont(ofSize: font*PX),forKey:NSFontAttributeName as NSCopying)
        let size=CGSize(width:900,height:height)
        let strSize=statusLabelText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [String:AnyObject], context: nil).size
        return strSize.width
    }
    
    // 设置字体渐变色
    func setupGradient(uiView:QZHUIView,colorArray:[CGColor],loctions:[NSNumber],start:CGPoint,end:CGPoint){
        
        let gradientColors = colorArray
        
        let gradientLocaltions:[NSNumber] = loctions
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLocaltions
        
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        
        gradientLayer.frame = self.frame
        
        uiView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        gradientLayer.mask = self.layer
        
    }
    
    // 设置背景渐变色
    func setupBgGradient(uiView:QZHUIView,colorArray:[CGColor],loctions:[NSNumber],start:CGPoint,end:CGPoint){
    
        let gradientColors = colorArray
        
        let gradientLocaltions:[NSNumber] = loctions
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLocaltions
        
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        
        gradientLayer.frame = uiView.frame
        
        uiView.layer.insertSublayer(gradientLayer, at: 0)        
    }
    
    //设置字体大小
    func setRealWages(_ txt:String,big:CGFloat,small:CGFloat,fg:Character){
        if let idx=txt.characters.index(of: fg){
            self.font=UIFont.boldSystemFont(ofSize: small*PX)
            let indexTxt:Int=txt.characters.distance(from: txt.startIndex, to: idx)
            let txtAttr=NSMutableAttributedString(string:txt)
            txtAttr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: big*PX), range:NSMakeRange(0, indexTxt))
            let txtLength:Int=txt.characters.count
            self.attributedText=txtAttr
        }else{
            self.font=UIFont.boldSystemFont(ofSize: big*PX)
        }
    }
    //设置字体颜色
    func setTextColor(_ txt:String,textColor:UIColor,oldColor:UIColor,fg:Character){
        let txts=PublicFunction().flattenHTML(txt)
        if let idx=txts.characters.index(of: fg){
            self.textColor=textColor
            let indexTxt:Int=txts.characters.distance(from: txts.startIndex, to: idx)
            let txtAttr=NSMutableAttributedString(string:txts)
            txtAttr.addAttribute(NSForegroundColorAttributeName,value: UIColor.black,range:NSMakeRange(0, indexTxt))
            let txtLength:Int=txt.characters.count
            self.attributedText=txtAttr
        }else{
            self.textColor=oldColor
        }
        
    }
}
