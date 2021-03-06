//
//  RoundedButton.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/28/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        customizeView()
    }
    
    private func customizeView() {
        layer.cornerRadius = 5
    }
}
