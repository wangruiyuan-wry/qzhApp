//
//  QZHAddressManageViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/3/21.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问  QZH_CYSQBaseViewController
private let cellId = "cellId"

class QZHAddressManageViewController: QZHBaseViewController {
    // 地址列表视图懒加载
    lazy var addressStatus = QZHAddressListViewModel()
    
    override func loadData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getList()
    }
    
    func getList(){
        self.addressStatus.getAddressList { (isSuccess) in
            if isSuccess{
                self.tabbelView?.reloadData()
            }
        }
    }
}

// MARK: - 设置页面 UI 样式
extension QZHAddressManageViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        // 注册原型 cell
        tabbelView?.register(UINib(nibName:"QZHAddressManageTableViewCell",bundle:nil), forCellReuseIdentifier: cellId)
        
        tabbelView?.y = 128*PX
        tabbelView?.height = SCREEN_HEIGHT - 228*PX
        tabbelView?.separatorStyle = .none
        
        setupNav()
        
        let addBtn:UIButton = UIButton(frame:CGRect(x:0,y:SCREEN_HEIGHT-100*PX,width:SCREEN_WIDTH,height:100*PX))
        addBtn.setTitle("添加新地址", for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 28*PX)
        addBtn.backgroundColor = myColor().blue007aff()
        addBtn.tintColor = UIColor.white
        addBtn.addTarget(self, action: #selector(self.addAddress), for: .touchUpInside)
        self.view.addSubview(addBtn)
    }
    
    // 设置导航条
    func setupNav(){
        self.title = "管理收货地址"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon2", target: self, action: #selector(self.close),color:UIColor.white)
        navItem.rightBarButtonItem = UIBarButtonItem(title: "完成", img: "", fontSize: 26, target: self, action: #selector(self.close), color: myColor().gray3())
    }
}

// MARK: - 绑定数据源
extension QZHAddressManageViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 231*PX
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QZHAddressManageTableViewCell
        cell.nameLabel.text = self.addressStatus.addressListStatus[indexPath.row].status.personName
        cell.phoneLabel.text = self.addressStatus.addressListStatus[indexPath.row].status.phone
        cell.addressLabel.text = "\(self.addressStatus.addressListStatus[indexPath.row].status.areaInfo)\(self.addressStatus.addressListStatus[indexPath.row].status.detailedAddress)"
        cell.tag = self.addressStatus.addressListStatus[indexPath.row].status.id
        
        if self.addressStatus.addressListStatus[indexPath.row].status.isDefault == 1{
            cell.defaultImg.image = UIImage(named:"CarSel1")
        }else{
            cell.defaultImg.image = UIImage(named:"CarSel")
        }
        cell.defaultBtn.tag = self.addressStatus.addressListStatus[indexPath.row].status.id
        cell.defaultBtn.addOnClickLister(target: self, action: #selector(self.setDefault(_:)))
        
        cell.editBtn.tag = self.addressStatus.addressListStatus[indexPath.row].status.id
        cell.editBtn.addOnClickLister(target: self, action: #selector(self.editAddress(_:)))
        
        cell.delBtn.tag = self.addressStatus.addressListStatus[indexPath.row].status.id
        cell.addOnClickLister(target: self, action: #selector(self.delAddress(_:)))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressStatus.addressListStatus.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 设置监听方法
extension QZHAddressManageViewController{
        
    // 返回
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // 新增地址
    func addAddress(){
        let nav = QZHAddAdressViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 设置为默认地址
    func setDefault(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHAddressModel.addressId = (this?.tag)!
        self.addressStatus.setDefault { (isSuccess, result) in
            UIAlertController.showAlert(message: result, in: self)
            self.getList()
        }
    }
    
    // 编辑地址
    func editAddress(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHAddressModel.addressId = (this?.tag)!
        let nav = QZHEditAddressViewController()
        present(nav, animated: true, completion: nil)
    }
    
    // 删除地址
    func delAddress(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHAddressModel.addressId = (this?.tag)!
        self.addressStatus.delAdress{ (isSuccess, result) in
            UIAlertController.showAlert(message: result, in: self)
            self.getList()
        }
    }
}
