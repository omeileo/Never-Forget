//
//  AddMissingChildViewController+DropdownMenu.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/22/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension AddMissingChildViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        let countRows: Int = hairTypes.count
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == hairTypePickerView
        {
            let titleRow = hairTypes[row]
            
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.hairTypeTextField.text = self.hairTypes[row]
        self.hairTypePickerView.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.hairTypePickerView.isHidden = false
        //hairTypeTextField.endEditing(true)
    }
}
