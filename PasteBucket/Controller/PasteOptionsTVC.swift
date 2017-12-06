//
//  PasteSettingsTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/2/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PasteOptionsTVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var operation: PasteOperation?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var expireField: UITextField!
    @IBOutlet weak var exposureField: UITextField!
    @IBOutlet weak var pasteActionButton: UIButton!
    
    let expireData = PasteOptions.pasteExpires
    let exposureData = PasteOptions.pasteExposure
    
    var expirePickerData: [String] {
        var e: [String] = Array()
        
        for time in expireData {
            e.append(time.key)
        }
        
        return e.sorted()
    }
    
    var exposurePickerData: [String] {
        var e: [String] = Array()
        
        for exposure in exposureData {
            e.append(exposure.key)
        }
        
        return e.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height / 6,
                                              width: self.view.frame.size.width,
                                              height: 44.0))
        toolbar.layer.position = CGPoint(x: self.view.frame.size.width / 2,
                                         y: self.view.frame.size.height - 20.0)
        toolbar.barStyle = .default
        toolbar.tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        toolbar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let flexspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(donePressed))
        toolbar.setItems([flexspace, doneButton], animated: true)
        
        let expirePickerView = UIPickerView()
        expirePickerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        expirePickerView.delegate = self
        expirePickerView.tag = 1
        expireField.inputView = expirePickerView
        expireField.inputAccessoryView = toolbar
        
        let exposurePickerView = UIPickerView()
        exposurePickerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        exposurePickerView.delegate = self
        exposurePickerView.tag = 2
        exposureField.inputView = exposurePickerView
        exposureField.inputAccessoryView = toolbar
        
        titleField.inputAccessoryView = toolbar
        
        if let operation = operation {
            if operation == .create {
                self.pasteActionButton.setTitle("CREATE NEW PASTE", for: .normal)
            } else if operation == .edit {
                self.pasteActionButton.setTitle("SAVE CHANGES", for: .normal)
                self.pasteActionButton.setTitleColor(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1), for: .normal)
            }
        }
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        if expireField.isFirstResponder {
            expireField.resignFirstResponder()
        } else if exposureField.isFirstResponder {
            exposureField.resignFirstResponder()
        } else if titleField.isFirstResponder {
            titleField.resignFirstResponder()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return expirePickerData.count
        } else if pickerView.tag == 2 {
            return exposurePickerData.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return expirePickerData[row]
        } else if pickerView.tag == 2 {
            return exposurePickerData[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            expireField.text = expirePickerData[row]
        } else if pickerView.tag == 2 {
            exposureField.text = exposurePickerData[row]
        }
    }
    
    @IBAction func createPastePressed(_ sender: Any) {
        // TODO
        
        dismiss(animated: true, completion: nil)
    }
    
    
}

























