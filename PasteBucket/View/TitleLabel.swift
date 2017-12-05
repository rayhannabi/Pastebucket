//
//  TitleLabel.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/5/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class TitleLabel {
    static func get() -> UILabel {
        let fontSize = CGFloat(20)
        let boldAttribute = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize, weight: .bold)
        ]
        
        let lightAttribute = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize, weight: .light)
        ]
        
        let attributedString = NSMutableAttributedString(string: "PASTEBUCKET", attributes: boldAttribute)
        
        attributedString.setAttributes(lightAttribute, range: NSMakeRange(5, 6))
        
        let label = UILabel()
        label.attributedText = attributedString
        label.textColor = UIColor.white
        label.sizeToFit()
        
        return label
    }
}
