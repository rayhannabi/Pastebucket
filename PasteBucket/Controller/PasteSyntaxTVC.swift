//
//  PasteSyntaxTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/2/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PasteSyntaxTVC: UITableViewController {
    
    let syntaxes = PasteSyntax.syntaxCollection
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredSyntaxes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.8884173413, green: 0.8884173413, blue: 0.8884173413, alpha: 1)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for syntax"
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true

        self.clearsSelectionOnViewWillAppear = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Available Syntax Highlights"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syntaxes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syntaxCell", for: indexPath)

        cell.textLabel?.text = syntaxes[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            
        }
    }
    
    func searchbarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContent(_ searchText: String, scope: String = "ALL") {
        filteredSyntaxes = syntaxes.filter({(syntax: String) -> Bool in
            return syntax.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

extension PasteSyntaxTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchController.searchBar.text!)
    }
}
