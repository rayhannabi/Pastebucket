//
//  TrendingTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/6/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class TrendingTVC: UITableViewController {

    var demoData: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var selectedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = TitleLabel.get()
        let editButton = self.editButtonItem
        editButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = editButton
        
        let refreshController = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.refreshControl = refreshController
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.refreshControl?.beginRefreshing()
        
        let refreshedData: [Int] = [11, 12, 13, 14, 15, 16]
        
        self.demoData = refreshedData
        self.tableView.separatorStyle = .singleLine
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath)
        
        cell.textLabel?.text = String(describing: demoData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        
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
        
        return [shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedData = String(describing: demoData[indexPath.row])
        
        performSegue(withIdentifier: "ToReadPaste", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToReadPaste" {
            if let navController = segue.destination as? UINavigationController {
                if let createVC = navController.topViewController as? CreatePasteVC {
                    createVC.id = selectedData
                    createVC.operation = PasteOperation.view
                }
            }
        }
    }
}












