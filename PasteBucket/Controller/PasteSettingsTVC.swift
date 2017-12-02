//
//  PasteSettingsTVC.swift
//  PasteBucket
//
//  Created by Rayhan Janam on 12/2/17.
//  Copyright © 2017 Rayhan Janam. All rights reserved.
//

import UIKit

class PasteSettingsTVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var expireField: UITextField!
    @IBOutlet weak var exposureField: UITextField!
    
    let expireData = PasteSettings.pasteExpires
    let exposureData = PasteSettings.pasteExposure
    
    var expirePickerData: [String] {
        var e: [String] = Array()
        
        for time in expireData {
            e.append(time.key)
        }
        
        return e
    }
    
    var exposurePickerData: [String] {
        var e: [String] = Array()
        
        for exposure in exposureData {
            e.append(exposure.key)
        }
        
        return e
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let expirePickerView = UIPickerView()
        expirePickerView.delegate = self
        expirePickerView.tag = 1
        expireField.inputView = expirePickerView
        
        let exposurePickerView = UIPickerView()
        exposurePickerView.delegate = self
        exposurePickerView.tag = 2
        exposureField.inputView = exposurePickerView
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
    
}

























