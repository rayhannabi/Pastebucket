//
//  PasteSyntaxTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/2/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PasteSyntaxTVC: UITableViewController {
    
    var selectedSyntax: String?
    
    let syntaxes = PasteSyntax.syntaxCollection
    var filteredSyntaxes = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchFooter: SearchFooterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        searchController.searchBar.isTranslucent = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for syntax"
       
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black]

        self.clearsSelectionOnViewWillAppear = false
        
        self.searchFooter = SearchFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        
        if let searchFooter = self.searchFooter {
            tableView.tableFooterView = searchFooter
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isFiltering() {
            return ""
        }
        return "Available Syntax Highlights"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            searchFooter?.setIsFiltering(filtered: filteredSyntaxes.count, of: syntaxes.count)
            return filteredSyntaxes.count
        }
        searchFooter?.setNotFiltering()
        return syntaxes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syntaxCell", for: indexPath)

        if isFiltering() {
            cell.textLabel?.text = filteredSyntaxes[indexPath.row]
        } else {
            cell.textLabel?.text = syntaxes[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        if isFiltering() {
            selectedSyntax = filteredSyntaxes[indexPath.row]
            searchController.dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "BackToPaste", sender: self)
            })
            // performSegue(withIdentifier: "BackToPaste", sender: self)
        } else {
            selectedSyntax = syntaxes[indexPath.row]
            performSegue(withIdentifier: "BackToPaste", sender: self)
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}

extension PasteSyntaxTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContent(_ searchText: String, scope: String = "ALL") {
        filteredSyntaxes = syntaxes.filter({(syntax: String) -> Bool in
            return syntax.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
