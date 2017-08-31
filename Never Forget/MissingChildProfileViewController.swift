//
//  MissingChildProfileViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/5/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import FirebaseStorage

var missingChildBannerImageCache = NSCache<NSString, UIImage>()

class MissingChildProfileViewController: UIViewController
{
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    //Banner
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerOverlayView: UIView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarImageDistanceFromTop: NSLayoutConstraint!
    
    @IBOutlet weak var heightOfAvatarView: NSLayoutConstraint!
    @IBOutlet weak var widthOfAvatarView: NSLayoutConstraint!
    
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
    @IBOutlet weak var missingAddressButton: UIButton!

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
        setupPhysicalAttributeTags()
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
    
    func setupPhysicalAttributeTags()
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
        missingAddressButton.setTitle("\(missingChild.lastSeenAddressDistrict), \(missingChild.lastSeenAddressParish.rawValue)", for: .normal)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: homeViewSegueIdentifier, sender: self)
    }
    
    func setupBanner()
    {
        setupAvatar()
        avatarImage.image = missingChild.profilePicture
        
        if let image = missingChildBannerImageCache.object(forKey: missingChild.ID! as NSString)
        {
            self.bannerImage.image = image
        }
        else
        {
            self.retrieveMissingChildPictures(completion: { (image) in
                self.bannerImage.image = image
                missingChildBannerImageCache.setObject(image, forKey: self.missingChild.ID! as NSString)
                
                if self.bannerImage.image == UIImage(named: "Add Missing Child")
                {
                    self.adjustBanner()
                }
            })
        }
    }
    
    func adjustBanner()
    {
        self.avatarImageDistanceFromTop.constant = 20.0
        self.avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.heightOfAvatarView.constant += 100
        self.widthOfAvatarView.constant += 100
        
        self.avatarView.frame.size.width = self.widthOfAvatarView.constant
        self.avatarView.frame.size.height = self.heightOfAvatarView.constant
        self.avatarImage.frame.size.width = self.widthOfAvatarView.constant
        self.avatarImage.frame.size.height = self.heightOfAvatarView.constant
        self.setupAvatar()
        
        self.bannerOverlayView.alpha = 0.95
    }
    
    func setupAvatar()
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
    }
    
    func retrieveMissingChildPictures(completion: @escaping (UIImage) -> ())
    {
        let storageRef = Storage.storage().reference().child("Missing Children Photos").child("\(missingChild.ID!)")
        
        let imageName = "/\(missingChild.ID!)-1.jpg"
        let photoRef = storageRef.child(imageName)
        var image = UIImage(named: "Add Missing Child")
        
        photoRef.getData(maxSize: 5 * 1024 * 1024, completion: { (data, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {
                image = UIImage(data: data!)
            }
            
            completion(image!)
        })
        
    }

    @IBAction func showMissingChildOnMap(_ sender: Any)
    {
        performSegue(withIdentifier: missingChildMapViewSegueIdentifier, sender: missingChild)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == missingChildMapViewSegueIdentifier
        {
            if let missingChildMapViewController = segue.destination as? MissingChildMapViewController, let missingChild = sender as? MissingChild
            {
                missingChildMapViewController.missingChild = missingChild
            }
        }

    }

}
