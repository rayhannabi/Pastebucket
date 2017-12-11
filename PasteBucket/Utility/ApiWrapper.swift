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
    
    class func getUserDetails(for loggedInUser: User?, completion: @escaping (User?) -> ()) {
        
        if let user = loggedInUser {
            Alamofire.request(URL(string: Api.apiPost)!, method: .post, parameters: [
                Api.kDevKey: Api.apiKey,
                Api.kUserKey: user.userId,
                Api.kOption: Api.vUserDetail
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
    
    class func parsePastes(for user: User?, completion: @escaping ([Paste]) -> ()) {
        if user != nil {
            Alamofire.request(URL(string: Api.apiPost)!, method: .post, parameters: [
                Api.kDevKey: Api.apiKey,
                Api.kUserKey: user!.userId,
                Api.kOption: Api.vList
                ]
                ).validate().responseString(completionHandler: { (response) in
                    if let responseValue = response.value {
                        // TODO: Parse xml here
                        let properResponseValue = "<pastes>\n" + responseValue + "</pastes>\n"
                        
                        let parser = XmlParserHelper(xmlString: properResponseValue)
                        let pasteCollection = parser.parseForPastes()
                        completion(pasteCollection)
                    }
                })
        } else {
            Alamofire.request(URL(string: Api.apiPost)!, method: .post, parameters: [
                Api.kDevKey: Api.apiKey,
                Api.kOption: Api.vTrends
                ]
                ).validate().responseString(completionHandler: { (response) in
                    if let responseValue = response.value {
                        // TODO: Parse xml here
                        let properResponseValue = "<pastes>\n" + responseValue + "</pastes>\n"
                        
                        let parser = XmlParserHelper(xmlString: properResponseValue)
                        let pasteCollection = parser.parseForPastes()
                        completion(pasteCollection)
                    }
                })
        }
    }
    
    class func getRawPaste(key: String, completion: @escaping (String) -> ()) {
        var pasteUrl = Api.apiRaw
        pasteUrl.append(key)
        let url = URL(string: pasteUrl)!
        
        Alamofire.request(url, method: .get).validate().responseString { (raw) in
            if let rawPaste = raw.value {
                completion(rawPaste)
            }
        }
    }
    
    class func createPaste(forKey userKey: String?, paste: Paste, completion: @escaping (String) -> ()) {
        var keydata = ""
        if userKey != nil {
            keydata = userKey!
        }
        
        Alamofire.request(URL(string: Api.apiPost)!, method: .post, parameters: [
            Api.kDevKey: Api.apiKey,
            Api.kOption: Api.vPaste,
            Api.kPasteCode: paste.code,
            Api.kUserKey: keydata,
            Api.kPasteName: paste.title,
            Api.kExpire: paste.expireDate,
            Api.kPrivate: paste.scope
            ]
            ).validate().responseString { (response) in
                if let value = response.value {
                    completion(value)
                }
        }
    }
    
}























