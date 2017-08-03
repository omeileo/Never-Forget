 //
//  AddMissingChildViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/21/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import EventKit
import FirebaseStorage
import Firebase
 
class AddMissingChildViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var overlayView: UIView!
    
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
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var hairTypeTextField: UITextField!
    @IBOutlet weak var hairColorTextField: UITextField!
    @IBOutlet weak var eyeColorTextField: UITextField!
    @IBOutlet weak var complexionTextField: UITextField!
    @IBOutlet weak var bodyTypeTextField: UITextField!
    
    //Missing Information
    @IBOutlet weak var residingAddressDistrictTextField: UITextField!
    @IBOutlet weak var residingAddressParishTextField: UITextField!
    @IBOutlet weak var lastSeenAddressDistrictTextView: UITextField!
    @IBOutlet weak var lastSeenAddressParishTextView: UITextField!
    @IBOutlet weak var lastSeenDateTextField: UITextField!
    
    //Other Information
    @IBOutlet weak var relationshipTextView: UITextField!
    
    var missingChildPhotos = [MissingChildPhoto]()
    let homeViewSegueIdentifier = "showHomeViewController"
    var ref: DatabaseReference!
    
    let hairTypePickerView = UIPickerView()
    let hairColorPickerView = UIPickerView()
    let eyeColorPickerView = UIPickerView()
    let complexionPickerView = UIPickerView()
    let bodyTypePickerView = UIPickerView()
    let residingAddressParishPickerView = UIPickerView()
    let lastSeenAddressParishPickerView = UIPickerView()
    let lastSeenDateDatePicker = UIDatePicker()
    let relationshipPickerView = UIPickerView()
    
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
        
        setUpBanner()
        femaleGenderLabel.isHighlighted = true
        setDefaultLastSeenDate()
        connectInputFieldsToPickerViews()
        
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func addMissingChildImage(_ sender: UIButton)
    {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (UIAlertAction) in
            self.showPicker(imageSourceType: .photoLibrary)
        }))
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            self.showPicker(imageSourceType: .camera)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showPicker(imageSourceType: UIImagePickerControllerSourceType)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = imageSourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        dismiss(animated: true, completion: nil)
        
        //store image in MissingChildPhoto array; first one gets displayed in avatarImage
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        let photoData = UIImageJPEGRepresentation(photo, 0.8)
        
        missingChildPhotos.append(MissingChildPhoto(photoData: photoData!, photo: photo, ageInPhoto: nil, description: nil))
        
        if missingChildPhotos.count == 1
        {
            self.avatarImage.image = missingChildPhotos.first?.photo
            self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height / 2.0
            self.avatarImage.layer.masksToBounds = true
        }
        
        if missingChildPhotos.count > 1
        {
            counterView.isHidden = false
            counterLabel.isHidden = false
            counterLabel.text = "\(missingChildPhotos.count)"
        }
    }
    
    @IBAction func switchGender(_ sender: UISwitch)
    {
        if genderSwitch.isOn
        {
            if missingChildPhotos.count == 0
            {
                avatarImage.isHighlighted = false
            }
            
            femaleGenderLabel.isHighlighted = true
            maleGenderLabel.isHighlighted = false
        }
        else
        {
            if missingChildPhotos.count == 0
            {
                avatarImage.isHighlighted = true
            }
            
            femaleGenderLabel.isHighlighted = false
            maleGenderLabel.isHighlighted = true
        }
    }
    
    @IBAction func selectMissingDate(_ sender: UITextField)
    {
        let formatter = DateFormatter()
        formatter.calendar = lastSeenDateDatePicker.calendar
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: lastSeenDateDatePicker.date)
        lastSeenDateTextField.text = dateString
    }
    
    @IBAction func reportMissingChild(_ sender: UIButton)
    {
        let gender: Gender
        
        if femaleGenderLabel.isHighlighted
        {
            gender = .female
        }
        else
        {
            gender = .male
        }
        
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let age = ageTextField.text, let lastSeenOn = lastSeenDateTextField.text, let lastSeenAtDistrict = lastSeenAddressDistrictTextView.text, let lastSeenAtParish = Parish(rawValue: lastSeenAddressParishTextView.text!)
        {
            var missingChild = MissingChild(gender: gender, firstName: firstName, lastName: lastName, nickname: nicknameTextField.text, age: Int(age)!, citizenship: citizenshipTextField.text, height: Double(heightTextField.text!), weight: Double(weightTextField.text!), hairType: HairType(rawValue: hairTypeTextField.text!), hairColor: HairColor(rawValue: hairColorTextField.text!), eyeColor: EyeColor(rawValue: eyeColorTextField.text!), complexion: Complexion(rawValue: complexionTextField.text!), bodyType: BodyType(rawValue: bodyTypeTextField.text!), residingAddress: Address(district: residingAddressDistrictTextField.text!, parish: Parish(rawValue: residingAddressParishTextField.text!)!), lastSeenAt: Address(district: lastSeenAtDistrict, parish: lastSeenAtParish), lastSeen: lastSeenOn, missingStatus: MissingStatus.missing)
            
            missingChild.missingChildPhotos = missingChildPhotos
            uploadMissingChildInformationToFirebase(missingChild: missingChild)
            
            // TODO: segue to missing child profile
            
            
            //placeholder
            self.performSegue(withIdentifier: homeViewSegueIdentifier, sender: self)
            
        }
        else
        {
            self.showAlert(title: "Missing Information", message: "Ensure that the name and age of the child as well as there last wearabouts were added (date & place).")
        }
    }
    
    func uploadMissingChildInformationToFirebase(missingChild: MissingChild)
    {
        if let missingChildRef = self.ref?.child("Missing Children").childByAutoId()
        {
            missingChildRef.child("First Name").setValue(missingChild.firstName)
            missingChildRef.child("Last Name").setValue(missingChild.lastName)
            missingChildRef.child("Nickname").setValue(missingChild.nickname)
            missingChildRef.child("Age").setValue(missingChild.age)
            missingChildRef.child("Citizenship").setValue(missingChild.citizenship)
            
            missingChildRef.child("Height").setValue(missingChild.height)
            missingChildRef.child("Weight").setValue(missingChild.weight)
            missingChildRef.child("Hair Type").setValue(missingChild.hairType?.rawValue)
            missingChildRef.child("Hair Color").setValue(missingChild.hairColor?.rawValue)
            missingChildRef.child("Eye Color").setValue(missingChild.eyeColor?.rawValue)
            missingChildRef.child("Complexion").setValue(missingChild.complexion?.rawValue)
            missingChildRef.child("Body Type").setValue(missingChild.bodyType?.rawValue)
            
            missingChildRef.child("Residing Address").child("District").setValue(missingChild.residingAddress?.district)
            missingChildRef.child("Residing Address").child("Parish").setValue(missingChild.residingAddress?.parish.rawValue)
            missingChildRef.child("Last Seen Address").child("District").setValue(missingChild.lastSeenAt.district)
            missingChildRef.child("Last Seen Address").child("Parish").setValue(missingChild.lastSeenAt.parish.rawValue)
            missingChildRef.child("Last Seen Date").setValue(missingChild.lastSeenDateString)
            missingChildRef.child("Missing Status").setValue(missingChild.missingStatus.rawValue)
            
            let childID = missingChildRef.key
            uploadPhotosToFirebaseStorage(missingChildPhotos: missingChild.missingChildPhotos, ID: childID)
        }
    }
    
    func uploadPhotosToFirebaseStorage(missingChildPhotos: [MissingChildPhoto], ID: String)
    {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let missingChildPhotosFolder = storageRef.child("Missing Children Photos").child(ID)
        
        var count = 0
        for photo in missingChildPhotos
        {
            let photoName = "\(ID)-\(count).jpg"
            let photoRef = missingChildPhotosFolder.child(photoName)
            
            count += 1
            print("Count: \("count")")
            
            let uploadTask = photoRef.putData(photo.photoData!, metadata: nil)
            {
                (metadata, error) in
                    guard let metadata = metadata else
                    {
                        return
                    }
                
                    let downloadURL = metadata.downloadURLs
            }
        }
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
