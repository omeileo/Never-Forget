//
//  AddMissingChildViewController+SetupView.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/5/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase

extension AddMissingChildViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.hideKeyboardWhenTappedOutside()
        self.subscribeToKeyboardNotifications()
        
        setup()
    }
    
    func setup()
    {
        setUpBanner()
        femaleGenderLabel.isHighlighted = true
        setDefaultLastSeenDate()
        connectInputFieldsToPickerViews()
        
        ref = Database.database().reference()
    }
    
    func setUpBanner()
    {
        avatarView.clipsToBounds = false
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 0.5
        avatarView.layer.shadowOffset = CGSize.zero
        avatarView.layer.shadowRadius = 10
        avatarView.layer.shadowPath = UIBezierPath(roundedRect: avatarView.bounds, cornerRadius: (avatarView.frame.size.height/2.0)).cgPath
        avatarView.layer.cornerRadius = avatarView.frame.size.height / 2.0
        
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = avatarView.frame.size.height / 2.0
        
        counterView.clipsToBounds = true
        counterView.layer.cornerRadius = counterView.frame.size.height / 2.0
    }
    
    func setDefaultLastSeenDate()
    {
        let formatter = DateFormatter()
        formatter.calendar = lastSeenDateDatePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: lastSeenDateDatePicker.date)
        lastSeenDateTextField.text = dateString
    }
    
    func connectInputFieldsToPickerViews()
    {
        hairTypePickerView.delegate = self
        hairTypeTextField.inputView = hairTypePickerView
        
        hairColorPickerView.delegate = self
        hairColorTextField.inputView = hairColorPickerView
        
        eyeColorPickerView.delegate = self
        eyeColorTextField.inputView = eyeColorPickerView
        
        complexionPickerView.delegate = self
        complexionTextField.inputView = complexionPickerView
        
        bodyTypePickerView.delegate = self
        bodyTypeTextField.inputView = bodyTypePickerView
        
        residingAddressParishPickerView.delegate = self
        residingAddressParishTextField.inputView = residingAddressParishPickerView
        
        lastSeenAddressParishPickerView.delegate = self
        lastSeenAddressParishTextView.inputView = lastSeenAddressParishPickerView
        
        relationshipPickerView.delegate = self
        relationshipTextView.inputView = relationshipPickerView
        
        lastSeenDateDatePicker.datePickerMode = UIDatePickerMode.date
        lastSeenDateTextField.inputView = lastSeenDateDatePicker
    }
    
    override func resetView() {}
    
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
}
