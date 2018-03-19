//
//  QZHStoreSearchViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/6.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHStoreSearchViewController: QZHBaseViewController {
    
    // 历史搜索列表
    let history:QZHUIScrollView = QZHUIScrollView()
    
    // 搜索
    let btn:SearchController = SearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - 页面 UI设置
extension QZHStoreSearchViewController{
    override func setupUI() {
        super.setupUI()
        
        self.tabbelView?.isHidden = true
        //设置导航栏按钮
        setupNavTitle()
        
        //注册原型 cell
        self.tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tabbelView?.isHidden = true
        
        
        history.setupScrollerView(x: 0, y: 186*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-186*PX, background: UIColor.white)
        self.view.addSubview(history)
        
        
        
        setupTitleLabel()
        setupLabelItem()

    }
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
    
        navItem.rightBarButtonItem = UIBarButtonItem(title: "搜本店", img: "", target: self, action: #selector(search))
        
        navItem.titleView?.width = 550*PX
        navItem.titleView?.y = 70*PX
        
        navItem.titleView = btn.SeacrchBtn5()
        
    }
    
    // title标签
    func setupTitleLabel(){
        let label:QZHUILabelView = QZHUILabelView()
        label.setLabelView(20*PX, 158*PX, 150*PX, 37*PX, NSTextAlignment.left, UIColor.white,myColor().gray3(), 26, "历史搜索")
        view.addSubview(label)
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:683*PX,y:155*PX,width:30*PX,height:30*PX))
        icon.image = UIImage(named:"trashIcon")
        icon.addOnClickLister(target: self, action: #selector(self.clanerHistory))
        view.addSubview(icon)
    }
    
    // 标签
    func setupLabelItem(){
        let chilrenviews = self.history.subviews
        
        for chilren in chilrenviews {
            
            chilren.removeFromSuperview()
            
        }

        var _cache:[String:AnyObject] = CacheFunc().getCahceData(fileName: "searchHistoryText.plist", folderName: "Store") as! [String : AnyObject]
        var _array:[String] = []
        // 判断字典是否为空
        if !_cache.isEmpty{
            _array = _cache["history"] as! [String]
        }
        
        var paddingLeft = 0*PX
        var paddingTop = 20*PX
        
        for i in _array{
            
            let labelItem:QZHUILabelView = QZHUILabelView()
            labelItem.layer.cornerRadius = 8*PX
            labelItem.clipsToBounds = true
            let widthLabel = labelItem.autoLabelWidth(i, font: 25, height: 60*PX)+62*PX
            let padding:[String:AnyObject] = getPaddingleft(paddingLeft, widthLabel, y: paddingTop)
            paddingLeft = padding["x"] as! CGFloat
            paddingTop = padding["y"] as! CGFloat
            labelItem.setLabelView(paddingLeft, paddingTop, widthLabel, 60*PX, NSTextAlignment.center, myColor().GrayF1F2F6(), myColor().gray4(), 24, i)
            paddingLeft = paddingLeft + widthLabel
            history.contentSize = CGSize(width:history.width,height:labelItem.y+labelItem.height)
            labelItem.addOnClickLister(target: self, action: #selector(self.searchHistory(_:)))
            history.addSubview(labelItem)
        }
    }
    
    // 获取下一个标签 paddingLeft
    func getPaddingleft(_ x:CGFloat,_ width:CGFloat,y:CGFloat)->[String:AnyObject]{
        var padding:[String:AnyObject] = [:]
        
        if (x+width+20*PX) > SCREEN_WIDTH{
            padding = ["x":20*PX as AnyObject,"y":y+80*PX as AnyObject]
        }else{
            padding = ["x":x+20*PX as AnyObject,"y":y as AnyObject]
        }
        
        return padding
    }

}

// MARK: - 监听方法
extension QZHStoreSearchViewController{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 清空历史记录
    func clanerHistory(){
        var _array:[String] = []
        var _cache:Dictionary<String,AnyObject> = CacheFunc().getCahceData(fileName: "searchHistoryText.plist", folderName: "Store")
        _cache.updateValue(_array as AnyObject, forKey: "history")
        CacheFunc().setCahceData(fileName: "searchHistoryText.plist", folderName: "Store", cacheDatas: _cache as NSDictionary)
        setupLabelItem()
    }
    
    // 搜索
    func search(){
        var _cache:Dictionary<String,AnyObject> = CacheFunc().getCahceData(fileName: "searchHistoryText.plist", folderName: "Store")
        let textStr:String = (btn.viewWithTag(1)as! UITextField).text!
        var _array:[String] = []
        var _oldArray:[String] = []
        // 判断字典是否为空
        if !_cache.isEmpty{
           _oldArray = _cache["history"] as! [String]
        }
        if textStr.trimmingCharacters(in: .whitespaces) != ""{
            _array.append(textStr)
            for i in 0..<_oldArray.count{
                if textStr != _oldArray[i] {
                    _array.append(_oldArray[i])
                }
            }
        }
        _cache.updateValue(_array as AnyObject, forKey: "history")
        CacheFunc().setCahceData(fileName: "searchHistoryText.plist", folderName: "Store", cacheDatas: _cache as NSDictionary)
        QZHStoreProModel.q = textStr.trimmingCharacters(in: .whitespaces)
        QZHStoreSearchProModel.fromPage = 0
        
        let nav = QZHStore_SearchList_ViewController()
        present(nav, animated: true, completion: nil)
    }
    func searchHistory(_ sender:UITapGestureRecognizer){
        let this:QZHUILabelView = sender.view as! QZHUILabelView
        
        var _cache:Dictionary<String,AnyObject> = CacheFunc().getCahceData(fileName: "searchHistoryText.plist", folderName: "Store")
        let textStr:String = this.text!
        var _array:[String] = []
        var _oldArray:[String] = []
        // 判断字典是否为空
        if !_cache.isEmpty{
            _oldArray = _cache["history"] as! [String]
        }
        if textStr.trimmingCharacters(in: .whitespaces) != ""{
            _array.append(textStr)
            for i in 0..<_oldArray.count{
                if textStr != _oldArray[i] {
                    _array.append(_oldArray[i])
                }
            }
        }
        _cache.updateValue(_array as AnyObject, forKey: "history")
        CacheFunc().setCahceData(fileName: "searchHistoryText.plist", folderName: "Store", cacheDatas: _cache as NSDictionary)
        QZHStoreProModel.q = textStr.trimmingCharacters(in: .whitespaces)
        let nav = QZHStore_SearchList_ViewController()
        present(nav, animated: true, completion: nil)
    }
}
