//
//  Api.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/7/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import Foundation

public struct Api {
    static let apiKey: String = "8dc0b1a928199c4f2fc5e1960c2d6976"
    
    static let apiPost: String = "https://pastebin.com/api/api_post.php"
    static let apiLogin: String = "https://pastebin.com/api/api_login.php"
    static let apiRaw: String = "https://pastebin.com/raw/"
    
    static let kDevKey = "api_dev_key"
    static let kUsername = "api_user_name"
    static let kUserKey = "api_user_key"
    static let kUserPassword = "api_user_password"
    static let kOption = "api_option"
    static let kPasteCode = "api_paste_code"
    static let kPasteName = "api_paste_name"
    static let kPasteFormat = "api_paste_format"
    static let kPrivate = "api_paste_private"
    static let kExpire = "api_paste_expire_date"
    
    static let vUserDetail = "userdetails"
    static let vTrends = "trends"
    static let vList = "list"
    static let vPaste = "paste"
}
