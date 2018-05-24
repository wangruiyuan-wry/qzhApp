//
//  QZHProEvaluationViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/28.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHProEvaluationViewController: QZHBaseViewController {
    // 评价列表视图模型
    lazy var Status = QZHEvaluationListViewModel()
    
    var noList:QZHUIView = QZHUIView()
    
    var ProImg:UIImageView = UIImageView()
    
    var allLabel:QZHUILabelView = QZHUILabelView()
    
    var goodLabel:QZHUILabelView = QZHUILabelView()
    
    var middleLabl:QZHUILabelView = QZHUILabelView()
    
    var badLabel:QZHUILabelView = QZHUILabelView()
    
    var headerView:QZHUIView = QZHUIView()
    
    var openFlag:[Bool] = []
    var cellCount:[Int] = []
    
    override func loadData() {
        self.isPush = true
        self.Status.loadProComment(pullup: self.isPulup) { (isSuccess, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            if isSuccess{
                //恢复上拉刷新标记
                self.isPulup = false
                
                if QZHCommentModel.totalComment > 999{
                    self.allLabel.text = "全部(999+)"
                }else{
                    self.allLabel.text = "全部(\(QZHCommentModel.totalComment))"
                }
                
                if QZHCommentModel.goodComment > 999{
                    self.goodLabel.text = "好评(999+)"
                }else{
                    self.goodLabel.text = "好评(\(QZHCommentModel.goodComment))"
                }
                
                if QZHCommentModel.middleComment > 999{
                    self.middleLabl.text = "中评(999+)"
                }else{
                    self.middleLabl.text = "中评(\(QZHCommentModel.middleComment))"
                }
                
                if QZHCommentModel.badComment > 999{
                    self.badLabel.text = "差评(999+)"
                }else{
                    self.badLabel.text = "差评(\(QZHCommentModel.badComment))"
                }
               
                for i in 0..<self.Status.ProListStatus.count{
                    self.openFlag.append(false)
                    self.cellCount.append(self.Status.ProRepliesStatus[i].count)
                }
                //刷新表
                if shouldRefresh {
                    if self.Status.ProListStatus.count > 0{
                        self.noList.isHidden = true
                        self.tabbelView?.isHidden = false
                        self.tabbelView?.reloadData()
                        
                    }else{
                        self.noList.isHidden = false
                        self.tabbelView?.isHidden = true
                    }
                }
                
                
            }else{
                self.noList.isHidden = false
                self.tabbelView?.isHidden = true
                self.noList.setupNoList(y: 230*PX, str: "数据异常")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isPush = true
        cellCount = []
        loadData()
    }

}

// MARK: - 设置页面UI 样式
extension QZHProEvaluationViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 240*PX
        tabbelView?.height = SCREEN_HEIGHT - 240*PX
        tabbelView?.backgroundColor = UIColor.white
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHProCommentCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        setupNav()
        noList.setupNoList(y: 230*PX, str: "暂无评论")
        self.view.addSubview(noList)
        
        setCommentSort()
    }
    
    // 设置头部导航
    func setupNav(){
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        self.navItem.titleView?.width = 80*PX
        let navImg:UIImageView = UIImageView(frame:CGRect(x:0,y:0,width:80*PX,height:80*PX))
        if let url = URL(string: QZHCommentModel.proImg) {
            navImg.downloadedFrom1(url: url)
        }else{
            navImg.image = UIImage(named:"noPic")
            
        }
        self.navItem.titleView = navImg
        self.navItem.titleView?.width = 80*PX
    }
    
    // 设置评价分类
    func setCommentSort(){
        headerView.setupViews(x: 0, y: 129*PX, width: SCREEN_WIDTH, height: 100*PX, bgColor: UIColor.white)
        self.view.addSubview(headerView)
        let line:QZHUILabelView = QZHUILabelView()
        line.dividers(0, y: 100*PX, width: SCREEN_WIDTH, height: 1*PX, color: myColor().grayEB())
        line.restorationIdentifier = "line"
        headerView.addSubview(line)
        
        allLabel.setLabelView(20*PX, 20*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 24, "全部")
        headerView.addSubview(allLabel)
        allLabel.layer.borderWidth = 1*PX
        allLabel.layer.borderColor = myColor().blue007aff().cgColor
        allLabel.restorationIdentifier = ""
        allLabel.addOnClickLister(target: self, action: #selector(self.check(_:)))
        
        goodLabel.setLabelView(175*PX, 20*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 24, "全部")
        headerView.addSubview(goodLabel)
        goodLabel.layer.borderWidth = 1*PX
        goodLabel.layer.borderColor = myColor().gray3().cgColor
        goodLabel.restorationIdentifier = "good"
        goodLabel.addOnClickLister(target: self, action: #selector(self.check(_:)))
        
        middleLabl.setLabelView(330*PX, 20*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 24, "全部")
        headerView.addSubview(middleLabl)
        middleLabl.layer.borderWidth = 1*PX
        middleLabl.layer.borderColor = myColor().gray3().cgColor
        middleLabl.restorationIdentifier = "middle"
        middleLabl.addOnClickLister(target: self, action: #selector(self.check(_:)))
        
        badLabel.setLabelView(485*PX, 20*PX, 140*PX, 60*PX, NSTextAlignment.center, UIColor.white, myColor().gray3(), 24, "全部")
        headerView.addSubview(badLabel)
        badLabel.layer.borderWidth = 1*PX
        badLabel.layer.borderColor = myColor().gray3().cgColor
        badLabel.restorationIdentifier = "bad"
        badLabel.addOnClickLister(target: self, action: #selector(self.check(_:)))
    }
    
}

// MARK: - 绑定数据源
extension QZHProEvaluationViewController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = 152*PX + self.allLabel.autoLabelHeight(self.Status.ProRepliesStatus[section][0].status.goodsDescripe, font: 24, width: 696*PX)
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.Status.ProListStatus.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:QZHUIView = QZHUIView()
        headerView.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 300*PX, bgColor: UIColor.white)
        let userPhoto:UIImageView = UIImageView(frame:CGRect(x:20*PX,y:20*PX,width:50*PX,height:50*PX))
        userPhoto.layer.cornerRadius = 25*PX
        userPhoto.layer.masksToBounds = true
        let replies = self.Status.ProRepliesStatus[section][0].status
        if replies.avatar == ""{
            userPhoto.image = UIImage(named:"proUserLogo")
        }else{
            if let url = URL(string: replies.avatar) {
                userPhoto.downloadedFrom(url: url)
            }else{
                userPhoto.image = UIImage(named:"proUserLogo")
            }
        }
        headerView.addSubview(userPhoto)
        let sessionId = replies.accountName
        let index = sessionId.index(sessionId.endIndex, offsetBy: -1)
        let suffix = sessionId.substring(from: index)
        
        let indexs = sessionId.index(sessionId.startIndex, offsetBy: 1)
        
        let prefix = sessionId.substring(to: indexs)
        
        let userName:QZHUILabelView = QZHUILabelView()
        userName.setLabelView(100*PX, 30*PX, 185*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, "\(prefix)***\(suffix)")
        headerView.addSubview(userName)
        
        let starNum = Int.init(self.Status.ProListStatus[section].status.goodsComment)
        let starView:QZHUIView = QZHUIView()
        starView.setupViews(x: 551*PX, y: 38*PX, width: 198*PX, height: 25*PX, bgColor: UIColor.clear)
        headerView.addSubview(starView)
        self.setStar(num: starNum, parent: starView)
        
        let time:QZHUILabelView = QZHUILabelView()
        time.setLabelView(20*PX, 90*PX, 600*PX, 28*PX, NSTextAlignment.left, UIColor.clear, myColor().Gray6(), 20, "购买日期：\(self.Status.ProListStatus[section].status.orderTime)")
        headerView.addSubview(time)
        
        let label:QZHUILabelView = QZHUILabelView()
        headerView.addSubview(label)
        label.setLabelView(20*PX, 138*PX, 696*PX, 60*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, replies.goodsDescripe)
        label.numberOfLines = 0
        label.height = label.autoLabelHeight(label.text!, font: 24, width: 696*PX)
        
        let icon:UIImageView = UIImageView(frame:CGRect(x:85*PX,y:label.height + label.y,width:45*PX,height:14*PX))
        icon.image = UIImage(named:"EvaluationInfo_up")
        headerView.addSubview(icon)
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Status.ProListStatus.count > 0{
            if openFlag[section]{
                cellCount[section] = self.Status.ProRepliesStatus[section].count
                return self.Status.ProRepliesStatus[section].count
            }else{
                if self.Status.ProRepliesStatus[section].count > 3{
                    cellCount[section] = 3
                    return 3
                }else{
                    cellCount[section] = self.Status.ProRepliesStatus[section].count
                    return self.Status.ProRepliesStatus[section].count
                }
            }
        }else{
            cellCount[section] = 0
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cellCount[indexPath.section] - 1{
            return 79*PX
        }else{
            let height = 106*PX + self.allLabel.autoLabelHeight(self.Status.ProRepliesStatus[indexPath.section][indexPath.row + 1].status.goodsDescripe, font: 24, width: 673*PX)
            return height
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHProCommentCell
        
        if cellCount[indexPath.section] - 1 == indexPath.row{
            let num = indexPath.section
            cell.CommentView.isHidden = true
            cell.checke.isHidden = false
            cell.checke.addOnClickLister(target: self, action: #selector(self.open(_:)))
            cell.checke.tag = num
            if openFlag[num]{
                cell.checke.text = "收起"
            }else{
                cell.checke.text = "查看全部"
            }
            
        }else{
            cell.CommentView.isHidden = false
            cell.checke.isHidden = true
            let replise = self.Status.ProRepliesStatus[indexPath.section][indexPath.row + 1].status
            
            if replise.avatar == ""{
                cell.userPhoto.image = UIImage(named:"noPic")
            }else{
                if let url = URL(string: replise.avatar) {
                    cell.userPhoto.downloadedFrom(url: url)
                }else{
                    cell.userPhoto.image = UIImage(named:"noPic")
                }
            }
            
            
            if replise.storeName != ""{
                cell.userName.text = replise.storeName
                cell.userName.width = cell.userName.autoLabelWidth(cell.userName.text!, font: 26, height: 38*PX)
                if cell.userName.width > 300*PX{
                    cell.userName.width = 300*PX
                    cell.userName.lineBreakMode = .byTruncatingTail
                }
                cell.flag.x = cell.userName.x + cell.userName.width + 9*PX
                cell.flag.text = "店家"
                cell.flag.backgroundColor = myColor().blue007aff()
                cell.flag.textColor = UIColor.white
            }else{
                let sessionId = replise.accountName
                let index = sessionId.index(sessionId.endIndex, offsetBy: -1)
                let suffix = sessionId.substring(from: index)
                
                let indexs = sessionId.index(sessionId.startIndex, offsetBy: 1)
                
                let prefix = sessionId.substring(to: indexs)
                
                cell.userName.text = "\(prefix)***\(suffix)"
                cell.userName.width = cell.userName.autoLabelWidth(cell.userName.text!, font: 26, height: 38*PX)
                if cell.userName.width > 250*PX{
                    cell.userName.width = 250*PX
                    cell.userName.lineBreakMode = .byTruncatingTail
                }
                cell.flag.x = cell.userName.x + cell.userName.width + 9*PX
            }
            cell.time.text = replise.createTime
            
            cell.commentLabel.text = replise.goodsDescripe
            cell.commentLabel.height = cell.commentLabel.autoLabelHeight(cell.commentLabel.text!, font: 25, width: 673*PX)
            cell.commentLabel.numberOfLines = 0
        }
        
        return cell
    }

    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //组头高度
        let sectionHeaderHeight:CGFloat = 80*PX
        //组尾高度
        let sectionFooterHeight:CGFloat = 20*PX
        
        //获取是否有默认调整的内边距
        let defaultEdgeTop:CGFloat = navigationController?.navigationBar != nil
            && self.automaticallyAdjustsScrollViewInsets ? 64 : 0
        
        //上边距相关
        var edgeTop = defaultEdgeTop
        if scrollView.contentOffset.y >= -defaultEdgeTop &&
            scrollView.contentOffset.y <= sectionHeaderHeight - defaultEdgeTop  {
            edgeTop = -scrollView.contentOffset.y
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight - defaultEdgeTop) {
            edgeTop = -sectionHeaderHeight + defaultEdgeTop
        }
        
        //下边距相关
        var edgeBottom:CGFloat = 20*PX
        let b = scrollView.contentOffset.y + scrollView.frame.height
        let h = scrollView.contentSize.height - sectionFooterHeight
        
        if b <= h {
            edgeBottom = -30
        }else if b > h && b < scrollView.contentSize.height {
            edgeBottom = b - h - 30
        }
        
        //设置内边距
        scrollView.contentInset = UIEdgeInsetsMake(edgeTop, 0, edgeBottom, 0)
    }*/

}

// MARK: - 设置监听方法
extension QZHProEvaluationViewController{
    // 评价
    func setStar(num:Int,parent:QZHUIView){
        let left:CGFloat = 38*PX
        for i in 0..<5{
            let star:UIImageView = UIImageView(frame:CGRect(x:left*CGFloat(i),y:8,width:24*PX,height:25*PX))
            if num > i{
                star.image = UIImage(named:"star")
            }else{
                star.image = UIImage(named:"star1")
            }
            parent.addSubview(star)
        }
    }
    
    // 后退
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 消息中心
    func showFriends(){
        let vc = QZHDemoViewController()
        // navigationController?.pushViewController(vc, animated: true)
    }
    
    // 筛选评价
    func check(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHCommentModel.status = this.restorationIdentifier!
        
        let children:[QZHUILabelView] = headerView.subviews as! [QZHUILabelView]
        for child in children{
            if child.restorationIdentifier != "line"{
                if child.restorationIdentifier == this.restorationIdentifier{
                    child.layer.borderColor = myColor().blue007aff().cgColor
                    child.textColor = myColor().blue007aff()
                }else{
                    child.layer.borderColor = myColor().gray3().cgColor
                    child.textColor = myColor().gray3()
                }
            }
        }
        cellCount = []
        loadData()
    }
    
    func open(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        if openFlag[this.tag]{
            openFlag[this.tag] = false
        }else{
            openFlag[this.tag] = true
        }
        self.tabbelView?.reloadData()
    }
}
