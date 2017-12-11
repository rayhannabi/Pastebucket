//
//  CreatePasteVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 11/29/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class CreatePasteVC: UIViewController {
    
    public var userKey: String?
    public var paste: Paste?
    public var operation: PasteOperation?
    
    var indicator: ActivityIndicatorView!
    
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
        indicator = ActivityIndicatorView(text: "Loading Paste")
        self.view.addSubview(indicator)
        self.indicator.hide()
        
        if let operation = operation {
            switch operation {
            case .view:
                setUpViewMode()
            case .create:
                setupCreateMode()
            case .edit:
                setupEditMode()
            }
        }
    }
    
    fileprivate func loadPaste(_ key: String) {
        indicator.show()
        ApiWrapper.getRawPaste(key: key) { (raw) in
            self.codeView.text = raw
            self.indicator.hide()
        }
    }
    
    fileprivate func setupCreateMode() {
        navigationItem.title = "New Paste"
        actionButton.isEnabled = false
    }
    
    fileprivate func setupEditMode() {
        if let paste = paste {
            self.navigationItem.title = paste.title
            loadPaste(paste.key)
            self.chooseSyntaxButton.isEnabled = false
            self.syntaxItem.title = paste.formatLong
        }
    }
    
    fileprivate func setUpViewMode() {
        if let paste = paste {
            self.navigationItem.title = paste.title
            self.syntaxItem.title = paste.formatLong
            let date = Date(timeIntervalSince1970: Double(paste.date)!)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MMM-dd"
            
            nextButton.title = dateFormat.string(from: date)
        }
        
        nextButton.isEnabled = false
        chooseSyntaxButton.isEnabled = false
        codeView.isEditable = false
        
        loadPaste(paste!.key)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if !codeView.text.isEmpty {
            let paste = Paste()
            paste.code = codeView.text
            self.paste = paste
            performSegue(withIdentifier: "ToOptions", sender: self)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ActionPressed(_ sender: Any) {
        var activityItems: [Any] = []
        
        activityItems.append(URL(string: paste!.url)!)
        
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
                optionsVC.paste = paste
                optionsVC.userKey = userKey
            }
        }
    }
}
