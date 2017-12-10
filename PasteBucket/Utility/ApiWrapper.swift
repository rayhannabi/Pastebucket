//
//  ApiHelper.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/8/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit
import Alamofire

class ApiWrapper {
    
    class func loginUser(viewController: UIViewController,
                         username: String,
                         password: String,
                         completion: @escaping (User?) -> ()) {
        
        // MARK: login request
        Alamofire.request(URL(string: API.apiLogin)!, method: .post, parameters: [
            API.kDevKey: API.apiKey,
            API.kUsername: username,
            API.kUserPassword: password
            ]).validate().responseString(completionHandler: { (data) in
                
                if let actualData = data.value {
                    if (actualData.contains("invalid login") || actualData.contains("account not active") )  {
                        Util.showAlert(viewController: viewController, withTitle: "Error", andMessage: "Username and password do not match")
                    } else {
                        let loggedInUser = User(userId: actualData)
                        
                        completion(loggedInUser)
                    }
                }
            })
    }
    
    class func parseUser(loggedInUser: User?, completion: @escaping (User?) -> ()) {
        
        if let user = loggedInUser {
            Alamofire.request(URL(string: API.apiPost)!, method: .post, parameters: [
                API.kDevKey: API.apiKey,
                API.kUserKey: user.userId,
                API.kOption: API.pUserDetail
                ]
                ).validate().responseString(completionHandler: { (response) in
                    if let responseValue = response.value {
                        let parser = XmlParserHelper(user: user, xmlString: responseValue)
                        let parsedUser = parser.parseForUser()
                        
                        parsedUser?.setToDefaults()
                        
                        completion(parsedUser)
                    }
                })
        }
    }
}























