//
//  ProfileTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/5/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {
    
    var userType: UserType?
    
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileCountry: UILabel!
    @IBOutlet weak var profileType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = TitleLabel.get()
        
        if let type = userType {
            setData(for: type)
        }
    }
    
    func setData(for uType: UserType) {
        if uType == .guestUser {
            profileImage.image = UIImage(named: "user")
            profileUsername.text = "Guest"
            profileEmail.text = "Not Available"
            profileCountry.text = "Not Available"
            profileType.text = "Not Applicable"
            
            let col = [profileUsername, profileEmail, profileCountry, profileType]
            for item in col {
                item?.textColor = UIColor.gray
            }
        } else {
            // set appropiate user data
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        let logoutAlert = UIAlertController(title: "Logout",
                                            message: "You are about to be logged out.\nAre you sure?",
                                            preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            let pvc = self.presentingViewController
            
            self.dismiss(animated: true) {
                pvc?.dismiss(animated: true, completion: nil)
            }

        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            logoutAlert.dismiss(animated: true, completion: nil)
        }
        
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
        
        self.present(logoutAlert, animated: true, completion: nil)
    }
}





















