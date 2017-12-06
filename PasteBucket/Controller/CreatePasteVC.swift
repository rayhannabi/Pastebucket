//
//  CreatePasteVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/29/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class CreatePasteVC: UIViewController {

    public var id: String?
    public var operation: PasteOperation?
    
    @IBOutlet weak var syntaxItem: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var chooseSyntaxButton: UIBarButtonItem!
    @IBOutlet weak var codeView: UITextView!
    
    var syntax: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syntaxItem.isEnabled = false
        syntaxItem.title = "None"
        
        if id != nil {
            self.navigationItem.title = id!
        } else {
            self.navigationItem.title = "Some Paste"
        }
        
        if let operation = operation {
            switch operation {
            case .view:
                if let id = id {
                    self.navigationItem.title = id
                }
                nextButton.title = "Author Name"
                nextButton.isEnabled = false
                chooseSyntaxButton.isEnabled = false
                codeView.isEditable = false
            case .create:
                self.navigationItem.title = "New Paste"
            case .edit:
                if let id = id {
                    self.navigationItem.title = id
                }
            }
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        performSegue(withIdentifier: "ToOptions", sender: self)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ActionPressed(_ sender: Any) {
        var activityItems: [Any] = []
        
        activityItems.append("Test")
        
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
    
    @IBAction func unwindFromPasteSyntaxTVC(_ sender: UIStoryboardSegue) {
        if sender.source is PasteSyntaxTVC {
            if let senderVC = sender.source as? PasteSyntaxTVC {
                syntax = senderVC.selectedSyntax
            }
        }
        syntaxItem.title = syntax!
        print(syntax!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOptions" {
            if let optionsVC = segue.destination as? PasteOptionsTVC {
                optionsVC.operation = self.operation
            }
        }
    }
}
