//
//  TrendingTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class TrendsTVC: UITableViewController {
    
    var pasteCollection: [Paste] = []
    
    var selectedPaste: Paste?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareData()
        prepareView()
    }
    
    fileprivate func prepareNavigationBar() {
        self.navigationItem.titleView = TitleLabel.get()
        let editButton = self.editButtonItem
        editButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = editButton
    }
    
    fileprivate func prepareRefresher() {
        let refreshController = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.refreshControl = refreshController
        
        refreshControl?.beginRefreshing()
    }
    
    fileprivate func prepareView() {
        prepareNavigationBar()
        prepareRefresher()
    }
    
    fileprivate func prepareData() {
        
        ApiWrapper.parsePastes(for: nil) { (allPastes) in
            self.pasteCollection = allPastes
            
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
            if let isrefreshing = self.refreshControl?.isRefreshing, isrefreshing {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        prepareData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pasteCollection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PasteCell", for: indexPath) as? PasteCell else {
                return UITableViewCell()
        }
        
        cell.configureView(with: pasteCollection[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, index) in
            
            var activityItems: [Any] = []
            
            activityItems.append(URL(string: self.pasteCollection[index.row].url)!)
            activityItems.append(self.pasteCollection[index.row].url)
            
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
        
        return [shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaste = pasteCollection[indexPath.row]
        
        performSegue(withIdentifier: "ToReadPaste", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToReadPaste" {
            if let navController = segue.destination as? UINavigationController {
                if let createVC = navController.topViewController as? CreatePasteVC {
                    createVC.paste = selectedPaste
                    createVC.operation = PasteOperation.view
                }
            }
        }
    }
}












