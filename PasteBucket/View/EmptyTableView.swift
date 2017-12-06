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
    private var title: String
    
    init(title: String, message: String, for table: UITableViewController) {
        self.title = title
        self.message = message
        self.viewController = table
    }
    
    public func getEmptyView() {
        let messageLabel = UILabel(
            frame: CGRect(x: 0,
                          y: 0,
                          width: viewController.view.bounds.size.width,
                          height: 15))
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.sizeToFit()
        
        let titleLabel = UILabel(
            frame: CGRect(x: 0,
                          y: 0,
                          width: viewController.view.bounds.size.width,
                          height: 25))
        
        titleLabel.text = self.title
        titleLabel.textColor = UIColor.lightGray
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = .center;
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.sizeToFit()
        
        let cv = UIView()
        let container = UIStackView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: viewController.view.bounds.size.width,
                                                  height: 45))
        container.autoresizesSubviews = true
        container.axis = .vertical
        container.distribution = .fill
        container.alignment = .fill
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(messageLabel)
        container.sizeToFit()
        
        cv.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: cv.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: cv.centerYAnchor).isActive = true
        
        viewController.tableView.backgroundView = cv;
        viewController.tableView.separatorStyle = .none;
    }
}
