//
//  QZHSearchBar+Extension.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

class QZHSearchBar: UISearchBar,UISearchBarDelegate {
    var contentInset: UIEdgeInsets? {
        didSet {
            self.layoutSubviews()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.delegate=self
        // view是searchBar中的唯一的直接子控件
        for view in self.subviews {
            // UISearchBarBackground与UISearchBarTextField是searchBar的简介子控件
            for subview in view.subviews {
                // 找到UISearchBarTextField
                if subview.isKind(of:UITextField.classForCoder()) {
                    
                    if let textFieldContentInset = contentInset { // 若contentInset被赋值
                        // 根据contentInset改变UISearchBarTextField的布局
                        subview.frame = CGRect(x: textFieldContentInset.left, y: textFieldContentInset.top, width: self.bounds.width - textFieldContentInset.left - textFieldContentInset.right, height: self.bounds.height - textFieldContentInset.top - textFieldContentInset.bottom)
                    } else { // 若contentSet未被赋值
                        // 设置UISearchBar中UISearchBarTextField的默认边距
                        let top: CGFloat = (self.bounds.height - 28.0) / 2.0
                        let bottom: CGFloat = top
                        let left: CGFloat = 8.0
                        let right: CGFloat = left
                        contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
                    }
                }
            }
        }
    }
}

//MARK: - 设置视图界面
extension QZHSearchBar{
    func style_search_gray(){
        self.placeholder="搜索产品"
        self.barTintColor=UIColor.white
        self.barStyle=UIBarStyle.default
        self.backgroundColor=UIColor.white
        self.tintColor=UIColor.white
        self.setImage(UIImage(named:"whiteSearchIcon"), for: .search, state: .normal)
        
        let search_txt=self.subviews.first?.subviews.last
        search_txt?.backgroundColor=myColor().grayD()
        
        let _placeholder_txt = self.value(forKey: "searchField") as?UITextField
        let _placeholder_label = _placeholder_txt?.value(forKey: "placeholderLabel") as? UILabel
        _placeholder_label?.textColor = UIColor.white
        _placeholder_label?.textAlignment = NSTextAlignment.left
        //_placeholder_label?.font = UIFont.systemFont(ofSize: 30*PX)
        
        
        delegate = self
    }
    
    func style_search_white(){
        self.placeholder="搜索产品"
        self.barTintColor=myColor().grayA9()
        self.barStyle=UIBarStyle.default
        self.backgroundColor=UIColor.clear
        self.tintColor=UIColor.white
        //self.setImage(UIImage(named:"whiteSearchIcon"), for: .search, state: .normal)
        
        let search_txt=self.subviews.first?.subviews.last
        search_txt?.backgroundColor=UIColor.white
        
        let _placeholder_txt = self.value(forKey: "searchField") as?UITextField
        let _placeholder_label = _placeholder_txt?.value(forKey: "placeholderLabel") as? UILabel
        _placeholder_label?.textColor = myColor().grayA9()
        _placeholder_label?.textAlignment = NSTextAlignment.left
        //_placeholder_label?.font = UIFont.systemFont(ofSize: 30*PX)
        
        
        delegate = self
    }
}

class SearchController:UIView{
    func initFrame(){
        self.frame = CGRect(x:0,y:13*PX,width:550*PX,height:60*PX)
        self.layer.cornerRadius = 8*PX
    }
    
    func SeacrchBtn2() ->UIView{
        self.initFrame()

        self.backgroundColor = UIColor.white
        self.layer.backgroundColor = UIColor.white.cgColor
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon2")
        self.addSubview(icon1)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(64*PX, 11*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().grayA9(), 28, "搜索商品")
        self.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:505*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon2")
        self.addSubview(icon2)
        return self
    }
    
    func SeacrchBtn1() ->UIView{
        self.initFrame()
        
        self.backgroundColor = myColor().GrayC6()
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon1")
        self.addSubview(icon1)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(64*PX, 11*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 28, "搜索商品")
        self.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:505*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon1")
        self.addSubview(icon2)
        return self
    }
    
    func SeacrchBtn3() ->UIView{
        self.initFrame()
        self.backgroundColor = myColor().grayD()
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon1")
        self.addSubview(icon1)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(64*PX, 11*PX, 150*PX, 40*PX, NSTextAlignment.left, UIColor.clear, UIColor.white, 28, "搜索商品")
        self.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:505*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon1")
        self.addSubview(icon2)
        
        return self
    }
    func SeacrchBtn4() ->UIView{
        self.initFrame()
        self.backgroundColor = myColor().GrayF1F2F6()
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon3")
        self.addSubview(icon1)
        
        let label:UITextField = UITextField(frame:CGRect(x:64*PX,y:10*PX,width:529*PX,height:40*PX))
        label.placeholder = "搜索产品"
        label.font = UIFont.systemFont(ofSize: 28*PX)
        self.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:505*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon3")
        self.addSubview(icon2)
        
        return self
    }
    
    func SeacrchTitleBtn1(title:String,titleColor:UIColor)->UIView{
        self.initFrame()
        self.backgroundColor = UIColor.clear
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(-30*PX, 12*PX, 130*PX, 37*PX, NSTextAlignment.center, UIColor.clear, titleColor, 30, title)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30*PX)
        self.addSubview(titleLabel)
        
        let uiView:UIView = UIView(frame:CGRect(x:135*PX,y:0,width:415*PX,height:60*PX))
        uiView.backgroundColor = UIColor.white
        self.addSubview(uiView)
        uiView.layer.cornerRadius = 8*PX
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon2")
        uiView.addSubview(icon1)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(65*PX, 10*PX, 356*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().grayA9(), 28, "搜索商品")
        uiView.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:342*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon2")
        uiView.addSubview(icon2)
        return self
    }
    
    func SeacrchTitleBtn2(title:String,titleColor:UIColor)->UIView{
        self.initFrame()
        self.backgroundColor = UIColor.clear
        
        let titleLabel:QZHUILabelView = QZHUILabelView()
        titleLabel.setLabelView(-30*PX, 12*PX, 130*PX, 37*PX, NSTextAlignment.center, UIColor.clear, titleColor, 30, title)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30*PX)
        self.addSubview(titleLabel)
        
        let uiView:UIView = UIView(frame:CGRect(x:135*PX,y:0*PX,width:415*PX,height:60*PX))
        uiView.backgroundColor = myColor().GrayF1F2F6()
        self.addSubview(uiView)
        uiView.layer.cornerRadius = 8*PX
        
        let icon1:UIImageView = UIImageView(frame:CGRect(x:18*PX,y:15*PX,width:30*PX,height:30*PX))
        icon1.image = UIImage(named:"searchIcon2")
        uiView.addSubview(icon1)
        
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(65*PX, 10*PX, 356*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().grayA9(), 28, "搜索商品")
        uiView.addSubview(label)
        
        let icon2:UIImageView = UIImageView(frame:CGRect(x:342*PX,y:10*PX,width:26*PX,height:40*PX))
        icon2.image = UIImage(named:"morcoIcon2")
        uiView.addSubview(icon2)
        
        return self
    }
    
}

// MARK: - 跳转搜索页面的监听方法
extension SearchController{
    func goToSearch(){
        
    }
}
