//
//  EnterprisePortalController.swift
//  qzhApp
//
//  Created by sbxmac on 2017/12/27.
//  Copyright © 2017年 SpecialTech. All rights reserved.
//

import UIKit
import Foundation

class EnterprisePortalController: UIViewController {

    @IBOutlet weak var header: headerController!
    
    override func viewDidLoad() {
        PublicFunction().setStatusbackgroundColor(myColor().blue4187c2())
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        //var
    }
    
}
