//
//  PastesVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/29/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PastesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = TitleLabel.get()
        self.navigationItem.titleView = title
    }
}
