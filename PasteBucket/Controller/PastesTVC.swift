//
//  PastesTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PastesTVC: UITableViewController {
    
    var operation: PasteOperation?
    var userType: UserType?
    var loggedInUser: User?
    
    var demoData: [Int] = [11, 12, 13]
    var filteredData = [Int]()
    
    var selectedData: String?
    var searchFooter: SearchFooterView?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUserData()
        prepareView()
        prepareData()
    }
    
    func prepareUserData() {
        if let usr = loggedInUser {
            ApiWrapper.parseUser(loggedInUser: usr, completion: { (user) in
                self.loggedInUser = user
            })
        }
    }
    
    func prepareData() {
        if let userType = userType {
            prepareForUser(userType)
        }
    }
    
    func prepareForUser(_ type: UserType) {
        if type == .guestUser {
            demoData = []
            let etv = EmptyTableView(title: "Guest Mode", message: "Try adding some paste", for: self)
            etv.getEmptyView()
        }
    }
    
    func prepareView() {
        prepareNavigationItem()
        prepareSearchController()
        prepareSearchFooter()
        prepareRefreshControl()
    }
    
    func prepareNavigationItem() {
        self.navigationItem.titleView = TitleLabel.get()
        let editButton = self.editButtonItem
        editButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = editButton
    }
    
    func prepareSearchController() {
        // search controller init
        searchController.searchResultsUpdater = self
        searchController.searchBar.isTranslucent = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Pastes"
        searchController.searchBar.tintColor = UIColor.white
        
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    }
    
    func prepareSearchFooter() {
        self.searchFooter = SearchFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        
        if let searchFooter = self.searchFooter {
            tableView.tableFooterView = searchFooter
        }
    }
    
    func prepareRefreshControl() {
        let refreshController = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        refreshController.tintColor = UIColor.white
        refreshController.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            self.searchFooter?.setIsFiltering(filtered: filteredData.count, of: demoData.count)
            return filteredData.count
        }
        self.searchFooter?.setNotFiltering()
        return demoData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasteCell", for: indexPath)
        
        if isFiltering() {
            cell.textLabel?.text = String(describing: filteredData[indexPath.row])
        } else {
            cell.textLabel?.text = String(describing: demoData[indexPath.row])
        }
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
            
            if self.demoData.count == 0 {
                let etv = EmptyTableView(title: "No Paste found", message: "Try creating one or pull down to refresh", for: self)
                etv.getEmptyView()
            }
        }
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        operation = PasteOperation.edit
        
        if isFiltering() {
            selectedData = String(describing: filteredData[indexPath.row])
            searchController.dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "ToCreatePaste", sender: self)
            })
        } else {
            selectedData = String(describing: demoData[indexPath.row])
            self.performSegue(withIdentifier: "ToCreatePaste", sender: self)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if let ut = userType, ut == .actualUser {
            let refreshedData: [Int] = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
        
            self.demoData = refreshedData
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
        } else if let ut = userType, ut == .guestUser {
            let refreshedData: [Int] = []
            
            self.demoData = refreshedData
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func createPastePressed(_ sender: Any) {
        operation = PasteOperation.create
        performSegue(withIdentifier: "ToCreatePaste", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCreatePaste" {
            if let navController = segue.destination as? UINavigationController {
                if let createVC = navController.topViewController as? CreatePasteVC {
                    createVC.id = selectedData
                    createVC.operation = operation
                }
            }
        }
    }
    
}

extension PastesTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContent(_ searchText: String, scope: String = "All") {
        filteredData = demoData.filter({ (data) -> Bool in
            return String(describing: data).lowercased().contains(searchText.lowercased())
        })
        
        print(filteredData)
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
























