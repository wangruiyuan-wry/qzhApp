//
//  imgClass.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/10/23.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class imgClass: UIImageView {
    func setImgSize(_ x:Int,y:Int,width:Int,height:Int,name:String,setWidth:CGFloat){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        let img=UIImage(named:name)?.specifiesWidth(setWidth)
        self.image=img
    }
    
    func agreementImage(){
        self.image=UIImage(named:"agreementLogo")
        self.contentMode = .scaleAspectFit
    }
    
    //设置圆角图片
    func setRoundImg(_ radius:CGFloat){
        self.layer.cornerRadius=radius
        self.layer.masksToBounds=true
    }
    
    
    //设置边框线
    func setBlueBorder(_ width:CGFloat){
        self.layer.borderWidth=width
        self.layer.borderColor = UIColor(red:0/255,green:167/255,blue:250/255,alpha:1).cgColor
    }
    
    func setBorder(_ color:UIColor,width:CGFloat){
        self.layer.borderWidth=width
        self.layer.borderColor = color.cgColor
    }
    
    //会员中心每项的小图标
    func setIconUser(_ img:String){
        self.frame=CGRect(x:10,y:7,width:26,height:26)
        self.image=UIImage(named:img)
    }
    
    //会员中心右指图标let iconRightHeader:imgClass=imgClass()
    //iconRightHeader.frame=CGRect(x: Int(widths-25), y: Int(32),width:15,height:16)
    //iconRightHeader.image=UIImage(named:"ToRightImg")
    //iconRightSlarly.frame=CGRect(x: Int(widths-25), y: Int(12),width:15,height:16)
    func setUserToRightIcon(_ widths:CGFloat){
        self.frame=CGRect(x: Int(widths-25), y: Int(12),width:15,height:16)
        self.image=UIImage(named:"ToRightImg")
    }
    
    
    
}

extension UIImage{
    //重设图片大小
    func reSizeImage(_ reSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x:0,y:0,width:reSize.width,height:reSize.height))
        let reSizeImages:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
       return reSizeImages
    }
    //按比例缩放
    func scaleImage(_ sacleSize:CGFloat)->UIImage{
        let reSize=CGSize(width:self.size.width*sacleSize,height:self.size.height*sacleSize)
        return reSizeImage(reSize)
    }
    //指定高度成比例缩放
    func specifiesHeight(_ sacleheight:CGFloat)->UIImage{
        let reSize=CGSize(width:(sacleheight/self.size.height)*self.size.width,height:sacleheight)
        return reSizeImage(reSize)
    }
    
    //指定宽度成比例缩放
    func specifiesWidth(_ saclewidth:CGFloat)->UIImage{
        let reSize = CGSize(width:saclewidth,height:(saclewidth/self.size.width)*self.size.height)
        return reSizeImage(reSize)
    }
    
    //获取图片颜色
    func getPixelColor(_ pos:CGPoint)->(alpha: CGFloat, red: CGFloat, green: CGFloat,blue:CGFloat){
        let pixelData=self.cgImage!.dataProvider!.data
        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return (a,r,g,b)
    }
}
extension UIImageView{
   /* override func addOnClickLister(target:AnyObject,action:Selector){
        let gr=UITapGestureRecognizer(target:target,action:action)
        gr.numberOfTapsRequired=1
        isUserInteractionEnabled=true
        addGestureRecognizer(gr)
    }*/
}
