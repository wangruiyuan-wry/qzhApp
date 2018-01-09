//
//  HeaderController.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import Foundation
import UIKit
class headerController: UINavigationBar,UISearchBarDelegate, UITableViewDelegate{
    var function_All=PublicFunction()
    
    var img_icon=UIImage()
    var own_Self:UIViewController?
    var pageId:String?
    
    //搜索框
    var search:IDSearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clear_bar()
        set_top()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clear_bar()
        set_top()
        
    }
    
    fileprivate func set_top(){
        let widthes=self.bounds.width
        self.frame=CGRect(x:0,y:20,width:widthes,height:44)
        titleTextAttributes=[NSFontAttributeName:UIFont.boldSystemFont(ofSize: PX*36),NSForegroundColorAttributeName:UIColor.white]
        tintColor=UIColor.white
        backgroundColor=myColor().blue4187c2()
        barTintColor=myColor().blue4187c2()
        self.alpha = 1
    }
    
    func setTitle_Only(_ text:NSString){
        set_top()
        let title_page = UINavigationItem()
        title_page.title = text as String
        
        self.pushItem(title_page, animated: true)
    }
    
    func setTitleRight(_ text:NSString){
        set_top()
        let title_page = UINavigationItem()
        title_page.rightBarButtonItem = btn_right_chat()
        title_page.title = text as String
        self.pushItem(title_page, animated: true)
    }
    
    func set_ItemLeft(_ text:NSString,ownSelf:UIViewController){
        set_top()
        own_Self=ownSelf
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_back()
        Item.title=text as String
        self.pushItem(Item, animated: true)
    }
    
    func set_ItemAll(_ text:NSString,ownSelf:UIViewController){
        set_top()
        own_Self=ownSelf
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_back()
        Item.rightBarButtonItem = btn_right_chat()
        Item.title=text as String
        self.pushItem(Item, animated: true)
    }
    
    func set_TowRightItem(_ text:NSString,ownSelf:UIViewController,title:String,img:String,btnId:String){
        own_Self=ownSelf
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_back()
        
        let buttonSpacing=UIBarButtonItem(barButtonSystemItem:.fixedSpace,target:nil,action:nil)
        buttonSpacing.width = 15
        //设置右边边间隙
        let spacer=UIBarButtonItem(barButtonSystemItem:.fixedSpace,target:nil,action:nil)
        spacer.width = -10
        let scdBtn:UIBarButtonItem=UIBarButtonItem(customView:set_RightAnotherButton(title,img:img,btnId: btnId))
        
        Item.rightBarButtonItems=[spacer,btn_right_chat(),buttonSpacing,scdBtn]
        Item.title=text as String
        self.pushItem(Item, animated: true)
    }
    
    func set_RightAnotherButton(_ title:String,img:String,btnId:String)-> UIButton {
        let monthBtn:UIButton=UIButton(frame:CGRect(x:0,y:0,width:20,height:30))
        if img==""{
            monthBtn.setTitle(title, for: .normal)
        }else{
            var img=UIImage(named:img)
            img=img?.specifiesWidth(15)
            monthBtn.setImage(img, for:.normal)
        }
        monthBtn.setTitleColor(UIColor.gray, for: .normal)
        monthBtn.titleLabel?.font=UIFont.init(name: "Zapfino", size: 10)
        monthBtn.restorationIdentifier=btnId
        
        return monthBtn
    }
    
    //清除页头控件
    func clear_bar(){
        self.popItem(animated: true)
    }
    
    //首页及分类页面头部
    func search_index(_ ownSelf:UIViewController){
        own_Self=ownSelf
        let Item=UINavigationItem()
        let width_txt:CGFloat = frame.size.width
        let height_txt:CGFloat = frame.size.height
        
        search = IDSearchBar(frame:CGRect(x:55,y:0,width:width_txt-70,height:height_txt-20))
        search.contentInset=UIEdgeInsets(top:10,left:0,bottom:10,right:0)
        style_search(search)
        
        search.delegate=self
        
        let leftbtn=UIBarButtonItem(customView:search)
        Item.leftBarButtonItem=leftbtn
        
        Item.rightBarButtonItem=btn_right_chat()
        self.pushItem(Item, animated: true)
        initTableView(ownSelf)
        self.initTableView(ownSelf)
    }
    //搜索页历史列表
    var tableView:UITableView!
    func initTableView(_ ownself:UIViewController){
        tableView = UITableView(frame: CGRect(x: 0, y: 65, width: ownself.view.bounds.width, height: ownself.view.bounds.height - 265), style: UITableViewStyle.plain)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        tableView.delegate = self
        tableView.isHidden = true
        tableView.backgroundColor=UIColor.gray
        ownself.view.addSubview(tableView)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        tableView.isHidden = false
    }
    func searchBarSearchButtonClicked(_: UISearchBar){
        tableView.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func search_indexIntegral(_ ownSelf:UIViewController){
        own_Self=ownSelf
        pageId="index"
        let width_txt:CGFloat = frame.size.width
        let height_txt:CGFloat = frame.size.height
        self.backgroundColor=UIColor.clear
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_jump()
        Item.rightBarButtonItem = btn_right_chat()
        let search:IDSearchBar!
        
        search = IDSearchBar(frame:CGRect(x:55,y:0,width:width_txt-70,height:height_txt))
        search.contentInset=UIEdgeInsets(top:10,left:0,bottom:10,right:0)
        style_search(search)
        Item.titleView=search
        self.pushItem(Item, animated: true)
    }
    
/************************************************************************************************************************************/
    //门户首页头部
    func search_blue(_ ownSelf:UIViewController){
        own_Self=ownSelf
        let width_txt:CGFloat = frame.size.width
        let height_txt:CGFloat = frame.size.height
        
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_jump()
        Item.rightBarButtonItem = btn_right_chat()
        let search:IDSearchBar!
        
        search = IDSearchBar(frame:CGRect(x:55,y:0,width:width_txt-70,height:height_txt))
        search.contentInset=UIEdgeInsets(top:10,left:0,bottom:10,right:0)
        style_search(search)
        search.backgroundColor=myColor().blue4187c2()
        Item.titleView=search
        self.pushItem(Item, animated: true)
    }
    
    func set_blue(_ text:NSString,ownSelf:UIViewController){
        set_top()
        own_Self=ownSelf
        let Item=UINavigationItem()
        Item.leftBarButtonItem=left_back()
        Item.rightBarButtonItem = btn_right_chat()
        Item.title=text as String
        self.pushItem(Item, animated: true)
    }
/************************************************************************************************************************************/
    
    func btn_right_chat( )->UIBarButtonItem{
        let img = UIImage(named:"chatIcon")?.specifiesHeight(14)
        let btn=UIButton(frame:CGRect(x:10,y:0,width:20,height:25))
        
        //btn.setTitleColor(UIColor(red:68/255,green:68/255,blue:68/255,alpha:1 ), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font=UIFont.init(name: "Zapfino", size: 6)
        
        btn.set(image: img, title: "消息", titlePosition: .bottom,additionalSpacing: -15, state: .normal)
        btn.imageEdgeInsets=UIEdgeInsetsMake(-5, 2, 0, 2)
        btn.addTarget(self, action:#selector(headerController.btnClick), for: .touchUpInside)
        let right = UIBarButtonItem(customView:btn)
        return right as UIBarButtonItem
        
    }
    
    
    func left_back()->UIBarButtonItem{
        let img_back=UIImage(named:"back_pageIcon")
        let btn=UIButton(frame:CGRect(x:0,y:0,width:25,height:25))
        btn.setImage(img_back, for: .normal)
        btn.addTarget(self, action:#selector(headerController.btn_back), for: .touchUpInside)
        let left_btn = UIBarButtonItem(customView:btn)
        return left_btn as UIBarButtonItem
    }
    
    func left_jump()->UIBarButtonItem{
        let img_back=UIImage(named:"back_pageIcon")
        let btn=UIButton(frame:CGRect(x:0,y:0,width:25,height:25))
        btn.setImage(img_back, for: .normal)
        //btn.addTarget(self, action:#selector(headerController.btnJump), for: .touchUpInside)
        let left_btn = UIBarButtonItem(customView:btn)
        return left_btn as UIBarButtonItem
    }
    
    //搜索页面的头部
    func searchHeader(){
        
    }
    
    func seacrch(_ ownSelf:UIViewController){
        own_Self=ownSelf
        let Item=UINavigationItem()
        let width_txt:CGFloat = frame.size.width
        let height_txt:CGFloat = frame.size.height
        let search:IDSearchBar!
        
        search = IDSearchBar(frame:CGRect(x:55,y:0,width:width_txt-70,height:height_txt-14))
        search.contentInset=UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        style_search(search)
        Item.leftBarButtonItem=left_back()
        let right=UIBarButtonItem(customView:search)
        Item.rightBarButtonItem=right
    }
    
    func style_search(_ selfs:UISearchBar){
        self.backgroundColor=UIColor.white
        selfs.placeholder="搜索产品"
        selfs.barTintColor=UIColor.white
        selfs.barStyle=UIBarStyle.default
        selfs.backgroundColor=UIColor.white
        selfs.tintColor=UIColor.gray
        selfs.isUserInteractionEnabled=true
        
        
        let searchAction=UITapGestureRecognizer(target:self,action:#selector(function_All.toSearchPage))
        self.addGestureRecognizer(searchAction)
        let search_txt=selfs.subviews.first?.subviews.last
        search_txt?.backgroundColor=UIColor.white
        
    }
    func btnClick(){
        function_All.open_Chat(own_Self!)
    }
    func btn_back(){
        function_All.back_page(own_Self!)
    }
    
    func btnJump(){
        function_All.pageJump(own_Self!, toPage: pageId!)
    }
}

//头部搜索栏

class IDSearchBar: UISearchBar,UISearchBarDelegate{
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

