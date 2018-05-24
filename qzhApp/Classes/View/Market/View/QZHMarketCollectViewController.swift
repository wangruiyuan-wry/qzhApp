//
//  QZHMarketCollectViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/4.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHMarketCollectViewController: QZHBaseViewController {
    
    // 已收藏企业列表视图模型懒加载
    lazy var collectList = QZHMarketCollectListViewModel()
    
    let bgView:QZHUIView = QZHUIView()
    
    var viewTab:QZHUIView = QZHUIView()
    
    var sortView:QZHUIView = QZHUIView()
    
    var districtView:QZHArea = QZHArea()
    
    var tradeView:QZHIndustryView = QZHIndustryView()
    
    var typeOfEnterpriseView:QZHUIScrollView = QZHUIScrollView()
    
    //地区字符串拼接
    var areaStr:String = ""
    
    //省／市／区code
    var _proviceCode:String = ""
    var _cityCode:String = ""
    var _countyCode:String = ""
    
    
    //行业字符串拼接
    var industryStr:String? = ""
    
    // 暂无企业
    var noCompany:QZHUIView = QZHUIView()

    
    override func loadData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    func getData(){
        self.collectList.loadCollectList(pullup: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPulup = false
            
            //刷新表/Users/sbxmac/Documents/My Workspace/qzhApp/Podfile格
            if shouldRefresh {
                if self.collectList.collectStatus.count == 0{
                    self.noCompany.isHidden = false
                    self.tabbelView?.isHidden = true
                }else{
                    self.noCompany.isHidden = true
                    self.tabbelView?.isHidden = false
                    self.tabbelView?.reloadData()
                }
                
            }
        }
    }
}

// MARK: - 设置页面 UI 样式
extension QZHMarketCollectViewController{
    override func setupUI() {
        super.setupUI()
        //设置导航栏按钮
        //navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        setupNavTitle()
        
        
        tabbelView?.frame = CGRect(x:0, y: 140*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-232*PX)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.frame = CGRect(x:0, y: 188*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-348*PX)
            }
            
        } else {
            // Fallback on earlier versions
        }
        tabbelView?.separatorStyle = .none
        setupNoCompany()
        //注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHMarketCollectListTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        //设置筛选头部
        setupScreening()
        
        setupBlackBG()
        
        setupAreaView()
        
        setupSortView()
        
        setEnterpriseView()
        
        
    }
    //设置导航栏标题
    func setupNavTitle(){
        self.title = "我的\(QZHMarketCollectModel.collectType)"
    }
    
    // 设置未找到企业
    func setupNoCompany(){
        noCompany.setupViews(x: 0, y: 211*PX, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 211*PX, bgColor: UIColor.white)
        noCompany.isHidden = true
        self.view.addSubview(noCompany)
        
        //
        let pic:UIImageView = UIImageView(frame:CGRect(x:296*PX,y:85*PX,width:158*PX,height:152*PX))
        pic.image = UIImage(named:"Market_noCompany")
        noCompany.addSubview(pic)
        
        let nolabel:QZHUILabelView = QZHUILabelView()
        nolabel.setLabelView(229*PX, 270*PX, 292*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 36, "未找到相关企业")
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                nolabel.y = 318*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        nolabel.alpha = 0.5
        noCompany.addSubview(nolabel)
    }
    
    
    //设置筛选头部
    func setupScreening(){
        
        let tabArray = ["综合排序","不限地区","客户状态"]
        
        viewTab = QZHUIView(frame:CGRect(x:0,y:128*PX+1,width:navigationBar.width,height:80*PX+1))
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                viewTab = QZHUIView(frame:CGRect(x:0,y:176*PX+1,width:navigationBar.width,height:80*PX+1))
            }
            
        } else {
            // Fallback on earlier versions
        }
        viewTab.backgroundColor = myColor().grayF0()
        
        //追加选贤卡内容
        for i in 0..<tabArray.count{
            let tabView:QZHUIView = QZHUIView()
            tabView.setupView(x: Int(250*CGFloat(i)*PX), y: 0, width: Int(250*PX), height: Int(80*PX), bgColor: UIColor.white)
            tabView.addOnClickLister(target: self, action: #selector(screeningClick(_:)))
            tabView.restorationIdentifier = "unSel"
            tabView.tag = i
            
            let label:QZHUILabelView = QZHUILabelView()
            label.setLabelView(0*PX, 22*PX, 170*PX, 38*PX, NSTextAlignment.center, UIColor.clear, myColor().gray9(), 26, tabArray[i])
            label.restorationIdentifier = "title"
            tabView.addSubview(label)
            
            let icon:UIImageView = UIImageView()
            icon.frame = CGRect(x:188*PX,y:35*PX,width:13*PX,height:9*PX)
            icon.image = UIImage(named:"downIcon")
            icon.restorationIdentifier = "icon"
            tabView.addSubview(icon)
            
            viewTab.addSubview(tabView)
        }
        
        //底部分割线
        let divider:QZHUILabelView = QZHUILabelView()
        divider.divider(0, y: Int(80*PX), width: Int(navigationBar.width), height: 1, color: myColor().grayF0())
        divider.restorationIdentifier = "tabLine"
        viewTab.addSubview(divider)
        
        view.addSubview(viewTab)
    }
    
    
    //设置遮罩层
    func setupBlackBG(){
        bgView.blackBackground(y: 210*PX+1, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-210*PX+1)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                bgView.blackBackground(y: 258*PX+1, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-258*PX+1)
            }
            
        } else {
            // Fallback on earlier versions
        }
        bgView.addOnClickLister(target: self, action: #selector(closeTabViews))
        view.addSubview(bgView)
    }
    
    //排序方式列表
    func setupSortView(){
        sortView.setupView(x: 0, y: Int(210*PX+1.0), width: Int(SCREEN_WIDTH), height: Int(184*PX), bgColor: myColor().grayF0())
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                sortView.y = 258*PX + 1.0
            }
            
        } else {
            // Fallback on earlier versions
        }
        sortView.isHidden = true
        view.addSubview(sortView)
        let _sortArray:[String] = ["综合排序" ,"按名称排序","按热度排序"]
        for i in 0..<_sortArray.count{
            if i == 0{
                sortView.addSubview(setupTabListView(y: 62*PX*CGFloat(i), title: _sortArray[i], sel: true, action: #selector(sortListCilck(_:)), tg: i+1))
            }else{
                sortView.addSubview(setupTabListView(y: 62*PX*CGFloat(i), title:_sortArray[i], sel: false, action: #selector(sortListCilck(_:)), tg: i+1))
            }
        }
    }
    
    //设置省市区三级级联
    func setupAreaView(){
        districtView.initFrame(x: 0, y: 210*PX+1.0, width: SCREEN_WIDTH, height: 680*PX, action: #selector(selAreaAction(_:)), ownself: self)
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                districtView.y = 258*PX + 1.0
            }
            
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(districtView)
    }
    
    //设置客户状态
    func setEnterpriseView(){
        let khStatus:[String] = ["潜在","初访","接触中","意向","报价","持续跟进","成交","售后","待定","其它"]
        typeOfEnterpriseView.addSubview(setupTabListView(y: 0, title: "全部", sel: true, action: #selector(enterpriseTypeACtion(_:)),tg:-1))
        var height:CGFloat = 60
        for i in 0..<khStatus.count{
            self.typeOfEnterpriseView.addSubview(self.setupTabListView(y: 62*PX*CGFloat(i)+62*PX, title:khStatus[i], sel: false, action: #selector(self.enterpriseTypeACtion(_:)),tg:i+1))
            height = height + 62
        }
        self.typeOfEnterpriseView.contentSize = CGSize(width:self.typeOfEnterpriseView.width,height:height*PX)
        
        self.typeOfEnterpriseView.setupScrollerView(x: 0, y:210*PX+1.0, width:SCREEN_WIDTH, height: height*PX, background:  myColor().grayF0())
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                typeOfEnterpriseView.y = 258*PX + 1.0
            }
            
        } else {
            // Fallback on earlier versions
        }
        self.typeOfEnterpriseView.backgroundColor = myColor().grayF0()
        self.typeOfEnterpriseView.isHidden = true
        self.view.addSubview(self.typeOfEnterpriseView)
    }
    
    
    //企业类型 排序 列表项样式
    func setupTabListView(y:CGFloat,title:String,sel:Bool,action:Selector,tg:Int)->QZHUIView{
        let listView:QZHUIView = QZHUIView()
        listView.setupView(x: 0, y: Int(y), width: Int(SCREEN_WIDTH), height: Int(60*PX), bgColor: UIColor.white)
        
        let _sortView:labelView=labelView()
        
        _sortView.setLabelView(Int(PX*39), y: 0, width: Int(PX*607), height: Int(PX*60), align: NSTextAlignment.left, bgColor: UIColor.white, txtColor: myColor().blue007aff(), text: title)
        
        _sortView.setFontSize(size: 24.0)
        listView.addSubview(_sortView)
        
        let img:UIImageView=UIImageView()
        img.frame=CGRect(x:Int(646*PX),y:Int(PX*18),width:Int(PX*38),height:Int(PX*24))
        img.image=UIImage(named:"hookIcon")
        img.restorationIdentifier="img"
        listView.addSubview(img)
        
        if !sel{
            _sortView.textColor=myColor().gray3()
            img.isHidden=true
        }
        listView.addOnClickLister(target: self, action: action)
        listView.tag = tg
        return listView
    }

}

// MARK: - 数据源绑定
extension QZHMarketCollectViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectList.collectStatus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 171*PX
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. 取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHMarketCollectListTableViewCell
        
        let companyModel = self.collectList.collectStatus[indexPath.row].status
        
        //2. 设置 cell
        if companyModel.logo != ""{
            if let url = URL(string: companyModel.logo) {
                cell.companyLogo.downloadedFrom(url: url)
            }else{
                cell.companyLogo.image = UIImage(named:"noPic")
            }
        }else{
            cell.companyLogo.image = UIImage(named:"noPic")
        }
        
        cell.companyName.text = companyModel.name
        cell.restorationIdentifier =  companyModel.name
        
        if QZHMarketCollectModel.collectType == "客户"{
            cell.compantPro.text = "主购：\(companyModel.purchasingProduct)"
        }else{
            cell.compantPro.text = "主营：\(companyModel.mainProduct)"
        }
        
        cell.person.text = "联系人：\(companyModel.nickName)"
        
        cell.status.text = ""
        
        cell.tag = companyModel.id
        cell.addOnClickLister(target: self, action: #selector(self.goToCompanyDetail(_:)))
        //3. 返回 cell
        return cell
    }
}

// MARK: - 监听方法
extension QZHMarketCollectViewController{
    //返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    //设置筛选展开
    func screeningClick(_ senders:UITapGestureRecognizer){
        let sender:UIView = senders.view!
        if sender.restorationIdentifier == "unSel" {
            seupTABDefault()
            sender.restorationIdentifier = "sel"
            bgView.isHidden = false
            //sender.backgroundColor = UIColor.clear
            let senderChildren:[UIView] = sender.subviews
            for i in 0..<senderChildren.count{
                if senderChildren[i].restorationIdentifier == "title"{
                    (senderChildren[i] as! QZHUILabelView).textColor = myColor().blue007aff()
                }else{
                    (senderChildren[i] as! UIImageView).image = UIImage(named:"upIcon")
                }
            }
            
            let flag = sender.tag
            // 0 "综合排序"/1 "不限地区"/2  "客户状态""
            switch flag {
            case 0:
                sortView.isHidden = false
                districtView.isHidden = true
                typeOfEnterpriseView.isHidden = true
            case 1:
                sortView.isHidden = true
                districtView.isHidden = false
                typeOfEnterpriseView.isHidden = true
            case 2:
                sortView.isHidden = true
                districtView.isHidden = true
                typeOfEnterpriseView.isHidden = false
                print(typeOfEnterpriseView)
            default:
                break
            }
            
        }else{
            closeTabViews()
        }
    }
    
    //设置头部选项卡默认样式
    func seupTABDefault(){
        let _children: [UIView] = viewTab.subviews
        for i in 0..<_children.count{
            if _children[i].restorationIdentifier != "tabLine"{
                let btn = _children[i] as! QZHUIView
                btn.restorationIdentifier = "unSel"
                btn.backgroundColor = UIColor.white
                let btnChildren:[UIView] = btn.subviews
                for j in 0..<btnChildren.count{
                    if btnChildren[j].restorationIdentifier == "title"{
                        (btnChildren[j] as! QZHUILabelView).textColor = myColor().gray9()
                    }else{
                        (btnChildren[j] as! UIImageView).image = UIImage(named:"downIcon")
                    }
                }
            }
        }
    }
    
    func closeTabViews(){
        bgView.isHidden = true
        sortView.isHidden = true
        districtView.isHidden = true
        typeOfEnterpriseView.isHidden = true
        tradeView.isHidden = true
        
        seupTABDefault()
    }
    
    
    
    func sortListCilck(_ sender:UITapGestureRecognizer){
        let order:Int = ((sender.view)?.tag)!
        QZHMarketCollectModel.comperhensive = order
        getData()
        self.hiddenHook(parentView: sortView)
        let children:[UIView]=(sender as UIGestureRecognizer).view!.subviews
        for i in 0..<children.count{
            if children[i].restorationIdentifier == "img"{
                children[i].isHidden=false
            }else{
                (children[i] as! labelView).textColor=myColor().blue007aff()
                changeTabBtnTitle((children[i] as! labelView).text!)
            }
        }
        self.closeTabViews()
        sortView.isHidden=true
        bgView.isHidden=true
        
    }
    
    func hiddenHook(parentView:UIView){
        let childrenView:[UIView]=parentView.subviews
        for i in 0..<childrenView.count{
            if childrenView[i].restorationIdentifier != "tabLine"{
                let children:[UIView]=childrenView[i].subviews
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
    
    //选中即更改tab按钮标题
    func changeTabBtnTitle(_ title:String){
        let btnArray:[UIView] = viewTab.subviews
        for i in 0..<btnArray.count{
            if btnArray[i].restorationIdentifier != "tabLine"{
                if btnArray[i].restorationIdentifier == "sel"{
                    let btnChildren:[UIView] = btnArray[i].subviews
                    for j in 0..<btnChildren.count{
                        if btnChildren[j].restorationIdentifier == "title"{
                            (btnChildren[j] as! QZHUILabelView).text = title
                        }
                    }
                }
            }
        }
    }
    
    //地区筛选
    func selAreaAction(_ sender:QZHUIButton){
        districtView.setupDefualtBtn(sender)
        sender.setTitleColor(myColor().blue007aff(), for: .normal)
        sender.restorationIdentifier = "sel"
        let parentView = sender.superview
        if parentView?.restorationIdentifier == "province"{
            districtView.removeListOfTag(tag: 1)
            districtView.removeListOfTag(tag: 2)
            areaStr = (sender.titleLabel?.text!)!
            if sender.titleLabel?.text != "不限"{
                districtView.setupCity(#selector(selAreaAction(_:)), parentCode: sender.tag, ownself: self)
                _proviceCode = String(stringInterpolationSegment: sender.tag)
                QZHMarketCollectModel.area = _proviceCode
            }else{
                QZHMarketCollectModel.area = ""
                changeTabBtnTitle("\(areaStr)地区")
                getData()
                closeTabViews()
            }
        }else if parentView?.restorationIdentifier == "city"{
            districtView.removeListOfTag(tag: 2)
            if sender.titleLabel?.text != "全部"{
                areaStr = "\(areaStr)\(String(describing: (sender.titleLabel?.text!)!))"
                districtView.setupCounty(#selector(selAreaAction(_:)), provinceCode: Int.init(_proviceCode)!, cityCode: sender.tag, ownself: self)
                _cityCode = String(stringInterpolationSegment: sender.tag)
                QZHMarketCollectModel.area = _cityCode
            }else{
                changeTabBtnTitle(areaStr)
                getData()
                closeTabViews()
            }
        }else{
            if sender.titleLabel?.text != "全部"{
                areaStr = "\(areaStr)\(String(describing: (sender.titleLabel?.text!)!))"
                _countyCode = String(stringInterpolationSegment: sender.tag)
                QZHMarketCollectModel.area = _countyCode
            }
            changeTabBtnTitle(areaStr)
            getData()
            closeTabViews()
        }
    }
    
    //企业类型选择
    func enterpriseTypeACtion(_ sender:UITapGestureRecognizer){
        var enterpriceType:Int = 0
        self.hiddenHook(parentView: typeOfEnterpriseView)
        let children:[UIView]=(sender as UIGestureRecognizer).view!.subviews
        (sender as UIGestureRecognizer).view?.restorationIdentifier = "sel"
        for i in 0..<children.count{
            if children[i].restorationIdentifier == "img"{
                children[i].isHidden=false
            }else{
                (children[i] as! labelView).textColor=myColor().blue007aff()
                if (children[i] as! labelView).text! == "不限"{
                    changeTabBtnTitle("\((children[i] as! labelView).text!)类型")
                }else{
                    changeTabBtnTitle((children[i] as! labelView).text!)
                    enterpriceType = children[i].tag
                }
            }
        }
        if enterpriceType == -1{
            QZHMarketCollectModel.customerStatus = 0
        }else{
            QZHMarketCollectModel.customerStatus = enterpriceType
        }
        getData()
        self.closeTabViews()
        sortView.isHidden=true
        bgView.isHidden=true
    }
    
    func industryAction(_ sender:QZHUIButton){
        tradeView.setupDefualtBtn(sender)
        sender.tag = 1
        sender.setTitleColor(myColor().blue007aff(), for: .normal)
        
        let parentView:QZHUIScrollView = sender.superview as! QZHUIScrollView
        if parentView.tag == 1{
            tradeView.removeListOfTag(tag: 2)
            QZHEnterprisePortalModel.industryType = sender.restorationIdentifier!
            if sender.titleLabel?.text != "不限"{
                QZHEnterprisePortalModel.superKey = sender.restorationIdentifier!
                tradeView.setupSecond(height: 680*PX, action: #selector(industryAction(_:)), ownself: self)
                industryStr = sender.titleLabel?.text!
            }else{
                changeTabBtnTitle("不限地区")
                getData()
                closeTabViews()
            }
        }else{
            if sender.titleLabel?.text != "全部"{
                QZHEnterprisePortalModel.industryType = sender.restorationIdentifier!
                industryStr = "\(industryStr!)\(sender.titleLabel?.text as! String)"
            }
            changeTabBtnTitle(industryStr!)
            getData()
            closeTabViews()
        }
    }
    
    //进入企业详情
    func goToCompanyDetail(_ sender:UITapGestureRecognizer){
        
        let thisView:QZHMarketCollectListTableViewCell=sender.view as! QZHMarketCollectListTableViewCell
        
        QZHMarketCompanyInfoModel.id = thisView.tag
        QZHMarketCompanyInfoModel.companyName = thisView.restorationIdentifier!
        
        let nav = QZHMarketCollectCompanyDetailViewController()
        present(nav, animated: true, completion: nil)
        
    }
    
}
