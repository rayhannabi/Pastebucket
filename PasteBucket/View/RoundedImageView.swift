//
//  RoundedImageView.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/3/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {
    override func prepareForInterfaceBuilder() {
        customize()
    }
    
    override func awakeFromNib() {
        customize()
    }
    
    func customize() {
        layer.cornerRadius = layer.frame.size.width / 2
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clipsToBounds = true
    }
}
