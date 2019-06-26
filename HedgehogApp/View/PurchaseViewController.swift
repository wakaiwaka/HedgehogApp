//
//  PurchaseViewController.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/05/01.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "用品の購入"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.lightSkyBlue]
        
    }
}
