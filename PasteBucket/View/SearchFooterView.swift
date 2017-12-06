//
//  SearchFooterView.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class SearchFooterView: UIView {
    let label = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        self.label.frame = self.bounds
    }
    
    func configureView() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.alpha = 0.0
        
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.label.textAlignment = .center
        self.label.textColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        self.addSubview(self.label)
    }
    
    fileprivate func showFooter() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.alpha = 1.0
        }
    }
    
    fileprivate func hideFooter() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.alpha = 0.0
        }
    }
}

extension SearchFooterView {
    
    public func setNotFiltering() {
        self.label.text = ""
        hideFooter()
    }
    
    public func setIsFiltering(filtered filteredItemCount: Int, of totalItemCount: Int) {
        if filteredItemCount == totalItemCount {
            setNotFiltering()
        } else if filteredItemCount == 0 {
            self.label.text = "No item found"
            showFooter()
        } else {
            self.label.text = "Showing \(filteredItemCount) of \(totalItemCount) items"
            showFooter()
        }
    }
}
















