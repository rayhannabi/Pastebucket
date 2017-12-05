//
//  PastesTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PastesTVC: UITableViewController {

    var demoData: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    // Searchbar
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = TitleLabel.get()
        let editButton = self.editButtonItem
        editButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = editButton
        
        // search controller init
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Pastes"
        searchController.searchBar.tintColor = UIColor.white
        
        print(searchController.searchBar.value(forKey: "searchField")!)
        
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasteCell", for: indexPath)

        cell.textLabel?.text = String(describing: demoData[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, index) in
            
            var activityItems: [Any] = []
            
            activityItems.append(String(describing: self.demoData[index.row]))
            
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            activityVC.excludedActivityTypes = [
                UIActivityType.airDrop,
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.addToReadingList,
            ]
            
            self.present(activityVC, animated: true, completion: nil)
        }
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.demoData.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .fade)
        }
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, shareAction]
    }

}

extension PastesTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // update
    }
}
