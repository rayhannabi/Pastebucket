//
//  CreatePasteVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/29/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class CreatePasteVC: UIViewController {

    var syntax: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindFromPasteSyntaxTVC(_ sender: UIStoryboardSegue) {
        if sender.source is PasteSyntaxTVC {
            if let senderVC = sender.source as? PasteSyntaxTVC {
                syntax = senderVC.selectedSyntax
            }
        }
        
        print(syntax!)
    }
}
