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
    @IBOutlet weak var hairTypeLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var complexionLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    //Missing information
    @IBOutlet weak var missingDateLabel: UILabel!
    @IBOutlet weak var missingAddressDistrictLabel: UILabel!
    @IBOutlet weak var missingAddressParishLabel: UILabel!

    var missingChild: MissingChild!
    let homeViewSegueIdentifier = "showHomeViewController"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationBarTitle.title = "\(missingChild.firstName)  \(missingChild.lastName)"
        
        setupBanner()
        
        firstNameLabel.text = missingChild.firstName
        genderLabel.text = missingChild.gender.rawValue
        ageLabel.text = "\(missingChild.age)"
        nicknameLabel.text = missingChild.nickname
        
        hairTypeLabel.text = missingChild.hairType?.rawValue
        hairColorLabel.text = missingChild.hairColor?.rawValue
        complexionLabel.text = missingChild.complexion?.rawValue
        heightLabel.text = "\(missingChild.height!) cm"
        
        missingDateLabel.text = missingChild.lastSeenDateString
        missingAddressDistrictLabel.text = missingChild.lastSeenAddressDistrict
        missingAddressParishLabel.text = missingChild.lastSeenAddressParish.rawValue
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //avatarImage.image =
        //bannerImage.image =
        
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
