//
//  ViewController.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/28/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    var userType: UserType?
    var loggedInUser: User?
    
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
        
        if Connectivity.hasNetworkonnection() {
            if let uname = usernameField.text, let password = passwordField.text {
                if (!uname.isEmpty && !password.isEmpty) {
                    print(uname, password)
                    loggedInUser = ApiWrapper.loginUser(
                        viewController: self,
                        username: uname,
                        password: password)
                    if loggedInUser != nil {
                    self.performSegue(withIdentifier: "ToMain", sender: self)
                    }
                }
            }
        } else {
            Util.showAlert(viewController: self,
                           withTitle: "Error",
                           andMessage: "Could not connect to the internet\nCheck your connection")
        }
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
                            pasteVC.loggedInUser = self.loggedInUser
                        }
                    }
                    
                    if let lastChild = tabChildren.last as? UINavigationController {
                        if let profileVC = lastChild.topViewController as? ProfileTVC {
                            profileVC.userType = self.userType
                            profileVC.user = self.loggedInUser
                        }
                    }
                }
            }
        }
    }
}


































