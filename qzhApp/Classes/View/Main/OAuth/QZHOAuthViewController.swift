//
//  QZHOAuthViewController.swift
//  qzhApp
//
//  Created by sbxmac on 2018/1/11.
//  Copyright © 2018年 SpecialTech. All rights reserved.
//

import UIKit


/// 通过 webView 加载千纸鹤授权页面控制器
class QZHOAuthViewController: UIViewController {
    
    lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        //设置导航栏
        title = "登录千纸鹤"
        
        //导航栏摁钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", img: "back_pageIcon", target: self, action: #selector(close))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
}
