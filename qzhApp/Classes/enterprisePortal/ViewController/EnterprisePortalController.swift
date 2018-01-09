//
//  EnterprisePortalController.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import UIKit
import Foundation
//import RxSwift
//import RxCocoa

class EnterprisePortalViewController: UIViewController,UIViewControllerTransitioningDelegate{

    @IBOutlet weak var header: headerController!
    //var tabView:EnterprisePortalView?=EnterprisePortalView()
    
    var tableView:EnterprisePortalView?=EnterprisePortalView()
    var sortListView:viewControllers=viewControllers()
    var  screeningView:viewControllers=viewControllers()
    var bodyView:srcollView=srcollView()
    var blackBgView:viewControllers=viewControllers()
    var sortBtn:PublicButton=PublicButton()
    let screeningBtn:PublicButton=PublicButton()
    
    struct Varribles {
        static var pageNo:Int = 1
        static var width:CGFloat = 0
        static var height:CGFloat = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        PublicFunction().setStatusbackgroundColor(myColor().blue4187c2())
        EnterprisePortalViewController.width = self.view.frame.width
        EnterprisePortalViewController.height = self.view.frame.height
        
        //let le:EnterprisePortalData=EnterprisePortalData()
        //le.getData(pageNo: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func load(){
        header.search_blue(self)
        //头部选项卡
        let _tab:viewControllers = setTab(topHeight: Int(header.top+header.height))
        self.view.addSubview(_tab)
        
        bodyView.body_Size(y: Int(_tab.y+_tab.height), width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-_tab.y-_tab.height))
        bodyView.contentSize=CGSize(width:SCREEN_WIDTH,height:0)
        bodyView.backgroundColor=UIColor.white
        self.view.addSubview(bodyView)
        
        blackBgView.blackBackground(y: _tab.y+_tab.height, width: SCREEN_WIDTH, height: bodyView.height)
        self.view.addSubview(blackBgView)
        blackBgView.addOnClickLister(target: self, action: #selector(self.bgClick(_:)))
        
        self.setSortListView(topHeight: Int(_tab.y+_tab.height))
        self.view.addSubview(sortListView)
        
        self.setSceenView(topHeight: Int(_tab.y+_tab.height))
        self.view.addSubview(screeningView)
        
        self.getData(pageNo: EnterprisePortalViewController.pageNo)
    }
    //透明背景
    func bgClick(_ sender:viewControllers){
        blackBgView.isHidden=true
        sortListView.isHidden=true
        screeningView.isHidden=true
        self.setGrayTab(sortBtn)
    }
    
    // tab
    func setTab(topHeight:Int)->viewControllers{
        let tabView:viewControllers=viewControllers()
        tabView.setBgViewContent(x: 0, y: topHeight, width: Int(SCREEN_WIDTH), height: Int(PX*70)+1, bgColor: UIColor.white)
        
        let bottomLine:labelView=labelView()
        bottomLine.divider(0, y:Int(PX*70), width: Int(SCREEN_WIDTH), height: 1, color: myColor().grayE())
        tabView.addSubview(bottomLine)
        
        let butonWidth:Int=(Int(SCREEN_WIDTH)-1)/2
        
        sortBtn.frame=CGRect(x:0,y:5,width:butonWidth,height:Int(PX*70)-10)
        sortBtn.setBtnIconAtright(icon: "downIcon", title: "综合排序", color: myColor().Gray6())
        sortBtn.restorationIdentifier="unSel"
        sortBtn.addTarget(self, action: #selector(self.sortClick(_:)), for: .touchUpInside)
        tabView.addSubview(sortBtn)
        
        let middleLine:labelView=labelView()
        middleLine.divider(butonWidth, y: 5, width: 1, height: Int(PX*65)-10, color: myColor().grayE())
        tabView.addSubview(middleLine)
        
        screeningBtn.frame=CGRect(x:butonWidth+1,y:5,width:butonWidth,height:Int(PX*70)-10)
        screeningBtn.restorationIdentifier="unSel"
        screeningBtn.setBtnIconAtright(icon: "downIcon", title: "筛选", color: myColor().Gray6())
        screeningBtn.addTarget(self, action: #selector(self.screeningClick(_:)), for: .touchUpInside)
        tabView.addSubview(screeningBtn)
    
        return tabView
    }
    
    //
    func sortClick(_ sender:PublicButton){
        if sender.restorationIdentifier != "sel"{
            self.setBlueTab(sender)
            blackBgView.isHidden=false
            sortListView.isHidden=false
            screeningView.isHidden=true
        }else{
            self.setGrayTab(sender)
            blackBgView.isHidden=true
            sortListView.isHidden=true
        }
    }
    
    func screeningClick(_ sender:PublicButton){
        if sender.restorationIdentifier != "sel"{
            self.setBlueTab(sender)
            blackBgView.isHidden=false
            screeningView.isHidden=false
            sortListView.isHidden=true
        }else{
            self.setGrayTab(sender)
            blackBgView.isHidden=true
            screeningView.isHidden=true
        }
    }
    
    func setBlueTab(_ sender:PublicButton){
        self.setGrayTab(sender)
        sender.setBtnIconAtright(icon: "upIcon", title: sender.currentTitle!, color: myColor().blue4187c2())
        sender.restorationIdentifier="sel"
    }
    
    func setGrayTab(_ sender:PublicButton){
        let parentView:viewControllers=sender.superview as! viewControllers
        let _tabChildren:[UIView]=parentView.subviews
        for i in 0..<_tabChildren.count{
            if _tabChildren[i].superclass == UIButton.self{
                (_tabChildren[i] as! PublicButton).setBtnIconAtright(icon: "downIcon", title: (_tabChildren[i] as! PublicButton).currentTitle!, color: myColor().Gray6())
                (_tabChildren[i] as! PublicButton).restorationIdentifier="unSel"
            }
        }
    }
    
    //排序列表
    func setSortListView(topHeight:Int){
        let _sortArray:[Dictionary<String,AnyObject>] = [["name":"综合排序" as AnyObject,"nameLogo":"sortByZH" as AnyObject],["name":"按名称排序" as AnyObject,"nameLogo":"sortByName" as AnyObject],["name":"按热度排序" as AnyObject,"nameLogo":"sortByHot" as AnyObject]]
        sortListView.setBgViewContent(x: 0, y: topHeight, width: Int(SCREEN_WIDTH), height: Int(PX*81)*_sortArray.count+2, bgColor: UIColor.white)
        
        for i in 0..<_sortArray.count{
            let sortHeight:Int=Int(PX*80)+1
            let view:viewControllers=viewControllers()//()
            view.setBgViewContent(x: 0, y: i*sortHeight, width: Int(SCREEN_WIDTH), height: Int(PX*80), bgColor: UIColor.white)
            let _sortView:labelView=labelView()
            
            _sortView.setLabelView(Int(PX*40), y: 0, width: Int(SCREEN_WIDTH-PX*80), height: Int(PX*80), align: NSTextAlignment.left, bgColor: UIColor.white, txtColor: myColor().blue4187c2(), text: _sortArray[i]["name"] as! String)
            
            _sortView.setFontSize(size: 28.0)
            view.restorationIdentifier = _sortArray[i]["nameLogo"] as? String
            view.addSubview(_sortView)
            if i != _sortArray.count-1{
                let _line:labelView=labelView()
                _line.divider(Int(PX*40), y: sortHeight*(i+1)-1, width: Int(SCREEN_WIDTH-PX*40), height: 1, color: myColor().grayE())
                _line.restorationIdentifier="line"
                sortListView.addSubview(_line)
            }
            let img:UIImageView=UIImageView()//Int(_sortView.width-PX*(38+40))
            img.frame=CGRect(x:Int(SCREEN_WIDTH-PX*(38+40)),y:Int(PX*28),width:Int(PX*38),height:Int(PX*24))
            img.image=UIImage(named:"hookIcon")
            img.restorationIdentifier="img"
            view.addSubview(img)
            
            if i != 0{
                _sortView.textColor=myColor().gray3()
                img.isHidden=true
            }
            view.addOnClickLister(target: self, action: #selector(self.sortListCilck(_:)))
            sortListView.addSubview(view)
        }
        
        sortListView.isHidden=true
    }
    //排序列表的点击事件
    func sortListCilck(_ sender:AnyObject){
        self.hiddenHook()
        let children:[UIView]=(sender as! UIGestureRecognizer).view!.subviews
        for i in 0..<children.count{
            if children[i].restorationIdentifier == "img"{
                children[i].isHidden=false
            }else{
                (children[i] as! labelView).textColor=myColor().blue4187c2()
                sortBtn.setTitle((children[i] as! labelView).text, for: .normal)
            }
        }
        self.setGrayTab(sortBtn)
        sortListView.isHidden=true
        blackBgView.isHidden=true
    }
    func hiddenHook(){
        let childrenView:[UIView]=sortListView.subviews
        for i in 0..<childrenView.count{
            if childrenView[i].restorationIdentifier != "line"{
                let children:[UIView]=childrenView[i].subviews
                //print(children[i])
                for j in 0..<children.count{
                    if children[j].restorationIdentifier == "img"{
                        children[j].isHidden=true
                    }else{
                        (children[j] as! labelView).textColor=myColor().gray3()
                    }
                }
            }
        }
    }

    //筛选列表
    func setSceenView(topHeight:Int){
        var screeningViewHeight:Int=0
        let _listHeight:Int=Int(PX*80)+1
        //地区
        let _addressView:viewControllers=viewControllers()
        _addressView.setBgViewContent(x: Int(PX*40), y: screeningViewHeight, width:Int(SCREEN_WIDTH-PX*40), height: _listHeight-1, bgColor: UIColor.white)
        _addressView.addSubview(setScreeningTitle(title: "地区",restor:"address"))
        screeningView.addSubview(_addressView)
        screeningViewHeight+=_listHeight

        
        //企业类型
        let _enterpriseView:viewControllers=viewControllers()
        _enterpriseView.setBgViewContent(x: Int(PX*40), y: screeningViewHeight, width:Int(SCREEN_WIDTH-PX*40), height: _listHeight-1, bgColor: UIColor.white)
        _enterpriseView.addSubview(setScreeningTitle(title: "企业类型",restor:"qy"))
        screeningView.addSubview(_enterpriseView)
        screeningViewHeight+=_listHeight

        //一级行业
        let _yjHyView:viewControllers=viewControllers()
        _yjHyView.setBgViewContent(x: Int(PX*40), y: screeningViewHeight, width:Int(SCREEN_WIDTH-PX*40), height: _listHeight-1, bgColor: UIColor.white)
        _yjHyView.addSubview(setScreeningTitle(title: "一级行业",restor:"yjhy"))
        screeningView.addSubview(_yjHyView)
        screeningViewHeight+=_listHeight

        //二级行业
        let _ejHyView:viewControllers=viewControllers()
        _ejHyView.setBgViewContent(x: Int(PX*40), y: screeningViewHeight, width:Int(SCREEN_WIDTH-PX*40), height: _listHeight-1, bgColor: UIColor.white)
        _ejHyView.addSubview(setScreeningTitle(title: "二级行业",restor:"ejhy"))
        screeningView.addSubview(_ejHyView)
        screeningViewHeight+=_listHeight
        
        //确定摁钮
        let determineBtn:PublicButton=PublicButton()
        determineBtn.setBtn(Int(PX*145), y: screeningViewHeight+Int(PX*30), width: Int(PX*180), height: Int(PX*60), bgColor: myColor().blue4187c2(), title: "确定", txtColor: UIColor.white, borderColor: myColor().blue4187c2())
        determineBtn.setTitleSize(30)
        determineBtn.addTarget(self, action: #selector(self.determineClick(_:)), for: .touchUpInside)
        screeningView.addSubview(determineBtn)
        
        //清除摁钮
        let cleanBtn:PublicButton=PublicButton()
        cleanBtn.setBtn(Int(PX*425), y: screeningViewHeight+Int(PX*30), width: Int(PX*180), height: Int(PX*60), bgColor: UIColor.white, title: "清除", txtColor: myColor().blue4187c2(), borderColor: myColor().blue4187c2())
        cleanBtn.setTitleSize(30)
        cleanBtn.addTarget(self, action: #selector(self.cleanClick(_:)), for: .touchUpInside)
        screeningView.addSubview(cleanBtn)
        
        screeningViewHeight+=Int(PX*130)
        screeningView.setBgViewContent(x: 0, y: topHeight, width: Int(SCREEN_WIDTH), height: screeningViewHeight, bgColor: UIColor.white)
        for i in 0..<4{
            let _line:labelView=labelView()
            _line.divider(Int(PX*40), y: _listHeight*(i+1)-1, width: Int(SCREEN_WIDTH-PX*40), height: 1, color: myColor().grayE())
            _line.restorationIdentifier="line"
            screeningView.addSubview(_line)
        }
        screeningView.isHidden=true
    }
    
    func hidddenScreening(){
        self.setGrayTab(sortBtn)
        blackBgView.isHidden=true
        screeningView.isHidden=true
    }
    
    //确定筛选
    func determineClick(_ sender:PublicButton){
        self.hidddenScreening()
    }
    //清除筛选
    func cleanClick(_ sender:PublicButton){
        self.hidddenScreening()
        
    }
    
    //筛选列表部分
    func setScreeningTitle(title:String,restor:String)->viewControllers{
        let listView:viewControllers=viewControllers()
        listView.body_Size(y: 0, width: Int(SCREEN_WIDTH-PX*80), height: Int(PX*80))
        listView.backgroundColor=UIColor.white
        //标题
        let titleLabel:labelView=labelView()
        titleLabel.setLabelView(0, y: 0, width: Int(PX*140), height: Int(PX*80), align: .left, bgColor: UIColor.white, txtColor: myColor().gray3(), text: title)
        titleLabel.setFontSize(size: 28)
        listView.addSubview(titleLabel)
        
        if restor != "address"{
            let contentLabel:labelView=labelView()
            contentLabel.setLabelView(Int(PX*140), y: Int(PX*23), width: Int(PX*200), height: Int(PX*40), align: .left, bgColor: UIColor.white, txtColor: myColor().gray3(), text: "请选择\(title)")
            contentLabel.paddingLeft=PX*10
            contentLabel.paddingRight=PX*10
            contentLabel.setFontSize(size: 24)
            contentLabel.layer.borderWidth=PX*1
            contentLabel.layer.borderColor=myColor().blue4187c2().cgColor
            contentLabel.layer.cornerRadius=PX*5
            
            
            contentLabel.restorationIdentifier=restor
            contentLabel.addOnClickLister(target: self, action: #selector(self.selected(_:)))
            listView.addSubview(contentLabel)

        }else{
            let Arraylist:[String]=["省","市","区"]
            for i in 0..<Arraylist.count{
                let contentLabel:labelView=labelView()
                contentLabel.setLabelView(Int(PX*CGFloat(140+i*180)), y: Int(PX*23), width: Int(PX*140), height: Int(PX*40), align: .left, bgColor: UIColor.white, txtColor: myColor().gray3(), text: "请选择\(Arraylist[i])")
                contentLabel.paddingLeft=PX*10
                contentLabel.paddingRight=PX*10
                contentLabel.setSmallTxtSize()
                contentLabel.layer.borderWidth=PX*1
                contentLabel.layer.borderColor=myColor().blue4187c2().cgColor
                contentLabel.layer.cornerRadius=PX*5
                
                
                contentLabel.restorationIdentifier=restor
                contentLabel.addOnClickLister(target: self, action: #selector(self.selected(_:)))
                listView.addSubview(contentLabel)

            }
        }
        //内容
        
        return listView
    }
    //筛选条件选择
    func selected(_ sender:UITapGestureRecognizer){
        let thisText:String=((sender.view)?.restorationIdentifier)!
        let _thisView:labelView=sender.view as! labelView
        switch thisText {
        case "address":
            PublicFunction().addressAction(self, success:{
                (reponse)->Void in
                var dic:Dictionary<String,AnyObject>=[:]
                for i in 0..<reponse.count{
                    if i == 0{
                       dic=reponse[i] as Dictionary<String,AnyObject>
                    }
                }
                let children:[labelView]=_thisView.superview?.subviews as! [labelView]
                children[1].text=dic["province"] as? String
                EnterprisePortalViewModel.province=(dic["province"] as? String)!
                if dic["area"]as! String == ""{
                    children[2].text=dic["province"] as? String
                    EnterprisePortalViewModel.city=(dic["province"] as? String)!
                    children[3].text=dic["city"] as? String
                    EnterprisePortalViewModel.area=(dic["city"] as? String)!
                }else{
                    children[2].text=dic["city"] as? String
                    EnterprisePortalViewModel.city=(dic["city"] as? String)!
                    children[3].text=dic["area"] as? String
                    EnterprisePortalViewModel.area=(dic["area"] as? String)!
                }
            })
        case "qy":
            PublicFunction().selEnterpriseType(self, success:{
                (reponse)->Void in
                _thisView.text=reponse["result"] as? String
                EnterprisePortalViewModel.EnterpriseType=(reponse["result"] as? String)!
            })
        case "yjhy":
            PublicFunction().selYJHYType(self, success:{
                (reponse)->Void in
                 _thisView.text=reponse["result"] as? String
                EnterprisePortalViewModel.primaryIndustry=(reponse["result"] as? String)!
            })
        case "ejhy":
            PublicFunction().selEJHYType(self, success:{
                (reponse)->Void in
                 _thisView.text=reponse["result"] as? String
                EnterprisePortalViewModel.secondaryIndustry=(reponse["result"] as? String)!
            })
        default:
            break
        }
    }
    
    
    //加载数据
    func getData(pageNo:Int){
        let pageSize:Int=15
        NetworkRequest().getRequest("portal/myStore/enterpriseList", params: ["pageNo"
            :pageNo,"pageSize":pageSize], urlType: 0, success: {
            (reponse)->Void in
            if reponse["status"] as! Int != 200{
                PublicFunction().alertPrompt("数据异常", ownSelf: self)
            }else{
                let data:Dictionary<String,AnyObject>=reponse["data"] as! Dictionary<String, AnyObject>
                
                let _list:[Dictionary<String,AnyObject>] = data["list"] as! [Dictionary<String, AnyObject>]
                var bodyHeight=self.bodyView.contentSize.height
                for i in 0..<_list.count{
                    let thisDic:Dictionary<String,AnyObject>=PublicFunction().setNULLInDIC(_list[i])
                    let companyListView:viewControllers = viewControllers()
                    bodyHeight=CGFloat(companyListView.listCompany(y: Int(bodyHeight), customerDic: thisDic ))
                    companyListView.addOnClickLister(target: self, action: #selector(self.goToDetail(_:)))
                    self.bodyView.addSubview(companyListView)
                    self.bodyView.contentSize=CGSize(width:SCREEN_WIDTH,height:bodyHeight)
                }
               
            }
            
        }, failture: {
            (error)->Void in
            PublicFunction().alertPromptNET(EnterprisePortalViewController.self())
            print("网络错误:\(error)")
        })
    }
    
    //进入详情页
    func goToDetail(_ sender:UIGestureRecognizer){
        let thisView:viewControllers=sender.view as! viewControllers
        if let newVC=self.storyboard?.instantiateViewController(withIdentifier: "CompanyInfo"){
            let vc=newVC as!CompanyInfo
            vc.paramName = thisView.restorationIdentifier!
            vc.paramId = thisView.tag
            self.present(vc, animated: true, completion: nil)
        }
    }
}
