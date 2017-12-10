//
//  Util.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/10/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class Util {
    class func showAlert(viewController: UIViewController, withTitle title: String, andMessage msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
