//
//  ProfileTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/5/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTVC: UITableViewController {
    
    var userType: UserType?
    var user: User?
    
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
            profileImage.image = UIImage(named: "guest")
            profileUsername.text = "Guest"
            profileEmail.text = "Not Available"
            profileCountry.text = "Not Available"
            profileType.text = "Not Applicable"
            
            tableView.footerView(forSection: 1)?.detailTextLabel?.text =
            """
            NOTE: Guest account only contains recent Pastes.
            Logging out will cause to reset everthing.
            """
            
            let col = [profileUsername, profileEmail, profileCountry, profileType]
            for item in col {
                item?.textColor = UIColor.gray
            }
        } else {
            if let user = self.user {
                Alamofire.request(
                    URL(string: user.avatarUrl!)!,
                    method: .get
                ).validate()
                    .responseData(completionHandler: { (data) in
                        self.profileImage.image = UIImage(data: data.data!, scale: 1)
                    })
                
                profileUsername.text = user.name
                profileEmail.text = user.email
                profileCountry.text = user.location
                
                if let type = user.accountType {
                    if type == "1" {
                        profileType.text = "Pro"
                    } else {
                        profileType.text = "Normal"
                    }
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        let logoutAlert = UIAlertController(title: "Logout",
                                            message: "You are about to be logged out.\nAre you sure?",
                                            preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive) { (action) in
            
            self.user?.clearDefaults()
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





















