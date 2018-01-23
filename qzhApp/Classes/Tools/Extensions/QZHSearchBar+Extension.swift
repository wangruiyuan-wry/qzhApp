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
