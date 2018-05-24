//
//  QZHSelAddressViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/20.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHSelAddressViewController: QZHBaseViewController {
    
    // 地址列表视图懒加载
    lazy var addressStatus = QZHAddressListViewModel()
    
    override func loadData() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addressStatus.getAddressList { (isSuccess) in
            if isSuccess{
                self.tabbelView?.reloadData()
            }
        }
    }
}

// MARK: - 页面 UI 样式设置
extension QZHSelAddressViewController{
    override func setupUI() {
        super.setupUI()
        
        self.isPush = true
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHAddressListTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 48*PX
        tabbelView?.height = SCREEN_HEIGHT - 48*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 96*PX
                tabbelView?.height = SCREEN_HEIGHT - 96*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        tabbelView?.separatorStyle = .none
        
        setupNav()
        
        let addBtn:UIButton = UIButton(frame:CGRect(x:0,y:SCREEN_HEIGHT-100*PX,width:SCREEN_WIDTH,height:100*PX))
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                addBtn.y = SCREEN_HEIGHT-168*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        addBtn.setTitle("添加新地址", for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 28*PX)
        addBtn.backgroundColor = myColor().blue007aff()
        addBtn.tintColor = UIColor.white
        addBtn.addTarget(self, action: #selector(self.addAddress), for: .touchUpInside)
        self.view.addSubview(addBtn)
    }
    
    // 设置导航条
    func setupNav(){
        self.title = "选择收货地址"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        navItem.rightBarButtonItem = UIBarButtonItem(title: "管理", img: "", fontSize: 26, target: self, action: #selector(self.manageAction), color: myColor().gray3())
    }

}

// MARK: - 数据源绑定
extension QZHSelAddressViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 181*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHAddressListTableViewCell
        cell.nameLabel.text = self.addressStatus.addressListStatus[indexPath.row].status.personName
        cell.phoneLabel.text = self.addressStatus.addressListStatus[indexPath.row].status.phone
        
        if self.addressStatus.addressListStatus[indexPath.row].status.isDefault == 1{
            cell.addressLabel.text = "[默认地址]\(self.addressStatus.addressListStatus[indexPath.row].status.areaInfo)\(self.addressStatus.addressListStatus[indexPath.row].status.detailedAddress)"
            var myMutableString = NSMutableAttributedString(string:cell.addressLabel.text!)
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:myColor().blue007aff(), range:NSRange(location:0,length:5))
            cell.addressLabel.attributedText = myMutableString
            //cell.addressLabel.setTextColor(cell.addressLabel.text!, textColor: myColor().blue007aff(), oldColor: myColor().blue007aff(), fg: "]")
        }else{
            cell.addressLabel.text = "\(self.addressStatus.addressListStatus[indexPath.row].status.areaInfo)\(self.addressStatus.addressListStatus[indexPath.row].status.detailedAddress)"
        }
        cell.addressLabel.restorationIdentifier = "\(self.addressStatus.addressListStatus[indexPath.row].status.areaInfo)\(self.addressStatus.addressListStatus[indexPath.row].status.detailedAddress)"
        cell.tag = self.addressStatus.addressListStatus[indexPath.row].status.id
        cell.addOnClickLister(target: self, action: #selector(self.checkAddress(_:)))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressStatus.addressListStatus.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 监听方法
extension QZHSelAddressViewController{
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 管理
    func manageAction(){
        let nav = QZHAddressManageViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 新增地址
    func addAddress(){
        let nav = QZHAddAdressViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 选择地址
    func checkAddress(_ sender:UITapGestureRecognizer){
        let this = sender.view as!QZHAddressListTableViewCell
        QZH_CYSQCarSettlementModel.addressId = this.tag
        QZH_CYSQCarSettlementModel.address = "收货地址：\(this.addressLabel.restorationIdentifier!)"
        QZH_CYSQCarSettlementModel.person = "收货人：\(this.nameLabel.text!)"
        QZH_CYSQCarSettlementModel.phone = this.phoneLabel.text!
        QZHOrderDetailModel.addressFlag = true
        dismiss(animated: true, completion: nil)
    }
}
