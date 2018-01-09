//
//  scrolliew.swift
//  qzh_ios
//
//  Created by sbxmac on 2017/10/30.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit

class srcollView: UIScrollView,UIScrollViewDelegate {
    
    //有头部有底部
    func body_Size(y:Int,width:Int,height:Int){
        self.frame=CGRect(x:0,y:y,width:Int(SCREEN_WIDTH),height:height)
        self.backgroundColor=UIColor(red:238/255,green:238/255,blue:238/255,alpha:1)
        self.delegate=self
        self.alwaysBounceVertical=false
        self.bounces=true
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled=true
        
    }
    func refresh(y:Int,width:Int)->UIActivityIndicatorView{
        let refresh=UIActivityIndicatorView(frame:CGRect(x:Int((SCREEN_WIDTH-30)/2),y:y+10,width:30,height:30))
        refresh.backgroundColor=UIColor.white
        refresh.activityIndicatorViewStyle = .white
        refresh.color=UIColor.gray
        self.contentSize=CGSize(width:width,height:width/8+20)
        refresh.tag=9999
        refresh.hidesWhenStopped=true
        refresh.stopAnimating()
        return refresh
    }
    
    func stopRefresh(_ scrollView: UIScrollView){
        let refresh=scrollView.viewWithTag(9999) as! UIActivityIndicatorView
        refresh.stopAnimating()
        let height=scrollView.contentSize.height
        scrollView.contentSize=CGSize(width:scrollView.width,height:height-refresh.height-20)
    }
    
    //设置普通的view容器
    func setViewContent(x:Int,y:Int,width:Int,height:Int){
        self.frame=CGRect(x:x,y:y,width:width,height:height)
        self.backgroundColor=UIColor.white
        self.showsVerticalScrollIndicator  = false
        self.isScrollEnabled=true
    }
    

    //清空内容
    func setViewEmpty(){
        let subviews=self.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
    }
    
    //在scrollView滚动的时候调用
   func scrollViewDidScroll(_ scrollView: UIScrollView){
    print(scrollView.contentSize.height)
        if scrollView.contentOffset.y==scrollView.contentSize.height-scrollView.bounds.size.height{
            if scrollView.superview?.restorationIdentifier != ""{
                let height=scrollView.contentSize.height
                let refresh = self.refresh(y:Int(scrollView.contentSize.height),width:Int(scrollView.width))
                scrollView.addSubview(refresh)
                scrollView.contentSize=CGSize(width:scrollView.width,height:height+refresh.height+20)
                if !refresh.isAnimating{
                    refresh.startAnimating()
                }
                /*if scrollView.superview?.restorationIdentifier=="MyCustomer" && scrollView.restorationIdentifier != "false"{
                    MyCustomer().rollingLoad(grounpInt: scrollView.tag, bodys: scrollView as! srcollView)
                }*/
            }
            
        }
    }
    
    //在scrollView将要开始 拖动的时候调用
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    //在scrollView将要停止拖动的时候调用（手将要松开的时候，不代表停止滚动）参数2:手松开的时候在X方向和Y方向上的速度  参数3：预判滚动停止的偏移量
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    //停止减速的时候会调用（实质就是停止滚动时候会调用）
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    //将要停止拖拽（将要开始减速）、
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    //已经停止滚动动画的时候调用
    //只有在通过setContentoffset的方法使用动画效果让scrollView滚动，在停止滚动的时候才会调用这个方法
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }
    //只有通过点击状态栏自动滚动到顶部的时候才会调用
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        
    }
    
    
    //===========================缩放相关===============================
    //UIScrollView已经实现了缩放功能
    //想要让UIScrollView上的内容进行缩放 必须满足以下条件：
    //a.设置缩放的最大倍数和最小倍数()
    //b.通过协议方法告诉UIScrollView缩放对象
    //1.正在缩放的时候会调用
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
        print("正在缩放")
    }
    //2.告诉UIScrollView在缩放的时候，对哪个视图进行缩放(设置缩放对象)
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return scrollView.subviews[0]
    }
    
    
}


extension UIScrollView{
    
}
