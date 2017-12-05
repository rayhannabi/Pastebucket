//
//  TrendingVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/5/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class TrendingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = TitleLabel.get()
    }

}
