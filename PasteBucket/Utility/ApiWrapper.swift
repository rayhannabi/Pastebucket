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
        Alamofire.request(URL(string: Api.apiLogin)!, method: .post, parameters: [
            Api.kDevKey: Api.apiKey,
            Api.kUsername: username,
            Api.kUserPassword: password
            ]).validate().responseString(completionHandler: { (data) in
                
                if let actualData = data.value {
                    print(actualData)
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
            Alamofire.request(URL(string: Api.apiPost)!, method: .post, parameters: [
                Api.kDevKey: Api.apiKey,
                Api.kUserKey: user.userId,
                Api.kOption: Api.pUserDetail
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























