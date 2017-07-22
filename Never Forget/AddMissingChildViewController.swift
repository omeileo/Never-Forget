//
//  AddMissingChildViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/21/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

class AddMissingChildViewController: UIViewController
{
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var maleGenderLabel: UILabel!
    @IBOutlet weak var femaleGenderLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var citizenshipTextField: UITextField!
    
    @IBOutlet weak var hairTypeTextField: UITextField!
    @IBOutlet weak var hairTypePickerView: UIPickerView!
    
    let hairTypes = ["Natural", "Processed", "Locks", "Braids", "Short Cut", "Bald", "Other"]
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideKeyboardWhenTappedOutside()
        self.subscribeToKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func keyboardWillShow(_ notification: Notification)
    {
        resetView()
        
        if firstNameTextField.isFirstResponder || lastNameTextField.isFirstResponder || nicknameTextField.isFirstResponder || ageTextField.isFirstResponder || citizenshipTextField.isFirstResponder
        {
            view.frame.origin.y -= (getKeyboardHeight(notification)/2)
        }
        else
        {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.unsubcribeFromKeyboardNotifcations()
    }
    
    @IBAction func switchGender(_ sender: UISwitch)
    {
    }
    
    @IBAction func reportMissingChild(_ sender: UIButton)
    {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
