//
//  RegisterViewController.swift
//  Never Forget
//
//  Created by Jase-Omeileo West on 7/20/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class RegisterViewController: UIViewController
{
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let addMissingChildViewDegueIdentifier = "showAddMissingChildViewController"
    
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerUser(_ sender: UIButton)
    {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
        let password = passwordTextField.text
        {
            Auth.auth().createUser(withEmail: email, password: password)
            {
                (user, error) in
                if error == nil
                {
                    //save email and password to keychain
                    let _ = KeychainWrapper.standard.set(email, forKey: "neverForgetUserEmail")
                    let _ = KeychainWrapper.standard.set(password, forKey: "neverForgetUserPassword")
                    
                    //save first name and last name to firebase
                    self.ref = Database.database().reference()
                    
                    self.performSegue(withIdentifier: self.addMissingChildViewDegueIdentifier, sender: self)
                }
                else
                {
                    self.showAlert(title: "Error", message: "Insufficient information provided for registration. Please fill out all fields.")
                }
            }
        }
    }

    @IBAction func loginUser(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated: true)
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
