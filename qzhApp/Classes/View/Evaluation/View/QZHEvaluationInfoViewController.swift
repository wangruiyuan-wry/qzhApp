//
//  QZHEvaluationInfoViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/4/27.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHEvaluationInfoViewController: QZHBaseViewController {
    
    // 评价详情视图列表懒加载
    lazy var Status = QZHEvaluationListViewModel()
    
    // 用户头像
    var userPhoto:UIImageView = UIImageView()
    
    // 用户名称
    var userName:QZHUILabelView = QZHUILabelView()
    
    // 评分
    var starView:QZHUIView = QZHUIView()
    
    // 时间 规格
    var timeSpecLabel:QZHUILabelView = QZHUILabelView()
    
    // 评价内容
    var commentLabel:QZHUILabelView = QZHUILabelView()
    
    // 产品图片
    var proImg:UIImageView = UIImageView()
    
    // 产品名称
    var proName:QZHUILabelView = QZHUILabelView()
    
    // 产品价格
    var proPrice:QZHUILabelView = QZHUILabelView()
    var noList:QZHUIView = QZHUIView()
    
    var openFlag:Bool = false
    
    var cellCount:Int = 0
    
    override func loadData() {
        self.Status.loadInfo { (isSuccess) in
            if isSuccess{
                self.tabbelView?.isHidden = false
                self.tabbelView?.reloadData()
                self.noList.isHidden = true
                let info = self.Status.infoStatus[0].status
                let replies = self.Status.infoRepliesStatus[0][0].status
                self.setHeader(img: replies.avatar, name: replies.accountName, star: info.goodsComment, time: replies.createTime, spec: info.goodsSpec, comment: replies.goodsDescripe,flag:true)
                self.setPro(img: info.goodsPic, name: info.goodsName, price: "\(info.goodsPrice.roundTo(places: 2))", id: info.goodsId, _id: info._id)
                
            }else{
                self.tabbelView?.isHidden = true
                self.noList.isHidden = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isPush = true
        loadData()
    }
}

// MARK: - 设置页面UI样式
extension QZHEvaluationInfoViewController{
    override func setupUI() {
        super.setupUI()
        
        tabbelView?.separatorStyle = .none
        tabbelView?.y = 129*PX
        tabbelView?.height = SCREEN_HEIGHT - 129*PX
        tabbelView?.backgroundColor = UIColor.white
        //注册 tableView
        tabbelView?.register(UINib(nibName:"QZHEvalustionInfoCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        //设置estimatedRowHeight属性默认值
        self.tabbelView?.estimatedRowHeight = 79*PX;
        //rowHeight属性设置为UITableViewAutomaticDimension
        self.tabbelView?.rowHeight = UITableViewAutomaticDimension;
        
        self.view.backgroundColor = myColor().grayF0()
        self.tabbelView?.isHidden = true
        self.noList.isHidden = false
        setupNav()
    }
    
    // 设置头部导航
    func setupNav(){
        self.title  = "评价详情"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        
        noList.setupNoList(y: 129*PX, str: "此评论详情出错")
        self.view.addSubview(noList)
    }
    
    // 设置表头
    func setHeader(img:String,name:String,star:Int,time:String,spec:String,comment:String,flag:Bool){
        let body:QZHUIView = QZHUIView()//
        userPhoto.frame = CGRect(x:20*PX,y:20*PX,width:60*PX,height:60*PX)
        userPhoto.layer.cornerRadius = 30*PX
        userPhoto.layer.masksToBounds = true
        if img == ""{
            userPhoto.image = UIImage(named:"noHeader")
        }else{
            if let url = URL(string: img) {
                userPhoto.downloadedFrom(url: url)
            }else{
                userPhoto.image = UIImage(named:"noHeader")
            }
        }
        body.addSubview(userPhoto)
        
        userName.setLabelView(100*PX, 30*PX, 375*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28,  name)
        body.addSubview(userName)
        
        starView.setupViews(x: 550*PX, y: 36*PX, width: 180*PX, height: 28*PX, bgColor: UIColor.clear)
        setStar(star)
        body.addSubview(starView)
        
        timeSpecLabel.setLabelView(20*PX, 90*PX, 710*PX, 34*PX, NSTextAlignment.left, UIColor.clear, myColor().gray9(), 24, "\(time.components(separatedBy: " ")[0])   产品规格\(spec)")
        timeSpecLabel.numberOfLines = 0
        timeSpecLabel.height = timeSpecLabel.autoLabelHeight(timeSpecLabel.text!, font: 24, width: 710*PX)
        body.addSubview(timeSpecLabel)
        
        commentLabel.setLabelView(20*PX, timeSpecLabel.y + timeSpecLabel.height, 710*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, comment)
        commentLabel.numberOfLines = 0
        commentLabel.height = commentLabel.autoLabelHeight(commentLabel.text!, font: 28, width: 710*PX)
        body.addSubview(commentLabel)
        if flag{
            let icon:UIImageView = UIImageView(frame:CGRect(x:80*PX,y:commentLabel.height + commentLabel.y,width:42*PX,height:15*PX))
            icon.image = UIImage(named:"EvaluationInfo_up")
            body.addSubview(icon)
        
            body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: icon.y + icon.height, bgColor: UIColor.white)
        }else{
            body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: commentLabel.y + commentLabel.height, bgColor: UIColor.white)
        }
        tabbelView?.tableHeaderView = body
    }
    
    // 评分
    func setStar(_ num:Int){
        let left:CGFloat = 38*PX
        for i in 0..<5{
            let star:UIImageView = UIImageView(frame:CGRect(x:left*CGFloat(i),y:0,width:28*PX,height:28*PX))
            if num > i{
                star.image = UIImage(named:"star")
            }else{
                star.image = UIImage(named:"star1")
            }
            starView.addSubview(star)
        }
    }
    
    // 设置产品信息
    func setPro(img:String,name:String,price:String,id:Int,_id:String){
        let foot:QZHUIView = QZHUIView()
        foot.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 273*PX, bgColor: UIColor.white)
        tabbelView?.tableFooterView = foot
        
        let proView:QZHUIView = QZHUIView()
        proView.setupViews(x: 20*PX, y: 20*PX, width: 710*PX, height: 164*PX, bgColor: myColor().grayF9())
        proView.tag = id
        proView.addOnClickLister(target: self, action: #selector(self.proDetail(_:)))
        foot.addSubview(proView)
        
        proImg.frame = CGRect(x:2*PX,y:2*PX,width:160*PX,height:160*PX)
        if img == ""{
            proImg.image = UIImage(named:"noPic")
        }else{
            if let url = URL(string: img) {
                proImg.downloadedFrom(url: url)
            }else{
                proImg.image = UIImage(named:"noPic")
            }
        }
        proView.addSubview(proImg)
        
        proName.setLabelView(180*PX, 5*PX, 496*PX, 70*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 24, name)
        proName.numberOfLines = 2
        proName.lineBreakMode = .byTruncatingTail
        proView.addSubview(proName)
        
        let icon:QZHUILabelView = QZHUILabelView()
        icon.setLabelView(180*PX, 123*PX, 18*PX, 30*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 20, "¥")
        proView.addSubview(icon)
        
        proPrice.setLabelView(198*PX, 115*PX, 400*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, price)
        proPrice.setRealWages(proPrice.text!, big: 28, small: 20, fg: ".")
        proView.addSubview(proPrice)
        
        
        let add:QZHUILabelView = QZHUILabelView()
        add.setLabelView(630*PX, 204*PX, 98*PX, 50*PX, NSTextAlignment.center, UIColor.white, myColor().blue007aff(), 24, "写追评")
        add.layer.borderColor = myColor().blue007aff().cgColor
        add.layer.borderWidth = 1*PX
        add.restorationIdentifier = _id
        add.addOnClickLister(target: self, action: #selector(self.add(_:)))
        foot.addSubview(add)
    }
}

// MARK: - 绑定数据源
extension QZHEvaluationInfoViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Status.infoStatus.count > 0{
            if openFlag{
                cellCount = self.Status.infoRepliesStatus[0].count
                return self.Status.infoRepliesStatus[0].count
                
            }else{
                if self.Status.infoRepliesStatus[0].count > 4{
                    cellCount = 4
                    return 4
                }else{
                    cellCount = self.Status.infoRepliesStatus[0].count
                    return self.Status.infoRepliesStatus[0].count
                }
            }
        }else{
            cellCount = 0
            return 0
        }
        
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cellCount - 1{
            return 50*PX
        }else{
            var height = self.commentLabel.autoLabelHeight(self.Status.infoRepliesStatus[0][indexPath.row+1].status.goodsDescripe, font: 24, width: 673*PX)
            return height + 106*PX
        }
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHEvalustionInfoCell
        if indexPath.row != cellCount - 1{
            let list = self.Status.infoRepliesStatus[0][indexPath.row+1].status
            cell.btn.isHidden = true
            cell.listView.isHidden = false
            
            if list.avatar == ""{
                cell.img.image = UIImage(named:"noPic")
            }else{
                if let url = URL(string: list.avatar) {
                    cell.img.downloadedFrom(url: url)
                }else{
                    cell.img.image = UIImage(named:"noPic")
                }
            }
            
            
            if list.storeName != ""{
                cell.name.text = list.storeName
                cell.name.width = cell.name.autoLabelWidth(cell.name.text!, font: 26, height: 38*PX)
                if cell.name.width > 300*PX{
                    cell.name.width = 300*PX
                    cell.name.lineBreakMode = .byTruncatingTail
                }
                cell.which.x = cell.name.x + cell.name.width + 9*PX
                cell.which.text = "店家"
                cell.which.backgroundColor = myColor().blue007aff()
                cell.which.textColor = UIColor.white
            }else{
                cell.name.text = list.accountName
                cell.name.width = cell.name.autoLabelWidth(cell.name.text!, font: 26, height: 38*PX)
                if cell.name.width > 340*PX{
                    cell.name.width = 340*PX
                    cell.name.lineBreakMode = .byTruncatingTail
                }
                cell.which.x = cell.name.x + cell.name.width + 9*PX
            }
            cell.createTime.text = list.createTime
            
            cell.content.text = list.goodsDescripe
        }else{
            cell.listView.isHidden = true
            cell.btn.isHidden = false
            if cellCount == 1{
                cell.btn.text = "暂无回复"
            }else{
                if openFlag{
                    cell.btn.text = "收起"
                }else{
                    cell.btn.text = "查看全部"
                }
                cell.btn.addOnClickLister(target: self, action: #selector(self.openOrClose))
            }
        }
        
        return cell
    }

}

// MARK: - 设置监听方法
extension QZHEvaluationInfoViewController{
    // 后退
    func close(){
        dismiss(animated: true, completion: nil)
    }

    // 消息中心
    func showFriends(){
        let vc = QZHDemoViewController()
        // navigationController?.pushViewController(vc, animated: true)
    }
    // 追加评价
    func add(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHEvaluationInfoModel._id = this.restorationIdentifier!
        QZHCommentModel._id = this.restorationIdentifier!
        let nav = QZHAddComentViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 产品详情
    func proDetail(_ sender:UITapGestureRecognizer){
        let this:UIView = sender.view!
        QZHProductDetailModel.goodsId = this.tag
        let nav = QZHProductDetailViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 查看全部／收起
    func openOrClose(){
        if openFlag{
            openFlag = false
        }else{
            openFlag = true
        }
        tabbelView?.reloadData()
    }
}
