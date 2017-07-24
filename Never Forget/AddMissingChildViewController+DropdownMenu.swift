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
        var countRows: Int
        
        switch pickerView
        {
            case hairTypePickerView: countRows = hairTypes.count
            case hairColorPickerView: countRows = hairColors.count
            default: countRows = 0
        }
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == hairTypePickerView
        {
            let titleRow = hairTypes[row]
            
            return titleRow
        }
        else if pickerView == hairColorPickerView
        {
            let titleRow = hairColors[row]
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView
        {
            case hairTypePickerView:
                self.hairTypeTextField.text = self.hairTypes[row]
                self.hairTypePickerView.isHidden = true
            
            case hairColorPickerView:
                self.hairColorTextField.text = self.hairColors[row]
                self.hairColorPickerView.isHidden = true
            
            default: ()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.hairTypePickerView.isHidden = false
        self.hairColorPickerView.isHidden = false
        hairTypeTextField.endEditing(true)
        hairColorTextField.endEditing(true)
    }
}
