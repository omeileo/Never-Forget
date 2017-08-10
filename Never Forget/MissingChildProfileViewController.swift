//
//  MissingChildProfileViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/5/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

class MissingChildProfileViewController: UIViewController
{
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    //Banner
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //About child
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    //Physical attributes
    @IBOutlet weak var hairDescriptionLabel: IndentedLabel!
    @IBOutlet weak var complexionLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: IndentedLabel!
    @IBOutlet weak var eyeColorLabel: IndentedLabel!
    
    //Missing information
    @IBOutlet weak var missingDateLabel: UILabel!
    @IBOutlet weak var missingAddressDistrictLabel: UILabel!
    @IBOutlet weak var missingAddressParishLabel: UILabel!

    var missingChild: MissingChild!
    let homeViewSegueIdentifier = "showHomeViewController"
    let missingChildMapViewSegueIdentifier = "showMissingChildMapViewController"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationBarTitle.title = "\(missingChild.firstName)  \(missingChild.lastName)"
        
        setupBanner()
        
        setupGeneralInformation()
        setupPhysicalAttrtibuteTags()
        setupMissingInformation()
    }
    
    
    
    func setupGeneralInformation()
    {
        firstNameLabel.text = missingChild.firstName
        genderLabel.text = "\(missingChild.gender.rawValue),"
        ageLabel.text = "\(missingChild.age) years old"
        
        if let nickname = missingChild.nickname
        {
            if nickname == ""
            {
                nicknameLabel.isHidden = true
            }
            else
            {
                nicknameLabel.text = "Also Called: \(nickname)"
            }
        }
        else
        {
            nicknameLabel.isHidden = true
        }
    }
    
    func setupPhysicalAttrtibuteTags()
    {
        if let complexion = missingChild.complexion?.rawValue
        {
            if complexion == "Other"
            {
                complexionLabel.isHidden = true
            }
            else
            {
                complexionLabel.text = "\(complexion) Complexion"
            }
        }
        else
        {
            complexionLabel.isHidden = true
        }
        
        if let bodyType = missingChild.bodyType?.rawValue
        {
            if bodyType == "Other"
            {
                bodyTypeLabel.isHidden = true
            }
            else
            {
                bodyTypeLabel.text = "\(bodyType)"
            }
        }
        else
        {
            bodyTypeLabel.isHidden = true
        }
        
        if let height = missingChild.height
        {
            if height == 0
            {
                heightLabel.isHidden = true
            }
            else
            {
                heightLabel.text = "\(height) cm"
            }
        }
        else
        {
            heightLabel.isHidden = true
        }
        
        if let weight = missingChild.weight
        {
            if weight == 0
            {
                weightLabel.isHidden = true
            }
            else
            {
                weightLabel.text = "\(weight) lbs"
            }
        }
        else
        {
            weightLabel.isHidden = true
        }
        
        guard let hairType = missingChild.hairType?.rawValue, let hairColor = missingChild.hairColor?.rawValue else
        {
            hairDescriptionLabel.isHidden = true
            return
        }
        
        var hairTypeString = hairType
        if hairType == "Other"
        {
            hairTypeString = ""
        }
        
        var hairColorString = hairColor
        if hairColor == "Other"
        {
            hairColorString = ""
        }
    
        
        if hairColorString == "" && hairTypeString == ""
        {
            hairDescriptionLabel.isHidden = true
        }
        else
        {
            hairDescriptionLabel.text = "\(hairTypeString) \(hairColorString) Hair"
        }
        
        if let eyeColor = missingChild.eyeColor?.rawValue
        {
            if eyeColor == "Other"
            {
                eyeColorLabel.isHidden = true
            }
            else
            {
                eyeColorLabel.text = "\(eyeColor) Eyes"
            }
        }
        else
        {
            eyeColorLabel.isHidden = true
        }
    }
    
    func setupMissingInformation()
    {
        missingDateLabel.text = missingChild.lastSeenDateString
        missingAddressDistrictLabel.text = missingChild.lastSeenAddressDistrict
        missingAddressParishLabel.text = missingChild.lastSeenAddressParish.rawValue
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: homeViewSegueIdentifier, sender: self)
    }
    
    func setupBanner()
    {
        avatarView.clipsToBounds = false
        avatarView.layer.cornerRadius = avatarView.frame.size.height / 2.0
        avatarView.layer.shadowPath = UIBezierPath(roundedRect: avatarView.bounds, cornerRadius: (avatarView.frame.size.width / 2.0)).cgPath
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 0.5
        avatarView.layer.shadowOffset = CGSize.zero
        avatarView.layer.shadowRadius = 10
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2.0
        avatarImage.clipsToBounds = true
        avatarImage.image = missingChild.profilePicture
        //bannerImage.image =
    }

    @IBAction func showMissingChildOnMap(_ sender: UILabel)
    {
        guard let text = send as? UILabel else
        {
            return
        }
        
        switch text.tag
        {
            case 1, 2, 3: performSegue(withIdentifier: missingChildMapViewSegueIdentifier, sender: self)
            default: return
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
