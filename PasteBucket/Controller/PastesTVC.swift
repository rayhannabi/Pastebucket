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
    
    var pasteCollection: [Paste] = []
    var filteredData = [Paste]()
    
    var selectedData: Paste?
    var searchFooter: SearchFooterView?
    var indicator: ActivityIndicatorView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = ActivityIndicatorView(text: "Loading your Pastes")
        view.addSubview(indicator)
        indicator.hide()
        
        prepareUserData()
        prepareView()
        prepareData()
    }
    
    func prepareUserData() {
        if let usr = loggedInUser {
            ApiWrapper.getUserDetails(for: usr, completion: { (user) in
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
            pasteCollection = []
            let etv = EmptyTableView(title: "Guest Mode", message: "Try adding some paste", for: self)
            etv.getEmptyView()
        } else if type == .actualUser {
            loadData()
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
            self.searchFooter?.setIsFiltering(filtered: filteredData.count, of: pasteCollection.count)
            return filteredData.count
        }
        self.searchFooter?.setNotFiltering()
        return pasteCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPasteCell", for: indexPath) as? PasteCell else {
            return UITableViewCell()
        }
        if isFiltering() {
            cell.configureView(with: filteredData[indexPath.row])
        } else {
            cell.configureView(with: pasteCollection[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, index) in
            
            var activityItems: [Any] = []
            
            activityItems.append(String(describing: self.pasteCollection[index.row]))
            
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
            self.pasteCollection.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .fade)
            
            if self.pasteCollection.count == 0 {
                let etv = EmptyTableView(title: "No Paste found", message: "Try creating one or pull down to refresh", for: self)
                etv.getEmptyView()
            }
        }
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        operation = PasteOperation.view
        
        if isFiltering() {
            selectedData = filteredData[indexPath.row]
            searchController.dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "ToCreatePaste", sender: self)
            })
        } else {
            selectedData = pasteCollection[indexPath.row]
            self.performSegue(withIdentifier: "ToCreatePaste", sender: self)
        }
    }
    
    fileprivate func loadData() {
        indicator.show()
        
        ApiWrapper.parsePastes(for: loggedInUser) { (allPastes) in
            
            if allPastes.count > 0 {
                self.pasteCollection = allPastes
                
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
                if let isrefreshing = self.refreshControl?.isRefreshing, isrefreshing {
                    self.refreshControl?.endRefreshing()
                }
                self.indicator.hide()
            } else {
                let etv = EmptyTableView(title: "No Paste Found", message: "Try adding some paste", for: self)
                etv.getEmptyView()
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if let ut = userType, ut == .actualUser {
            loadData()
        }
        self.view.reloadInputViews()
    }
    
    @IBAction func createPastePressed(_ sender: Any) {
        operation = PasteOperation.create
        performSegue(withIdentifier: "ToCreatePaste", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCreatePaste" {
            if let navController = segue.destination as? UINavigationController {
                if let createVC = navController.topViewController as? CreatePasteVC {
                    createVC.paste = selectedData
                    createVC.operation = operation
                    if let loggedInUser = self.loggedInUser {
                        createVC.userKey = loggedInUser.userId
                    } else {
                        createVC.userKey = nil
                    }
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
        filteredData = pasteCollection.filter({ (data) -> Bool in
            return data.title.lowercased().contains(searchText.lowercased())
        })
        
        for item in filteredData {
            print(item.title, item.key)
        }
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
























