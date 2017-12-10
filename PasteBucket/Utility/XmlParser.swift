//
//  XmlParser.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/8/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class XmlParserHelper {
    private var user : User?
    private var xmlData: Data
    
    init(user: User, xmlString: String) {
        self.user = user
        self.xmlData = xmlString.data(using: String.Encoding.utf8)!
    }
    
    func parseForUser() -> User? {
        let xml = XML.parse(xmlData)
        
        self.user?.name = xml["user"]["user_name"].text
        self.user?.formatShort = xml["user"]["user_format_short"].text
        self.user?.expiration = xml["user"]["user_expiration"].text
        self.user?.avatarUrl = xml["user"]["user_avatar_url"].text
        self.user?.userScope = xml["user"]["user_private"].text
        self.user?.website = xml["user"]["user_website"].text
        self.user?.email = xml["user"]["user_email"].text
        self.user?.accountType = xml["user"]["user_account_type"].text
        self.user?.location = xml["user"]["user_location"].text
        
        return self.user
    }
}
