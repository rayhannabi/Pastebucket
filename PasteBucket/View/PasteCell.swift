//
//  PasteCell.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/11/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PasteCell: UITableViewCell {
    
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var linkField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var hitsField: UILabel!
    
    func configureView(with paste: Paste) {
        
        let date = Date(timeIntervalSince1970: Double(paste.date)!)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MMM-dd"
        
        titleField.text = paste.title
        linkField.text = paste.url
        dateField.text = dateFormat.string(from: date)
        hitsField.text = "hits: " + paste.hits
    }
}
