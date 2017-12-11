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
    private var pasteCollection : [Paste]
    private var user : User?
    private var xmlData: Data
    
    init(user: User, xmlString: String) {
        self.user = user
        self.xmlData = xmlString.data(using: String.Encoding.utf8)!
        self.pasteCollection = []
    }
    
    init(xmlString: String) {
        self.pasteCollection = []
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
    
    func parseForPastes() -> [Paste] {
        
        let xml = XML.parse(xmlData)
        
        for item in xml["pastes"] {
            for it in item["paste"] {
                
                let pasteItem = Paste()
                pasteItem.key = it["paste_key"].text!
                pasteItem.date = it["paste_date"].text!
                pasteItem.title = it["paste_title"].text == nil ? "Untitled" : it["paste_title"].text!
                pasteItem.size = it["paste_size"].text!
                pasteItem.expireDate = it["paste_expire_date"].text!
                pasteItem.scope = it["paste_private"].text!
                pasteItem.formatShort = it["paste_format_short"].text!
                pasteItem.formatLong = it["paste_format_long"].text!
                pasteItem.url = it["paste_url"].text!
                pasteItem.hits = it["paste_hits"].text!
                
                pasteCollection.append(pasteItem)
            }
        }
        return pasteCollection
    }
}













