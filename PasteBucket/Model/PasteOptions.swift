//
//  PasteSettings.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/2/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import Foundation

class PasteOptions {
    public static let pasteExpires: [String: String] = [
        "Never" : "N",
        "10 Minutes" : "10M",
        "1 Hour": "1H",
        "1 Day" : "1D",
        "1 Week" : "1W",
        "2 Weeks" : "2W",
        "1 Month" : "1M",
        "6 Months" : "6M",
        "1 Year" : "1Y"
    ]
    
    public static let pasteExposure: [String: String] = [
        "Public" : "0",
        "Unlisted" : "1",
        "Private" : "2"
    ]
    
    
}
