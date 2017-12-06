//
//  ViewController.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/28/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var userType: UserType?
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        usernameField.text = ""
        passwordField.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    @IBAction func loginPressed(_ sender: Any) {
        userType = UserType.actualUser
        performSegue(withIdentifier: "ToMain", sender: self)
    }
    
    @IBAction func loginGuestPressed(_ sender: Any) {
        userType = UserType.guestUser
        performSegue(withIdentifier: "ToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMain" {
            if let tabController = segue.destination as? UITabBarController {
                if let tabChildren = tabController.viewControllers {
                    if let firstChild = tabChildren.first as? UINavigationController {
                        if let pasteVC = firstChild.topViewController as? PastesTVC {
                            pasteVC.userType = self.userType
                        }
                    }
                    
                    if let lastChild = tabChildren.last as? UINavigationController {
                        if let profileVC = lastChild.topViewController as? ProfileTVC {
                            profileVC.userType = self.userType
                        }
                    }
                }
            }
        }
    }
}


































