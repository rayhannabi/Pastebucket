//
//  User.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/7/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import Foundation

class User {
    private (set) var userId: String
    
    var name: String?
    var formatShort: String?
    var expiration: String?
    var avatarUrl: String?
    var userScope: String?
    var website: String?
    var email: String?
    var location: String?
    var accountType: String?
    
    init(userId: String) {
        self.userId = userId
        
        setToDefaults()
    }
    
    public func setToDefaults() {
        let userDefault = UserDefaults.standard
        
        userDefault.set(self.userId, forKey: "USER_KEY")
        userDefault.set(self.name, forKey: "USER_NAME")
        userDefault.set(self.formatShort, forKey: "USER_FORMAT")
        userDefault.set(self.expiration, forKey: "USER_EXPIRATION")
        userDefault.set(self.avatarUrl, forKey: "USER_AVATAR")
        userDefault.set(self.userScope, forKey: "USER_SCOPE")
        userDefault.set(self.website, forKey: "USER_WEBSITE")
        userDefault.set(self.email, forKey: "USER_EMAIL")
        userDefault.set(self.location, forKey: "USER_LOCATION")
        userDefault.set(self.accountType, forKey: "USER_ACCOUNTTYPE")
        
        userDefault.synchronize()
    }
    
    public func clearDefaults() {
        let userDefault = UserDefaults.standard
        
        userDefault.set("", forKey: "USER_KEY")
        userDefault.set("", forKey: "USER_NAME")
        userDefault.set("", forKey: "USER_FORMAT")
        userDefault.set("", forKey: "USER_EXPIRATION")
        userDefault.set("", forKey: "USER_AVATAR")
        userDefault.set("", forKey: "USER_SCOPE")
        userDefault.set("", forKey: "USER_WEBSITE")
        userDefault.set("", forKey: "USER_EMAIL")
        userDefault.set("", forKey: "USER_LOCATION")
        userDefault.set("", forKey: "USER_ACCOUNTTYPE")
        
        userDefault.synchronize()
    }
    
    class func getFromDefaults() -> User? {
        let userDefault = UserDefaults.standard
        
        let key = userDefault.string(forKey: "USER_KEY")
        let name = userDefault.string(forKey: "USER_KEY")
        let format = userDefault.string(forKey: "USER_FORMAT")
        let expiration = userDefault.string(forKey: "USER_EXPIRATION")
        let avatar = userDefault.string(forKey: "USER_AVATAR")
        let scope = userDefault.string(forKey: "USER_SCOPE")
        let website = userDefault.string(forKey: "USER_WEBSITE")
        let email = userDefault.string(forKey: "USER_EMAIL")
        let location = userDefault.string(forKey: "USER_LOCATION")
        let type = userDefault.string(forKey: "USER_ACCOUNTTYPE")
        
        if let key = key {
            let usr = User(userId: key)
            usr.name = name
            usr.formatShort = format
            usr.expiration = expiration
            usr.avatarUrl = avatar
            usr.userScope = scope
            usr.website = website
            usr.email = email
            usr.location = location
            usr.accountType = type
            
            return usr
        }
        
        return nil
    }
    
}
















