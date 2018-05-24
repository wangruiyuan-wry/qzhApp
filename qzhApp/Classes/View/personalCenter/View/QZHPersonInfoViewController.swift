//
//  QZHPersonInfoViewController.swift
//  千纸鹤SCEO
//
//  Created by sbxmac on 2018/4/13.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

/// 定义全局常量,尽量使用 private 修饰，否则哪儿都可以访问
private let cellId = "cellId"

class QZHPersonInfoViewController: QZHBaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate {
    // 个人信息视图模型懒加载
    lazy var userInfo = QZHPersonalCenterMyViewModel()
    
    // 头像
    var photo:UIImageView = UIImageView()
    
    // 账号
    var accountLabel:QZHUILabelView = QZHUILabelView()
    
    // 昵称
    var nikeName:QZHUILabelView = QZHUILabelView()
    
    // 真是名称
    var name:QZHUILabelView = QZHUILabelView()
    
    // 公司名称
    var compayName:QZHUILabelView = QZHUILabelView()
    
    // 联系电话
    var phone:QZHUILabelView = QZHUILabelView()
    
    // 页面
    var body:QZHUIView = QZHUIView()

    override func loadData() {
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
        
    }
    
    func getData(){
        self.userInfo.getMyInfo { (isSuccess,isLogin, shouldRefresh) in
            //结束刷新控件
            self.refreahController?.endRefreshing()
            let person = self.userInfo.personInfo[0].status
            if person.headPortrait == ""{
                self.photo.image = UIImage(named:"noHeader")
            }else{
                if let url = URL(string: person.headPortrait) {
                    self.photo.downloadedFrom(url: url)
                }else{
                    self.photo.image = UIImage(named:"noHeader")
                }
            }
            
            self.accountLabel.text = person.name
            self.nikeName.text = person.nikeName
            self.name.text = person.realName
            self.compayName.text = person.companyName
            self.phone.text = person.phone
            self.tabbelView?.reloadData()
            
            
            //刷新表/Users/sbxmac/Documents/My Workspace/qzhApp/Podfile格
            if shouldRefresh {

                self.tabbelView?.reloadData()
                
            }

        }
    }
    
}

// MARK: - 设置页面 UI 样式
extension QZHPersonInfoViewController{
    override func setupUI() {
        super.setupUI()
        self.isPush = true
        
        
        tabbelView?.separatorStyle = .none
        tabbelView?.backgroundColor = myColor().grayF0()
        //注册原型 cell
        tabbelView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tabbelView?.y = 128*PX
        if #available(iOS 11.0, *) {
            if UIDevice().isX(){
                tabbelView?.y = 176*PX
            }
            
        } else {
            // Fallback on earlier versions
        }
        setupNavTitle()
        setupBody()
        
        body.setupViews(x: 0, y: 0, width: SCREEN_WIDTH, height: 526*PX, bgColor: UIColor.clear)
        tabbelView?.tableHeaderView = body
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        setStatusBarBackgroundColor(color: .white)
    }
    
    // 设置头部导航栏
    func setupNavTitle(){
        navItem.rightBarButtonItem = UIBarButtonItem(title: "", img: "chatIcon1", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(self.close))
        
        self.title = "个人信息"
    }
    
    // 设置页面内容区
    func setupBody(){
        var top:CGFloat = 0
        // 头像
        let photoView:QZHUIView = QZHUIView()
        top = self.setList(y: top, height: 120*PX, parentView: photoView, titleStr: "头像", thisView: phone, imgView: photo, imgViewFlag: true, labelStr: "")
        photoView.addOnClickLister(target: self, action: #selector(self.fromAlbum(_:)))
        
        // 账号
        let accountView:QZHUIView = QZHUIView()
        top = self.setList(y: top, parentView: accountView, titleStr: "账号", thisView: accountLabel, imgView: photo,  labelStr: "",rightFlag: false)
        
        // 昵称
        let nikeNameView:QZHUIView = QZHUIView()
        top = self.setList(y: top, parentView: nikeNameView, titleStr: "昵称", thisView: nikeName, imgView: photo, labelStr: "")
        nikeNameView.addOnClickLister(target: self, action: #selector(self.editInfo(_:)))
        
        // 真实姓名
        let nameView:QZHUIView = QZHUIView()
        top = self.setList(y: top, parentView: nameView, titleStr: "真实姓名", thisView: name, imgView: photo, labelStr: "")
        nameView.addOnClickLister(target: self, action: #selector(self.editInfo(_:)))
        
        // 公司名
        let companyNameView:QZHUIView = QZHUIView()
        top = self.setList(y: top, parentView: companyNameView, titleStr: "公司名", thisView: compayName, imgView: photo, labelStr: "", rightFlag: false)
        
        // 联系电话
        let phoneView:QZHUIView = QZHUIView()
        top = self.setList(y: top, parentView: phoneView, titleStr: "联系电话", thisView: phone, imgView: photo, labelStr: "")
        phoneView.addOnClickLister(target: self, action: #selector(self.editInfo(_:)))
    }
    
    // 设置每行的样式
    func setList(y:CGFloat,height:CGFloat = 80*PX,parentView:QZHUIView,titleStr:String,thisView:QZHUILabelView,imgView:UIImageView,imgViewFlag:Bool = false,labelStr:String,rightFlag:Bool = true)->CGFloat{
        var top:CGFloat = y
        parentView.setupViews(x: 0, y: y, width: SCREEN_WIDTH, height: height, bgColor: UIColor.white)
        parentView.restorationIdentifier = titleStr
        body.addSubview(parentView)
        
        let right:UIImageView = UIImageView(frame:CGRect(x:708*PX,y:(height - 24*PX)/2,width:14*PX,height:24*PX))
        right.image = UIImage(named:"rightIcon")
        if rightFlag{
            parentView.addSubview(right)
        }
        
        let title:QZHUILabelView = QZHUILabelView()
        title.setLabelView(20*PX, (height - 40*PX)/2, 130*PX, 40*PX, NSTextAlignment.left, UIColor.clear, myColor().gray3(), 28, titleStr)
        parentView.addSubview(title)
        
        if imgViewFlag{
            imgView.frame = CGRect(x:600*PX,y:15*PX,width:90*PX,height:90*PX)
            imgView.layer.cornerRadius = 45*PX
            imgView.layer.masksToBounds = true
            imgView.image = UIImage(named:"loadPic")
            parentView.addSubview(imgView)
        }else{
            thisView.setLabelView(150*PX, 19*PX, 540*PX, 40*PX, NSTextAlignment.right, UIColor.clear, myColor().gray9(), 28, labelStr)
            parentView.addSubview(thisView)
        }
        
        top = top + height + 1*PX
        return top
    }
}

// MARK: - 数据源绑定
extension QZHPersonInfoViewController{
    
}

// MARK: - 监听方法
extension QZHPersonInfoViewController{
    // 返回
    func close(){
            dismiss(animated: true, completion: nil)
    }
    
    //／显示消息 好友列表
    func showFriends(){
        let vc = QZHDemoViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    // 修改昵称
    func editInfo(_ sender:UITapGestureRecognizer){
        let this = sender.view
        QZHPersonalCenterMyInfoModel.eidtTitle = (this?.restorationIdentifier)!
        
        if QZHPersonalCenterMyInfoModel.eidtTitle == "昵称"{
            QZHPersonalCenterMyInfoModel.phone = ""
            QZHPersonalCenterMyInfoModel.nickName = nikeName.text!
            QZHPersonalCenterMyInfoModel.realName = ""
            QZHPersonalCenterMyInfoModel.headPort = ""
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "真实姓名"{
            QZHPersonalCenterMyInfoModel.phone = ""
            QZHPersonalCenterMyInfoModel.nickName = ""
            QZHPersonalCenterMyInfoModel.realName = name.text!
            QZHPersonalCenterMyInfoModel.headPort = ""
        }else if QZHPersonalCenterMyInfoModel.eidtTitle == "联系电话"{
            QZHPersonalCenterMyInfoModel.phone = phone.text!
            QZHPersonalCenterMyInfoModel.nickName = ""
            QZHPersonalCenterMyInfoModel.realName = ""
            QZHPersonalCenterMyInfoModel.headPort = ""
        }
        
        let nav = QZHEditPersonInfoViewController()
        present(nav, animated: true, completion: nil)
        
        
    }
    
    // 修改图像
    func editPhoto(){
        QZHPersonalCenterMyInfoModel.phone = ""
        QZHPersonalCenterMyInfoModel.nickName = ""
        QZHPersonalCenterMyInfoModel.realName = ""
        self.userInfo.editPersonInfo { (isSuccess, msg) in
            if isSuccess{
                //print(QZHPersonalCenterMyInfoModel.headPort)
                
                self.getData()
            }else{
                UIAlertController.showAlert(message: msg, in: self)
            }
        }
    }
    
    //从相册选择我
    func fromAlbum(_ sender:Any){
        
        
       /* if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = .photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }*/
        
        let actionSheet = UIAlertController(title: "上传头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            //判断是否能进行拍照，可以的话打开相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else
            {
                print("模拟其中无法打开照相机,请在真机中使用");
            }
            
        })
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            //调用相册功能，打开相册
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type: String = (info[UIImagePickerControllerMediaType] as! String)
        if type == "public.image"{
            let pickedImages = info[UIImagePickerControllerOriginalImage] as? UIImage
            //let imageData = UIImageJPEGRepresentation(pickedImages!, 1.0)
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
                //获取选择的原图
                //let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                print("pickedImage:\(pickedImage)")
                //将选择的图片保存到Document目录下
                let fileManager = FileManager.default
                let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                   .userDomainMask, true)[0] as String
                let filePath = "\(rootPath)/pickedimage.jpg"
                let imageData = UIImageJPEGRepresentation(pickedImage, 0.05)
                print("imageData:\(imageData)")
                //let str = String(data:imageData!, encoding: String.Encoding.utf8)!
                QZHPersonalCenterMyInfoModel.photoStr = imageData! as NSData
                
                //print("str:\(str)")
                fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
                
                //上传图片
                if (fileManager.fileExists(atPath: filePath)){
                    //取得NSURL
                    let imageURL = URL(fileURLWithPath: filePath)
                    
                    
                    //print("imageData:\(data)")
                    QZHPersonalCenterMyInfoModel.img = pickedImage
                    //print(QZHPersonalCenterMyInfoModel.photoStr)
                    self.userInfo.uploadPhoto(completion: { (isSuccess, msg) in
                        if isSuccess{
                            QZHPersonalCenterMyInfoModel.headPort = msg
                            self.editPhoto()
                            picker.dismiss(animated: true, completion: nil)
                            
                            
                        }else{
                            UIAlertController.showAlert(message: msg, in: self)
                        }
                    })
                    
                }
            }else{
                print("获取图片出错")
            }
        }
        
        
    }
    
    //退出相册
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

