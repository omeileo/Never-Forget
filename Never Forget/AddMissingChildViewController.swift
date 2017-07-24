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
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    @IBOutlet weak var hairColorTextField: UITextField!
    @IBOutlet weak var hairColorPickerView: UIPickerView!
    
    let hairTypes = ["Natural", "Processed", "Locks", "Braids", "Short Cut", "Bald", "Other"]
    let hairColors = ["Black", "Dark Brown", "Light Brown", "Multicolored", "Blond", "Other"]
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideKeyboardWhenTappedOutside()
        self.subscribeToKeyboardNotifications()
        femaleGenderLabel.isHighlighted = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func keyboardWillShow(_ notification: Notification)
    {
        resetView()
        
        if !(firstNameTextField.isFirstResponder || lastNameTextField.isFirstResponder)
        {
            scrollView.frame.origin.y -= (getKeyboardHeight(notification)/2)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.unsubcribeFromKeyboardNotifcations()
    }
    
    @IBAction func switchGender(_ sender: UISwitch)
    {
        if genderSwitch.isOn
        {
            avatarImage.isHighlighted = false
            femaleGenderLabel.isHighlighted = true
            maleGenderLabel.isHighlighted = false
        }
        else
        {
            avatarImage.isHighlighted = true
            femaleGenderLabel.isHighlighted = false
            maleGenderLabel.isHighlighted = true
        }
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
