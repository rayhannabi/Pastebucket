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
                         password: String) -> User? {
        
        Alamofire.request(
            URL(string: API.apiLogin)!,
            method: .post,
            parameters: [
                API.kDevKey: API.apiKey,
                API.kUsername: username,
                API.kUserPassword: password
            ]
            ).validate()
            .responseString(completionHandler: { (data) in
                if let actualData = data.value {
                    if actualData.contains("invalid login") {
                        Util.showAlert(viewController: viewController, withTitle: "Error", andMessage: "Username and password do not match")
                    } else {
                        
//                        validUser = User(userId: actualData)
//
//                        if let loggedInUser = validUser {
//                            // fetch userdetails
//                            Alamofire.request(
//                                URL(string: API.apiPost)!,
//                                method: .post,
//                                parameters: [
//                                    API.kDevKey: API.apiKey,
//                                    API.kUserKey: loggedInUser.userId,
//                                    API.kOption: API.pUserDetail
//                                ]
//                                ).validate()
//                                .responseString(completionHandler: { (data) in
//                                    print(data.value!)
//                                    return XmlParserHelper(user: loggedInUser, xmlString: data.value!).parseForUser()
//                                })
//                        }
                    }
                }
            })
        
        return nil
    }
}
