//
//  Connectivity.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/8/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity {
    class func hasNetworkonnection() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
