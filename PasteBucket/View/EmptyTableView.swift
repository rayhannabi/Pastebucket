//
//  EmptyTableView.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class EmptyTableView {
    
    private var viewController: UITableViewController
    private var message: String
    
    init(message: String, for table: UITableViewController) {
        self.message = message
        self.viewController = table
    }
    
    public func getEmptyView() {
        let messageLabel = UILabel(
            frame: CGRect(x: 0,
                          y: 0,
                          width: viewController.view.bounds.size.width,
                          height: viewController.view.bounds.size.height))
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }
}
