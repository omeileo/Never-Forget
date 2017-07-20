//
//  UIViewController+Utils.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func showAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
