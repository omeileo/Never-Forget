//
//  MissingChildFeedTableView.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 8/3/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit

extension MissingChildrenFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        missingChildrenFeedTableView.delegate = self
        missingChildrenFeedTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: MissingChildrenFeedTableViewCell = self.missingChildrenFeedTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MissingChildrenFeedTableViewCell
        
        // TODO: set up cell's attributes with data from Firebase
        cell.avatarImageView.image = UIImage(named: "Girl")
        cell.childNameLabel.text = "Ananda Dean"
        cell.missingDateLabel.text = "Jul 16, 2017"
        cell.missingAddressLabel.text = "Half Way Tree, St. Andrew"
        cell.hairTypeLabel.text = "Processed"
        cell.hairColorLabel.text = "Black"
        cell.bodyTypeLabel.text = "Skinny"
        cell.complexionLabel.text = "Dark Brown"
        cell.heightLabel.text = "4\" 11\'"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //segue to Missing Child Page
    }
}

