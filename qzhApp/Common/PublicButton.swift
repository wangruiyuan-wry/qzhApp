//
//  PublicButton.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class PublicButton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btn_set()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        btn_set()
    }
    
    fileprivate func btn_set(){
        layer.cornerRadius=5
        layer.masksToBounds=true
        layer.borderWidth=1
    }
    
    func white_btn(){
        backgroundColor=UIColor(red:255/255,green:255/255,blue:255/255,alpha:1)
        setTitleColor(UIColor(red:68/255,green:68/255,blue:68/255,alpha:1), for: .normal)
        layer.borderColor=UIColor(red:245/255,green:245/255,blue:245/255,alpha:1).cgColor
    }
    
    
    func blue_btn(){
        layer.borderColor=UIColor(red:0/255,green:167/255,blue:250/255,alpha:1).cgColor
        backgroundColor=UIColor(red:0/255,green:167/255,blue:250/255,alpha:1)
    }
    
    func bigSize_btn(_ width:Int){
        var height_txt:CGFloat = CGFloat(60)
        
    }
    
    func setBtn(_ x:Int,y:Int,width:Int,height:Int,bgColor:UIColor,title:String,txtColor:UIColor,borderColor:UIColor){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=bgColor
        self.tintColor=txtColor
        setTitleColor(txtColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderColor=borderColor.cgColor
        self.layer.cornerRadius=5
        self.layer.masksToBounds=true
        self.layer.borderWidth=1
    }
    
    //带小图标的按钮左图右文字
    func btnIcon(_ x:Int,y:Int,width:Int,height:Int,icon:String,iconHeight:CGFloat,title:String,fontSize:CGFloat){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=UIColor.clear
        //self.setTitle(title, for: .normal)
        var img = UIImage(named:icon)?.specifiesHeight(iconHeight)
        img=img?.withRenderingMode(.alwaysOriginal)
        //self.setImage(img, for: .normal)
        self.titleLabel?.font=UIFont.systemFont(ofSize: fontSize)
        self.backgroundColor=UIColor.clear
        self.layer.borderColor=UIColor.clear.cgColor
        self.set(image: img, title: title, titlePosition: UIViewContentMode.right, additionalSpacing: 50, state: .normal)
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignment.left
    }
    
    //小字体的摁钮
    func setTitleSize(_ size:CGFloat){
        self.titleLabel?.font=UIFont.systemFont(ofSize: size*PX)
    }
    
    //
    func setBtnIconAtright(icon:String,title:String,color:UIColor){
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13) //文字大小
        self.setTitleColor(color, for: .normal) //文字颜色
        self.set(image: UIImage(named: icon), title: title, titlePosition: .left,
                 additionalSpacing: 10.0, state: .normal)
        self.layer.borderWidth=0
    }
}

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    fileprivate func positionLabelRespectToImage(_ title: String, position: UIViewContentMode,spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(attributes: [NSFontAttributeName: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
