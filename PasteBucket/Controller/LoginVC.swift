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
    var indicator: ActivityIndicatorView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = ActivityIndicatorView(text: "Logging In")
        self.view.addSubview(indicator)
        
        indicator.hide()

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
        if usernameField.isFirstResponder {
            usernameField.resignFirstResponder()
        } else {
            passwordField.resignFirstResponder()
        }
        
        userType = UserType.actualUser
        
        if Connectivity.hasNetworkonnection() {
            if let uname = usernameField.text, let password = passwordField.text {
                if (!uname.isEmpty && !password.isEmpty) {
                    
                    UIApplication.shared.beginIgnoringInteractionEvents()
                    indicator.show()
                    ApiWrapper.loginUser(viewController: self,
                                         username: uname,
                                         password: password,
                                         completion: { (usr) in
                                            self.loggedInUser = usr
                                            self.indicator.hide()
                                            if self.loggedInUser != nil {
                                                UIApplication.shared.endIgnoringInteractionEvents()
                                                self.performSegue(withIdentifier: "ToMain", sender: self)
                                            }
                    })
                }
            }
        } else {
            self.indicator.hide()
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


































