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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var countRows : Int = 0
        
        switch pickerView
        {
            case hairTypePickerView: countRows = self.hairTypes.count
            case hairColorPickerView: countRows = self.hairColors.count
            case eyeColorPickerView: countRows = self.eyeColors.count
            case complexionPickerView: countRows = self.complexions.count
            case bodyTypePickerView: countRows = self.bodyTypes.count
            case residingAddressParishPickerView, lastSeenAddressParishPickerView: countRows = self.parishes.count
            case relationshipPickerView: countRows = self.relationshipTypes.count
            
            default: ()
        }
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView
        {
            case hairTypePickerView: return hairTypes[row]
            case hairColorPickerView: return hairColors[row]
            case eyeColorPickerView: return eyeColors[row]
            case complexionPickerView: return complexions[row]
            case bodyTypePickerView: return bodyTypes[row]
            case residingAddressParishPickerView, lastSeenAddressParishPickerView: return parishes[row]
            case relationshipPickerView: return relationshipTypes[row]
            
            default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView
        {
            case hairTypePickerView: self.hairTypeTextField.text = self.hairTypes[row]
            case hairColorPickerView: self.hairColorTextField.text = self.hairColors[row]
            case eyeColorPickerView: self.eyeColorTextField.text = self.eyeColors[row]
            case complexionPickerView: self.complexionTextField.text = self.complexions[row]
            case bodyTypePickerView: self.bodyTypeTextField.text = self.bodyTypes[row]
            case residingAddressParishPickerView: self.residingAddressParishTextField.text = self.parishes[row]
            case lastSeenAddressParishPickerView: self.lastSeenAddressParishTextView.text = self.parishes[row]
            case relationshipPickerView: self.relationshipTextView.text = self.relationshipTypes[row]
            
            default: ()
        }
        
        view.endEditing(true)
    }
}
