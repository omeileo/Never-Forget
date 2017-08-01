//
//  AddMissingChildViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/21/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import EventKit

class AddMissingChildViewController: UIViewController
{
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //General Information
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var maleGenderLabel: UILabel!
    @IBOutlet weak var femaleGenderLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var citizenshipTextField: UITextField!
    
    //Physical Attributes
    @IBOutlet weak var hairTypeTextField: UITextField!
    @IBOutlet weak var hairTypePickerView: UIPickerView!
    @IBOutlet weak var hairColorTextField: UITextField!
    @IBOutlet weak var hairColorPickerView: UIPickerView!
    @IBOutlet weak var eyeColorTextField: UITextField!
    @IBOutlet weak var eyeColorPickerView: UIPickerView!
    @IBOutlet weak var complexionTextField: UITextField!
    @IBOutlet weak var complexionPickerView: UIPickerView!
    @IBOutlet weak var bodyTypeTextField: UITextField!
    @IBOutlet weak var bodyTypePickerView: UIPickerView!
    
    //Missing Information
    @IBOutlet weak var residingAddressDistrictTextField: UITextField!
    @IBOutlet weak var residingAddressParishTextField: UITextField!
    @IBOutlet weak var residingAddressParishPickerView: UIPickerView!
    @IBOutlet weak var lastSeenAddressDistrictTextView: UITextField!
    @IBOutlet weak var lastSeenAddressParishTextView: UITextField!
    @IBOutlet weak var lastSeenAddressParishPickerView: UIPickerView!
    @IBOutlet weak var lastSeenDateTextField: UITextField!
    @IBOutlet weak var lastSeenDateDatePicker: UIDatePicker!
    
    //Other Information
    @IBOutlet weak var relationshipTextView: UITextField!
    @IBOutlet weak var relationshipPickerView: UIPickerView!
    
    let hairTypes = [HairType.natural.rawValue, HairType.processed.rawValue, HairType.locks.rawValue, HairType.braid.rawValue, HairType.shortCut.rawValue, HairType.bald.rawValue]
    let hairColors = [HairColor.black.rawValue, HairColor.darkBrown.rawValue, HairColor.lightBrown.rawValue, HairColor.blond.rawValue, HairColor.colored.rawValue, HairColor.multiColored.rawValue, HairColor.other.rawValue]
    let eyeColors = [EyeColor.black.rawValue, EyeColor.blue.rawValue, EyeColor.darkBrown.rawValue, EyeColor.lightBrown.rawValue, EyeColor.green.rawValue, EyeColor.grey.rawValue]
    let complexions = [Complexion.darkBrown.rawValue, Complexion.lightBrown.rawValue, Complexion.fair.rawValue]
    let bodyTypes = [BodyType.slim.rawValue, BodyType.skinny.rawValue, BodyType.chubby.rawValue, BodyType.fat.rawValue, BodyType.muscular.rawValue]
    let parishes = [Parish.andrew.rawValue, Parish.ann.rawValue, Parish.catherine.rawValue, Parish.clarendon.rawValue, Parish.elizabeth.rawValue, Parish.hanover.rawValue, Parish.james.rawValue, Parish.kingston.rawValue, Parish.manchester.rawValue, Parish.mary.rawValue, Parish.portland.rawValue, Parish.thomas.rawValue, Parish.trelawny.rawValue, Parish.westmoreland.rawValue]
    let relationshipTypes = [Relationship.mother.rawValue, Relationship.father.rawValue, Relationship.guardian.rawValue, Relationship.sibling.rawValue, Relationship.aunt.rawValue, Relationship.uncle.rawValue, Relationship.grandmother.rawValue, Relationship.grandfather.rawValue, Relationship.other.rawValue, Relationship.none.rawValue]
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideKeyboardWhenTappedOutside()
        self.subscribeToKeyboardNotifications()
        
        femaleGenderLabel.isHighlighted = true
<<<<<<< HEAD
        self.navigationController?.setNavigationBarHidden(true, animated: true)
=======
        
        let formatter = DateFormatter()
        formatter.calendar = lastSeenDateDatePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: lastSeenDateDatePicker.date)
        lastSeenDateTextField.text = dateString
>>>>>>> navigation-bar-experimenting
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
        else
        {
            scrollView.frame.origin.y -= (getKeyboardHeight(notification)/4)
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
    
    @IBAction func selectMissingDate(_ sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.calendar = lastSeenDateDatePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: lastSeenDateDatePicker.date)
        lastSeenDateTextField.text = dateString
        
        lastSeenDateDatePicker.isHidden = true
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
