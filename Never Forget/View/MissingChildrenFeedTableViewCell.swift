//
//  MissingChildFeedTableViewCell.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/3/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

class MissingChildrenFeedTableViewCell: UITableViewCell
{
    //Image
    @IBOutlet weak var avatarUIView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //Info
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var missingDateLabel: UILabel!
    @IBOutlet weak var missingAddressLabel: UILabel!
    
    //Tags
    @IBOutlet weak var hairDescriptionLabel: IndentedLabel!
    @IBOutlet weak var complexionLabel: UILabel!
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
}
