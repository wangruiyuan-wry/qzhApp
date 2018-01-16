//
//  QZHAOuthViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/12.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit

//通过 webView 加载千纸鹤登录控制器
class QZHOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        
        //设置导航条
        title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "", target: self, action: #selector(close))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - 监听方法
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }

}
