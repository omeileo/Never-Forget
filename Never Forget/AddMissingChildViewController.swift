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
    let missingChildProfileViewSegueIdentifier = "showMissingChildProfileViewController"
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
            self.avatarImage.isHighlighted = false
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
        
        if genderSwitch.isOn
        {
            gender = .female
        }
        else
        {
            gender = .male
        }
        
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let age = ageTextField.text, let lastSeenOn = lastSeenDateTextField.text, let lastSeenAtDistrict = lastSeenAddressDistrictTextView.text, let lastSeenAtParish = Parish(rawValue: lastSeenAddressParishTextView.text!)
        {
            var missingChild = MissingChild(gender: gender, firstName: firstName, lastName: lastName, age: Int(age)!, lastSeenAt: Address(district: lastSeenAtDistrict, parish: lastSeenAtParish), lastSeenDate: lastSeenOn, missingStatus: MissingStatus.missing)
            
            missingChild.nickname = nicknameTextField.text ?? ""
            missingChild.citizenship = citizenshipTextField.text ?? ""
            missingChild.height = Double(heightTextField.text!) ?? 0.0
            missingChild.weight = Double(weightTextField.text!) ?? 0.0
            missingChild.hairType = HairType(rawValue: hairTypeTextField.text!) ?? HairType.other
            missingChild.hairColor = HairColor(rawValue: hairColorTextField.text!) ?? HairColor.other
            missingChild.eyeColor = EyeColor(rawValue: eyeColorTextField.text!) ?? EyeColor.black
            missingChild.complexion = Complexion(rawValue: complexionTextField.text!) ?? Complexion.other
            missingChild.bodyType = BodyType(rawValue: bodyTypeTextField.text!) ?? BodyType.other
            missingChild.residingAddressDistrict = residingAddressDistrictTextField.text ?? ""
            missingChild.residingAddressParish = Parish(rawValue: residingAddressParishTextField.text!) ?? Parish.notStated
            
            
            if missingChildPhotos.count == 0
            {
                if let photo = UIImage(named: gender.rawValue), let photoData = UIImageJPEGRepresentation(photo, 0.8)
                {
                    missingChild.missingChildPhotos.append(MissingChildPhoto(photoData: photoData, photo: photo, ageInPhoto: nil, description: nil))
                }
            }
            else
            {
                missingChild.missingChildPhotos = missingChildPhotos
            }
            
            uploadMissingChildInformationToFirebase(missingChild: missingChild)
            
            self.performSegue(withIdentifier: missingChildProfileViewSegueIdentifier, sender: missingChild)
        }
        else
        {
            self.showAlert(title: "Missing Information", message: "Ensure that the name and age of the child, as well as their last known whereabouts were added (date & place).")
        }
    }
    
    func uploadMissingChildInformationToFirebase(missingChild: MissingChild)
    {
        if let missingChildRef = self.ref?.child("Missing Children").childByAutoId()
        {
            let childID = missingChildRef.key
            
            missingChildRef.child("gender").setValue(missingChild.gender.rawValue)
            missingChildRef.child("firstName").setValue(missingChild.firstName)
            missingChildRef.child("lastName").setValue(missingChild.lastName)
            missingChildRef.child("nickname").setValue(missingChild.nickname)
            missingChildRef.child("age").setValue(missingChild.age)
            missingChildRef.child("citizenship").setValue(missingChild.citizenship)
            
            missingChildRef.child("height").setValue(missingChild.height)
            missingChildRef.child("weight").setValue(missingChild.weight)
            missingChildRef.child("hairType").setValue(missingChild.hairType?.rawValue)
            missingChildRef.child("hairColor").setValue(missingChild.hairColor?.rawValue)
            missingChildRef.child("eyeColor").setValue(missingChild.eyeColor?.rawValue)
            missingChildRef.child("complexion").setValue(missingChild.complexion?.rawValue)
            missingChildRef.child("bodyType").setValue(missingChild.bodyType?.rawValue)
            
            missingChildRef.child("residingAddressDistrict").setValue(missingChild.residingAddressDistrict)
            missingChildRef.child("residingAddressParish").setValue(missingChild.residingAddressParish?.rawValue)
            missingChildRef.child("lastSeenAddressDistrict").setValue(missingChild.lastSeenAddressDistrict)
            missingChildRef.child("lastSeenAddressParish").setValue(missingChild.lastSeenAddressParish.rawValue)
            missingChildRef.child("lastSeenDate").setValue(missingChild.lastSeenDateString)
            missingChildRef.child("missingStatus").setValue(missingChild.missingStatus.rawValue)
            
            if let user = Auth.auth().currentUser
            {
                let relationship = Relationship(rawValue: self.relationshipTextView.text!) ?? Relationship.none
                let missingChildReport = MissingChildReport(missingChildID: childID, missingChildReporterID: user.uid, relationship: relationship.rawValue)
                
                let missingChildrenReportsRef = self.ref.child("Missing Children Reports").child(childID)
                missingChildrenReportsRef.child("childID").setValue(missingChildReport.missingChildID)
                missingChildrenReportsRef.child("reporterID").setValue(missingChildReport.missingChildReporterID)
                missingChildrenReportsRef.child("relationship").setValue(missingChildReport.relationship.rawValue)
                
                let formatter = DateFormatter()
                formatter.calendar = self.lastSeenDateDatePicker.calendar
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                let dateString = formatter.string(from: Date())
                
                missingChildrenReportsRef.child("dateReported").setValue(dateString)
            }
            
            uploadPhotosToFirebaseStorage(missingChildPhotos: missingChild.missingChildPhotos, childID: childID)
        }
    }
    
    func uploadPhotosToFirebaseStorage(missingChildPhotos: [MissingChildPhoto], childID: String)
    {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        //Storage location that will store actual photos
        let missingChildPhotosFolder = storageRef.child("Missing Children Photos").child(childID)
        
        //Database location that will be used to store photo URLs
        let galleryRef = ref.child("Missing Children Photos").child(childID)
        
        var count = 0
        for photo in missingChildPhotos
        {
            let photoName = "\(childID)-\(count).jpg"
            let photoRef = missingChildPhotosFolder.child(photoName)
            
            if let photoData = photo.photoData
            {
                let uploadTask = photoRef.putData(photoData, metadata: nil)
                {
                    (metadata, error) in
                    guard let metadata = metadata else
                    {
                        return
                    }
                    
                    //upload all image urls to database in separate folder
                    //self.uploadImageURL(galleryRef: galleryRef, metadata: metadata, count: count)
                    
                    //upload individual profile picture url to database
                    self.ref.child("Missing Children").child(childID).child("profilePictureURL").setValue(metadata.downloadURL()?.absoluteString)
                }
            }
            
            print("Count: \(count)")
            count += 1
        }
        
        // TO-DO: figure out how to upload multiple image download-urls to Firebase database right after they are uploaded to Firebase storage
    }
    
    func uploadImageURL(galleryRef: DatabaseReference, metadata: StorageMetadata, count: Int)
    {
        if let downloadURL = metadata.downloadURL()?.absoluteString
        {
            galleryRef.child("Picture-\(count)").setValue(downloadURL)
            print(downloadURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == missingChildProfileViewSegueIdentifier
        {
            if let missingChildProfileViewController = segue.destination as? MissingChildProfileViewController, let missingChild = sender as? MissingChild
            {
                missingChildProfileViewController.missingChild = missingChild
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
